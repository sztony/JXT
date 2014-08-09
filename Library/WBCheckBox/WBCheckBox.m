//
//  WBCheckBox.m
//  WBCheckBox
//
//  Created by 伍 兵 on 13-11-15.
//  Copyright (c) 2013年 伍 兵. All rights reserved.
//

#import "WBCheckBox.h"
@interface WBCheckBox()
{
    CGFloat borderWidth;
    CATextLayer * textLayer;
    
}
@end
@implementation WBCheckBox
@synthesize invocation;
@synthesize type;
-(void)setType:(CheckBoxType)aType
{
    type=aType;
    [self layoutUI];
}
//@synthesize borderColor,fillColor;
-(UIColor*)borderColor
{
    return borderColor;
}
-(void)setBorderColor:(UIColor *)aBorderColor
{
    if(borderColor!=aBorderColor)
    {
        [borderColor release];
        borderColor= [aBorderColor retain];
        [self layoutUI];
    }
}
-(UIColor*)fillColor
{
    return fillColor;
}
-(void)setFillColor:(UIColor *)aFillColor
{
    if(fillColor!=aFillColor)
    {
        [fillColor release];
        fillColor= [aFillColor retain];
        [self layoutUI];
    }
}
-(NSString*)title
{
    return title;
}
-(void)setTitle:(NSString *)aTitle
{
    if(![title isEqualToString:aTitle])
    {
        [title release];
        title= [aTitle retain];
        [self layoutUI];
    }
}
-(BOOL)isChecked
{
    return   isChecked;
}
-(void)setIsChecked:(BOOL)aIsChecked
{
    isChecked=aIsChecked;
    [self setNeedsDisplay];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self dataInit];
        [self layoutUI];
    }
    return self;
}
-(void)dataInit
{
    fontSize=self.frame.size.height*0.9;
    type=kCheckBoxTypeRect;
    title=@"";
    
    borderColor=[WBCheckBox_Default_Border_Color retain];
    fillColor=[WBCheckBox_Default_Fill_Color retain];
    
    textLayer=[[CATextLayer alloc] init];
    textLayer.backgroundColor=[UIColor clearColor].CGColor;
    [self.layer addSublayer:textLayer];
    
    self.backgroundColor=[UIColor clearColor];
}
-(void)layoutUI
{
    CGSize size=[title sizeWithFont:[UIFont systemFontOfSize:fontSize]];
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.height+size.width, self.frame.size.height);
    
    //self.layer.borderColor=[UIColor cyanColor].CGColor;
    //self.layer.borderWidth=1;
    width=self.frame.size.width;
    height=self.frame.size.height;
    borderWidth=height/10;
    textLayer.frame=CGRectMake(height, (height-size.height)/2, size.width, size.height);
    textLayer.string=title;
    textLayer.foregroundColor=borderColor.CGColor;
    textLayer.fontSize=fontSize;
    textLayer.foregroundColor=borderColor.CGColor;
    
    [self setNeedsDisplay];
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        
        [self dataInit];
        [self layoutUI];
    }
    return self;
}
-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    _target=target;
    _action=action;
    controlEvent=controlEvents;
    NSMethodSignature* signature=[[target class] instanceMethodSignatureForSelector:action];
    if(signature)
    {
        self.invocation=[NSInvocation invocationWithMethodSignature:signature];
        [self.invocation  setTarget:target];
        [self.invocation setSelector:action];
        [self.invocation setArgument:&self atIndex:2];
    }
    
}
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    //NSLog(@"tracking");
    if(controlEvent==UIControlEventValueChanged)
       [self.invocation invoke];
    return YES;
}
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}
-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
//    if(controlEvent==UIControlEventValueChanged)
//        [self.invocation invoke];
//    NSLog(@"end track");
}
-(void)dealloc
{
    [invocation release];
    [title release];
    [borderColor release];
    [fillColor release];
    [textLayer release];
    [super dealloc];
}
/*
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches begin");
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches end");
}
 */
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGContextSetFillColorWithColor(context, fillColor.CGColor);
    // Drawing code
    CGRect borderRect=CGRectMake(borderWidth/2, borderWidth/2, height-borderWidth, height-borderWidth);
    //NSLog(@"borderRect:%@",NSStringFromCGRect(borderRect));
    if(type==kCheckBoxTypeRect)
        CGContextStrokeRect(context, borderRect);
    else
        CGContextStrokeEllipseInRect(context, borderRect);
    if(isChecked)
    {
        if(type==kCheckBoxTypeRect)
            CGContextFillRect(context,CGRectInset(borderRect, borderWidth, borderWidth));
        else
            CGContextFillEllipseInRect(context, CGRectInset(borderRect, borderWidth, borderWidth));
    }
}


@end
