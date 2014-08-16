//
//  MyLessonTextCell.m
//  JXT
//
//  Created by 伍 兵 on 14-8-10.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "MyLessonTextCell.h"

@implementation MyLessonTextCell
@synthesize downloadBtn;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(IBAction)downloadBtnClicked:(UIButton*)sender
{
    NSLog(@"path:%@",[sender titleForState:UIControlStateNormal]);
}
-(void)dealloc
{
    [downloadBtn  release];
    [super dealloc];
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
