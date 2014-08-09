//
//  RegisterFollowTeacherCell.h
//  JXT
//
//  Created by 伍 兵 on 14-8-9.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "FollowBaseCell.h"
#import "WBCheckBox.h"
@interface RegisterFollowTeacherCell : FollowBaseCell
{
    IBOutlet WBCheckBox * checkBox;
}
-(void)checkBoxClicked:(WBCheckBox*)aCheckBox;
@property(nonatomic,retain) IBOutlet WBCheckBox* checkBox;
@end
