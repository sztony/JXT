//
//  MyLessonVC.h
//  JXT
//
//  Created by 伍 兵 on 14-7-19.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"
#import "SchoolLessonCustomCell.h"
#import "MyLessonVideoCell.h"
#import "MyLessonTextCell.h"
#import "HomeWorkTopView.h"
#import "RelativeLessonCell.h"
@interface MyLessonVC : BaseVC<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray* relativeLessonArray;
    
    IBOutlet UICollectionView* footerView;
}
//保存每个header的当前所选的项目的id值，以便查询
@property(nonatomic ,retain) NSString* header1ID,* header2ID,*header3ID;
@end
