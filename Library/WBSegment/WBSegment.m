//
//  WBVerticalSegment.m
//  WBVerticalSegment
//
//  Created by 伍 兵 on 13-4-6.
//  Copyright (c) 2013年 伍 兵. All rights reserved.
//

#import "WBSegment.h"

@implementation WBSegment
@synthesize segmentDirection;
@synthesize delegate;
@synthesize normalColor;
-(void)setSegmentDirection:(WBSegmentDirection)aSegmentDirection
{
    segmentDirection=aSegmentDirection;
    [self layoutSegment];
}
-(void)setSelectedColor:(UIColor *)aSelectedColor
{
    if(selectedColor!=aSelectedColor)
    {
        [selectedColor release];
        selectedColor= [aSelectedColor retain];
        [self viewWithTag:currentSelectedIndex].backgroundColor=selectedColor;
    }
}
-(UIColor*)selectedColor
{
    return selectedColor;
}
-(void)setCurrentSelectedIndex:(NSInteger)aCurrentSelectedIndex
{
#if 0
    for(int i=1;i<=titleArray.count;i++)
    {
        [self viewWithTag:i].backgroundColor=normalColor;
    }
#else
    [self viewWithTag:currentSelectedIndex].backgroundColor=normalColor;

#endif
    currentSelectedIndex=aCurrentSelectedIndex;
    [self viewWithTag:currentSelectedIndex].backgroundColor=selectedColor;
}
-(NSInteger)currentSelectedIndex
{
    return currentSelectedIndex;
}
-(void)setTitleArray:(NSArray*)aTitleArray
{
    [titleArray removeAllObjects];
    [titleArray addObjectsFromArray:aTitleArray];
    [self layoutSegment];//重新布局
    
}
-(void)dataInit
{
    self.backgroundColor=[UIColor colorWithWhite:0.8 alpha:1];
    segmentDirection=kWBSegmentHorizonal;
    width=self.frame.size.width;
    height=self.frame.size.height;
    titleArray =[[NSMutableArray alloc] init];
    borderGap=((segmentDirection==kWBSegmentVertical)?width:height)/10;
    selectedColor=[UIColor whiteColor];
    normalColor=[[UIColor blueColor] retain];
    currentSelectedIndex=1;
}
- (id)initWithFrame:(CGRect)frame titleArray:(NSArray*)aTitleArray normalColor:(UIColor*)aNormalColor directionVertical:(BOOL)aIsVertical
{
    self = [super initWithFrame:frame];
    if (self) {
        [self dataInit];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        [self dataInit];
    }
    return self;
}
-(void)layoutSegment
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    BOOL isVertical=segmentDirection==kWBSegmentVertical;
    for(int i=1;i<=titleArray.count;i++)
    {
        CGFloat eachHeight=1.0*((isVertical?height:width)-(titleArray.count+1)*borderGap)/titleArray.count;
        CGPoint centerPoint=isVertical?CGPointMake(width/2, (2*i-1)*eachHeight/2+i*borderGap):CGPointMake((2*i-1)*eachHeight/2+i*borderGap,(isVertical?width:height)/2);
        CGRect rect1=isVertical?CGRectMake(0, 0, width-2*borderGap, eachHeight):CGRectMake(0, 0,eachHeight,height-2*borderGap);
        UIView * itemView=[[UIView alloc] initWithFrame:rect1];
        itemView.center=centerPoint;
        itemView.tag=i;
        itemView.layer.cornerRadius=borderGap/2;
        itemView.backgroundColor=normalColor;
        [self addSubview:itemView];
        [itemView release];
        
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [itemView addGestureRecognizer:tap];
        [tap release];
        
        
        UILabel * label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect1.size.width, rect1.size.height)];
        label.center=isVertical?CGPointMake((width-2*borderGap)/2, eachHeight/2):CGPointMake(eachHeight/2,(height-2*borderGap)/2);
        label.backgroundColor=[UIColor clearColor];
        label.textAlignment= NSTextAlignmentCenter;
        label.text=[titleArray objectAtIndex:i-1];
        //label.alpha=0.4;
        [itemView addSubview:label];
        [label release];
    }
   // NSLog(@"layout end");
    //NSLog(@"subviews:%d",self.subviews.count);
}
-(void)tap:(UITapGestureRecognizer *)tapGuesture
{
   
    UIView * tapView=[tapGuesture view];
    if(self.currentSelectedIndex!=tapView.tag)
    {
        self.currentSelectedIndex=tapView.tag;
        [delegate WBSegment:self DidSelectedItemIndex:tapView.tag];
    }
}
-(void)dealloc
{
    [titleArray release];
    [selectedColor release];
    [normalColor release];
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
