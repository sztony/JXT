//
//  FollowBaseCell.m
//  JXT
//
//  Created by 伍 兵 on 14-8-9.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "FollowBaseCell.h"

@implementation FollowBaseCell
@synthesize headImageView;
@synthesize nameLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)dealloc
{
    [headImageView release];
    [nameLabel release];
    [super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
