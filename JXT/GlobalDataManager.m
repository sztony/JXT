//
//  GlobalDataManager.m
//  JXT
//
//  Created by 伍 兵 on 14-7-29.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "GlobalDataManager.h"
static GlobalDataManager* m;
@implementation GlobalDataManager
@synthesize globalTaskQueue;
@synthesize userID,userMobile,userRealName,userNickName,userPic,userBigPic,userSchoolName;
+(id)sharedDataManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m= [[GlobalDataManager alloc] init];
    });
    return m;
}
-(id)init
{
    self=[super init];
    if(self)
    {
        globalTaskQueue=[[NSOperationQueue alloc] init];
    }
    return self;
}
@end
