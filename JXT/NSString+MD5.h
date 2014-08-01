//
//  NSString+MD5.h
//  JXT
//
//  Created by 伍 兵 on 14-7-30.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface NSString (MD5)
- (NSString *)MD5String;
@end
