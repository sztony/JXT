//
//  RegisterVC.h
//  JXT
//
//  Created by 伍 兵 on 14-7-23.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginBaseVC.h"
@interface RegisterVC : LoginBaseVC
{
    IBOutlet UITextField * nameField;
    IBOutlet UITextField * passwordField;
    IBOutlet UITextField * phoneNumField;
    IBOutlet UITextField * vertifyNumField;
    IBOutlet UILabel* statusLabel;
}
@end
