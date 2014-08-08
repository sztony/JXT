//
//  FollowVC.h
//  JXT
//
//  Created by 伍 兵 on 14-8-5.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "FollowBaseVC.h"

@interface FollowVC : FollowBaseVC<FollowSubjectContainerDelegate>
{
    IBOutlet WBCheckBox* checkBox;
    IBOutlet UIButton* addBtn;
}
@end
