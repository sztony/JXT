//
//  SchoolLessonCell.h
//  JXT
//
//  Created by 伍 兵 on 14-8-2.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolLessonCustomCell : UITableViewCell
{
    IBOutlet UILabel* subjectTitle;
    IBOutlet UILabel* subjectContent;
   
}
@property(nonatomic,retain) IBOutlet UILabel* subjectTitle;
@property(nonatomic,retain) IBOutlet UILabel* subjectContent;
@end
