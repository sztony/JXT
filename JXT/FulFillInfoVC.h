//
//  FulFillInfoVC.h
//  JXT
//
//  Created by 伍 兵 on 14-7-29.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBCombListHeader.h"
#import "LoginBaseVC.h"
#import "WBCombList.h"
@interface FulFillInfoVC : LoginBaseVC<WBCombListDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet WBCombListHeader* gradeHead;
    IBOutlet WBCombListHeader* schoolHead;
    IBOutlet UILabel* statusLabel;
}
@end
