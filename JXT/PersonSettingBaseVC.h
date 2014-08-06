//
//  PersonSettingBaseVC.h
//  JXT
//
//  Created by 伍 兵 on 14-8-5.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootVC.h"
@interface PersonSettingBaseVC : RootVC
{
    IBOutlet UITextField* field;
    IBOutlet UIButton * sureBtn;
    
    IBOutlet UILabel* alertLabel;
}
@end
