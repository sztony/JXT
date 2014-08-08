//
//  FetchFollowVC.h
//  JXT
//
//  Created by 伍 兵 on 14-8-8.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "FollowBaseVC.h"

@interface FetchFollowVC : FollowBaseVC<FollowSubjectContainerDelegate>
{
    IBOutlet WBCheckBox* checkBox1;
    IBOutlet WBCheckBox* checkBox2;
    IBOutlet UILabel* btnTitleLabel;
}
@end
