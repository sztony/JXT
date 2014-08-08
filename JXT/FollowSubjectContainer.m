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
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)dataInit
{
    width=self.frame.size.width;
    height=self.frame.size.height;
    subjectsArray =[[NSMutableArray alloc] initWithCapacity:0];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        [self dataInit];
    }
    return self;
}
-(void)updateSubjectsArrayWithArray:(NSArray*)aArray
{
    [subjectsArray removeAllObjects];
    [subjectsArray addObjectsFromArray:aArray];
    
    [self layoutCheckBox];
}
-(void)allCheck:(BOOL)isCheck
{
    for(WBCheckBox* box in self.subviews)
    {
        box.isChecked=isCheck;
    }
}
-(NSString*)allValueString
{
    NSMutableString* valueString=[[NSMutableString alloc] init];
    for(WBCheckBox* box in self.subviews)
    {
        //if(box.isChecked)
        {
            [valueString appendString:@","];
            [valueString appendFormat:@"%d",box.tag];
        }
        
    }
    
    NSString* needString=@"";
    if(valueString.length>0)
        needString=[valueString substringFromIndex:1];
    [valueString release];
    NSLog(@"allValueString:%@",needString);
    return needString;
}
-(NSString*)valueString
{
    NSMutableString* valueString=[[NSMutableString alloc] init];
    for(WBCheckBox* box in self.subviews)
    {
        if(box.isChecked)
        {
            [valueString appendString:@","];
            [valueString appendFormat:@"%d",box.tag];
        }
        
    }
    
    NSString* needString=@"";
    if(valueString.length>0)
        needString=[valueString substringFromIndex:1];
    [valueString release];
    NSLog(@"needString:%@",needString);
    return needString;
}
-(void)layoutCheckBox
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for(int i=0;i<subjectsArray.count;i++)
    {
        NSDictionary* aDict=[subjectsArray objectAtIndex:i];
        NSString * title=[aDict objectForKey:@"subjectName"];
        NSString * subjectID=[aDict objectForKey:@"subjectId"];
        NSString * status =[aDict objectForKey:@"followStatus"];
        CGFloat x=20+(i%5)*(30+18);
        CGFloat y=20+i/5*40;
        WBCheckBox* checkBox=[[WBCheckBox alloc] initWithFrame:CGRectMake(x, y, 40, 15)];
        checkBox.title=title;
        checkBox.tag=[subjectID intValue];
        [checkBox addTarget:self action:@selector(check:) forControlEvents:UIControlEventValueChanged];
        //checkBox.borderColor=[UIColor grayColor];
        checkBox.isChecked=[status isEqualToString:@"1"]?YES:NO;
        checkBox.fillColor=MAIN_COLOR;
        [self addSubview:checkBox];
        [checkBox release];
    }
}
-(void)check:(WBCheckBox*)arg
{
    //NSLog(@"check:%d",arg.isChecked);
    arg.isChecked=!arg.isChecked;
    
    if([delegate respondsToSelector:@selector(SubjectContainerClickedCheckBox:)])
    {
        [delegate SubjectContainerClickedCheckBox:arg];
    }
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
