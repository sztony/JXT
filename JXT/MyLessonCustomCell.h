//
//  MyLessonCustomCell.h
//  JXT
//
//  Created by 伍 兵 on 14-8-2.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLessonCustomCell : UITableViewCell
{
    IBOutlet UIImageView* subjectImage;
    IBOutlet UILabel* subjectTitle;
    IBOutlet UILabel* subjectTeacher;
    IBOutlet UILabel* subjectTime;
}
@property(nonatomic,retain) IBOutlet UIImageView * subjectImage;
@property(nonatomic,retain) IBOutlet UILabel* subjectTitle;
@property(nonatomic,retain) IBOutlet UILabel* subjectTeacher;
@property(nonatomic,retain) IBOutlet UILabel* subjectTime;

@end
