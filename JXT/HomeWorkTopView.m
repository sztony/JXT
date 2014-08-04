//
//  HomeWorkTopView.m
//  JXT
//
//  Created by 伍 兵 on 14-8-4.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "HomeWorkTopView.h"

@implementation HomeWorkTopView

-(id)init
{
    self=[super init];
    if(self)
    {
        self.backgroundColor=[UIColor lightGrayColor];
        [self viewInit];
    }
    return self;
}
-(void)viewInit
{
    UIImageView * imageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 70, 90)];
    imageView.backgroundColor=[UIColor blackColor];
    imageView.image=[UIImage imageNamed:@"teacherHead.png"];
    [self addSubview:imageView];
    [imageView release];
    
    UILabel* label1=[[UILabel alloc] initWithFrame:CGRectMake(114, 20, 73, 21)];
    label1.text=@"任课老师:";
    [self addSubview:label1];
    [label1 release];
    
    UILabel* label2=[[UILabel alloc] initWithFrame:CGRectMake(114, 83, 40, 21)];
    label2.text=@"科目:";
    [self addSubview:label2];
    [label2 release];
    
    UILabel* label3=[[UILabel alloc] initWithFrame:CGRectMake(195, 20, 105, 21)];
    label3.text=@"牛老师";
    [self addSubview:label3];
    [label3 release];
    
    UILabel* label4=[[UILabel alloc] initWithFrame:CGRectMake(195, 83, 105, 21)];
    label4.text=@"数学";
    [self addSubview:label4];
    [label4 release];
}
- (id)initWithFrame:(CGRect)frame parameterDict:(NSDictionary*)aDict
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        
        
        
        
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
