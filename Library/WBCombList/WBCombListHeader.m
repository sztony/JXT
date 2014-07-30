//
//  WBCombListHeader.m
//  WBCombList
//
//  Created by 伍 兵 on 14-7-30.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "WBCombListHeader.h"

@implementation WBCombListHeader
@synthesize rightImage;
-(void)setRightImage:(UIImage *)aRightImage
{
    if(rightImage!=aRightImage)
    {
        [rightImage release];
        rightImage= [aRightImage retain];
        
        
        CGSize size=self.bounds.size;
        UIImageView* rightImageView=[[UIImageView alloc] initWithFrame:CGRectMake(size.width-RIGHT_IMAGE_PECENT_OF_HEIGHT*size.height, (1-RIGHT_IMAGE_PECENT_OF_HEIGHT)/2.0*size.height, RIGHT_IMAGE_PECENT_OF_HEIGHT*size.height, RIGHT_IMAGE_PECENT_OF_HEIGHT*size.height)];
        //rightImageView.contentMode=UIViewContentModeCenter;
        //rightImageView.layer.borderColor=[UIColor redColor].CGColor;
        //rightImageView.layer.borderWidth=1;
        rightImageView.image=rightImage;
        [self addSubview:rightImageView];
        [rightImageView release];
    }
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
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
