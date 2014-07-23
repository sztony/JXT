//
//  BaseVC.h
//  JXT
//
//  Created by 伍 兵 on 14-7-22.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBSegment.h"
@interface BaseVC : UIViewController<WBSegmentDelegate>
{
    WBSegment * segment;
}
@end
