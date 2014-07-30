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
@interface BaseVC : UIViewController<WBSegmentDelegate,WBCombListDelegate>
{
    WBSegment * segment;
    IBOutlet  WBCombListHeader * header1;
    IBOutlet  WBCombListHeader * header2;
    IBOutlet  WBCombListHeader * header3;

    
}
-(void)refreshHeader;
-(void)headerClicked:(WBCombListHeader*)aHeader;
@property(nonatomic,retain) NSMutableArray* headerTitleArray;
@end
