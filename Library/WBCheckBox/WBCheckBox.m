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
        textLayer.foregroundColor=borderColor.CGColor;
        [self setNeedsDisplay];
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
        [self setNeedsDisplay];
    }
}
-(NSString*)title
{
    return textLayer.string;
}
-(void)setTitle:(NSString *)aTitle
{
    if(textLayer.string!=aTitle)
    {
        CGSize size=[aTitle sizeWithFont:[UIFont systemFontOfSize:fontSize]];
        textLayer.frame=CGRectMake(height, (height-size.height)/2, size.width, size.height);
        textLayer.string=aTitle;
        self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, height+size.width, height);
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
- (id)initWithFrame:(CGRect)frame andTitle:(NSString*)aTitle fontSize:(NSInteger)aFontSize checkBoxType:(CheckBoxType)aType
{
    CGSize size=[aTitle sizeWithFont:[UIFont systemFontOfSize:aFontSize]];
    frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.height+size.width, frame.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        width=frame.size.width;
        height=frame.size.height;
        borderWidth=height/10;
        borderColor=[UIColor blackColor];
        fillColor=[UIColor blueColor];
        fontSize=aFontSize;
        type=aType;
        
        textLayer=[[CATextLayer alloc] init];
        textLayer.frame=CGRectMake(height, (height-size.height)/2, size.width, size.height);
        textLayer.string=aTitle;
        textLayer.foregroundColor=borderColor.CGColor;
        textLayer.fontSize=fontSize;
        textLayer.backgroundColor=[UIColor clearColor].CGColor;
        [self.layer addSublayer:textLayer];
        
        self.backgroundColor=[UIColor clearColor];
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
    NSLog(@"tracking");
    if(controlEvent==UIControlEventTouchUpInside)
       [self.invocation invoke];
    return YES;
}
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    return YES;
}
-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if(controlEvent==UIControlEventTouchUpOutside)
        [self.invocation invoke];
    NSLog(@"end track");
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
