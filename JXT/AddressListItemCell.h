//
//  AddressListItemCell.h
//  JXT
//
//  Created by 伍 兵 on 14-8-5.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressListItemCell : UITableViewCell
{
    IBOutlet UIImageView* headImageView;
    IBOutlet UILabel* nameLabel;
    IBOutlet UILabel* phoneLabel;
}
@property(nonatomic, retain) IBOutlet UIImageView* headImageView;
@property(nonatomic, retain) IBOutlet UILabel* nameLabel;
@property(nonatomic, retain) IBOutlet UILabel* phoneLabel;
@end
