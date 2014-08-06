//
//  SettingsVC.h
//  JXT
//
//  Created by 伍 兵 on 14-7-19.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsVC : UITableViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    IBOutlet UIImageView* headerImageView;
    IBOutlet UILabel * nameLabel;
    IBOutlet UILabel * acountID;
}
@end
