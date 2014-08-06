//
//  OrderListCell.h
//  JXT
//
//  Created by 伍 兵 on 14-8-6.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListCell : UITableViewCell
{
    IBOutlet UIImageView* subjectImageView;
    IBOutlet UILabel* subjectTitle;
    IBOutlet UILabel* subjectBuyTime;
    IBOutlet UILabel* subjectPrice;
}
@property(nonatomic,retain) IBOutlet UIImageView* subjectImageView;
@property(nonatomic,retain) IBOutlet UILabel* subjectTitle;
@property(nonatomic,retain) IBOutlet UILabel* subjectBuyTime;
@property(nonatomic,retain) IBOutlet UILabel* subjectPrice;

@end
