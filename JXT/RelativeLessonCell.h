//
//  RelativeLessonCell.h
//  JXT
//
//  Created by 伍 兵 on 14-8-10.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RelativeLessonCell : UICollectionViewCell
{
    IBOutlet UIImageView* subjectImageView;
    IBOutlet UILabel* subjectName;
}
@property(nonatomic,retain) IBOutlet UIImageView* subjectImageView;
@property(nonatomic,retain) IBOutlet UILabel* subjectName;
@end
