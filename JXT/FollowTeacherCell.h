//
//  FollowTeacherCell.h
//  JXT
//
//  Created by 伍 兵 on 14-8-9.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "FollowBaseCell.h"

@interface FollowTeacherCell : FollowBaseCell
{
    IBOutlet UILabel* schoolLabel;
    IBOutlet UILabel* btnLabel;
}
@property(nonatomic,retain )IBOutlet UILabel* schoolLabel;
@property(nonatomic,retain )IBOutlet UILabel* btnLabel;
-(void)btnLabelTapped:(UITapGestureRecognizer*)sender;
@end
