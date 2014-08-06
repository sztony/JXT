//
//  FetchAreaBaseTableVC.h
//  JXT
//
//  Created by 伍 兵 on 14-8-6.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FetchAreaBaseTableVC : UITableViewController
{
    GlobalDataManager* dataCenter;
    NSMutableArray* dataArray;
    NSString* areaID;
}
-(void)dataInit;
@property(nonatomic,retain) NSString* areaID;
@end
