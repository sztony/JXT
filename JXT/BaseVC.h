//
//  BaseVC.h
//  JXT
//
//  Created by 伍 兵 on 14-7-22.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBSegment.h"
#import "WBCombList.h"
#import "RootVC.h"
@interface BaseVC : RootVC<WBSegmentDelegate,WBCombListDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet  WBSegment * segment;//一级标签
    IBOutlet  WBCombListHeader * header1;//二级标签
    IBOutlet  WBCombListHeader * header2;
    IBOutlet  WBCombListHeader * header3;
    
    
     IBOutlet UITableView* contentTableView;//内容数据table
    WBCombListHeader* currentClickedHeader;
     NSInteger segmentSelectIndexInitValue;//segment初始选中值
}
-(void)dataInit;
-(void)refreshHeader;
-(void)headerClicked:(WBCombListHeader*)aHeader;

@property(nonatomic,retain) NSMutableArray* headerTitleArray;
@property(nonatomic,retain) NSMutableArray* currentCombListItemArray;
@property(nonatomic,retain) NSMutableArray* contentDataArray;
@end
