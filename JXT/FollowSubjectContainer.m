//
//  FollowSubjectContainer.m
//  JXT
//
//  Created by 伍 兵 on 14-8-5.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "FollowSubjectContainer.h"
@interface FollowSubjectContainer()
{
    CGFloat width;
    CGFloat height;
}
@end
@implementation FollowSubjectContainer

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)layoutCheckBox
{
   
     NSArray* subjects=@[@"语文",@"数学",@"外语",@"物理",@"化学",@"生物",@"历史",@"政治",@"地理"];
    for(int i=0;i<9;i++)
    {
        CGFloat x=20+(i%5)*(40+10);
        CGFloat y=20+i/5*40;
        WBCheckBox* checkBox=[[WBCheckBox alloc] initWithFrame:CGRectMake(x, y, 40, 20) andTitle:[subjects objectAtIndex:i] fontSize:15 checkBoxType:kCheckBoxTypeRect];
        [checkBox addTarget:self action:@selector(check:) forControlEvents:UIControlEventTouchUpOutside];
        //checkBox.borderColor=[UIColor grayColor];
        checkBox.fillColor=MAIN_COLOR;
        [self addSubview:checkBox];
        [checkBox release];
    }
}
-(void)check:(WBCheckBox*)arg
{
    //NSLog(@"check:%d",arg.isChecked);
    arg.isChecked=!arg.isChecked;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        width=self.frame.size.width;
        height=self.frame.size.height;
        [self layoutCheckBox];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
