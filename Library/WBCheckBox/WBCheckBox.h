//
//  WBCheckBox.h
//  WBCheckBox
//
//  Created by 伍 兵 on 13-11-15.
//  Copyright (c) 2013年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define WBCheckBox_Default_Fill_Color  MAIN_COLOR
#define WBCheckBox_Default_Border_Color [UIColor blackColor]

typedef enum {
    kCheckBoxTypeRect,
    kCheckBoxTypeRound
}CheckBoxType;

@interface WBCheckBox : UIControl
{
    UIColor* borderColor;//边框颜色
    UIColor* fillColor;//填充颜色
    
    CGFloat width;
    CGFloat height;
    
    BOOL isChecked;//是否选中标志
    CheckBoxType type;
    id _target;
    SEL _action;
    UIControlEvents controlEvent;
    NSInvocation * invocation;
    
    NSString* title;//标题
    NSInteger fontSize;//字体大小
    
    
}
@property(nonatomic,retain) NSString* title;
@property(nonatomic,retain) NSInvocation* invocation;
@property(nonatomic,assign) BOOL isChecked;
@property(nonatomic,retain) UIColor*  borderColor;
@property(nonatomic,retain) UIColor*  fillColor;
@property(nonatomic,assign) CheckBoxType type;
@end
