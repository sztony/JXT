//
//  SchoolMsgCell.h
//  JXT
//
//  Created by 伍 兵 on 14-8-5.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolMsgCell : UITableViewCell
{
    IBOutlet UILabel* nameLabel;
    IBOutlet UILabel* timeLabel;
    IBOutlet UILabel* contentLabel;
}
@property(nonatomic,retain) IBOutlet UILabel* nameLabel;
@property(nonatomic,retain) IBOutlet UILabel* timeLabel;
@property(nonatomic,retain) IBOutlet UILabel* contentLabel;
@end
