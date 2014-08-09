//
//  RegisterFollowTeacherCell.m
//  JXT
//
//  Created by 伍 兵 on 14-8-9.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "RegisterFollowTeacherCell.h"

@implementation RegisterFollowTeacherCell
@synthesize checkBox;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        [[NSNotificationCenter defaultCenter] addObserverForName:Select_All_Teacher_Notification object:nil queue:[[GlobalDataManager sharedDataManager] globalTaskQueue] usingBlock:^(NSNotification *note) {
           WBCheckBox* aCheckBox=(WBCheckBox*)[note object];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.checkBox.isChecked=aCheckBox.isChecked;
            });
        }];
    }
    return self;
}
-(void)checkBoxClicked:(WBCheckBox*)aCheckBox
{
    aCheckBox.isChecked=!aCheckBox.isChecked;
    NSLog(@"tag:%d",aCheckBox.tag);
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [checkBox release];
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
