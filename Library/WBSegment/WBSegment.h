//
//  WBVerticalSegment.h
//  WBVerticalSegment
//
//  Created by 伍 兵 on 13-4-6.
//  Copyright (c) 2013年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"

typedef enum
{
    kWBSegmentHorizonal,
    kWBSegmentVertical
}WBSegmentDirection;


@class WBSegment;
@protocol  WBSegmentDelegate<NSObject>
-(void)WBSegment:(WBSegment*)segment DidSelectedItemIndex:(NSInteger)index;
@end



@interface WBSegment : UIView
{
    CGFloat width;
    CGFloat height;
    NSMutableArray * titleArray;
    NSInteger borderGap;
    NSInteger currentSelectedIndex;
    UIColor * selectedColor;
    UIColor * normalColor;
    WBSegmentDirection segmentDirection;
    id<WBSegmentDelegate> delegate;
}
- (id)initWithFrame:(CGRect)frame titleArray:(NSArray*)aTitleArray normalColor:(UIColor*)aNormalColor directionVertical:(BOOL)aIsVertical;
-(void)setTitleArray:(NSArray*)aTitleArray;
@property(nonatomic,assign)  WBSegmentDirection segmentDirection;
@property(nonatomic,assign) NSInteger currentSelectedIndex;
@property(nonatomic,assign) id<WBSegmentDelegate> delegate;
@property(nonatomic,retain) UIColor * selectedColor;
@property(nonatomic,retain)  UIColor * normalColor;
@end
