//
//  MyLessonCustomCell.m
//  JXT
//
//  Created by 伍 兵 on 14-8-2.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "MyLessonCustomCell.h"

@implementation MyLessonCustomCell
@synthesize subjectImage;
@synthesize subjectTitle,subjectTeacher,subjectTime;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
