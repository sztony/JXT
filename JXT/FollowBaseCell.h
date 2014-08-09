//
//  FollowBaseCell.h
//  JXT
//
//  Created by 伍 兵 on 14-8-9.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FollowBaseCell : UICollectionViewCell
{
    IBOutlet UIImageView* headImageView;
    IBOutlet UILabel* nameLabel;
}
@property(nonatomic,retain) IBOutlet UIImageView * headImageView;
@property(nonatomic,retain) IBOutlet UILabel* nameLabel;
@end
