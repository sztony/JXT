//
//  MyLessonCustomCell.h
//  JXT
//
//  Created by 伍 兵 on 14-8-2.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLessonBaseCell.h"
@interface MyLessonVideoCell : MyLessonBaseCell
{
    IBOutlet UILabel* subjectTime;
}

@property(nonatomic,retain) IBOutlet UILabel* subjectTime;
@end
