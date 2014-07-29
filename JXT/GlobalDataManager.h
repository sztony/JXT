//
//  GlobalDataManager.h
//  JXT
//
//  Created by 伍 兵 on 14-7-29.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalDataManager : NSObject

+(id)sharedDataManager;
@property(nonatomic,retain) NSOperationQueue* globalTaskQueue;
@end
