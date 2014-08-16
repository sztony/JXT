//
//  MyLessonTextCell.h
//  JXT
//
//  Created by 伍 兵 on 14-8-10.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "MyLessonBaseCell.h"

@interface MyLessonTextCell : MyLessonBaseCell
{
    IBOutlet UIButton* downloadBtn;
}
@property(nonatomic,retain)IBOutlet UIButton* downloadBtn;
@end
