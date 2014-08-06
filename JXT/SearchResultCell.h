//
//  SearchResultCell.h
//  JXT
//
//  Created by 伍 兵 on 14-8-5.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultCell : UITableViewCell
{
    IBOutlet UILabel* titleLable;
    IBOutlet UILabel* detailLabel;
    IBOutlet UIImageView * imageView;
}
@property(nonatomic,retain)IBOutlet UILabel* titleLable;
@property(nonatomic,retain)IBOutlet UILabel* detailLabel;
@property(nonatomic,retain)IBOutlet UIImageView * imageView;
@end
