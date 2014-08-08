//
//  FollowBaseVC.h
//  JXT
//
//  Created by 伍 兵 on 14-8-8.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "RootVC.h"
#import "FollowSubjectContainer.h"
@interface FollowBaseVC : RootVC<UICollectionViewDataSource,UICollectionViewDelegate>
{
    IBOutlet FollowSubjectContainer * subjectsContainer;
    IBOutlet UICollectionView*  teacherContainer;
    NSMutableArray* subjectsArray;
    NSMutableArray* teachersArray;
}
@property(nonatomic,retain) NSString* schoolId;
@property(nonatomic,retain) NSString* phaseId;
@end
