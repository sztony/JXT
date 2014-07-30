//
//  MyLessonVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-19.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "MyLessonVC.h"

@interface MyLessonVC ()

@end

@implementation MyLessonVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [segment setTitleArray:@[@"学校课程",@"我的课程"]];
    segment.selectedColor=[UIColor colorWithRed:94/255.0 green:195/255.0 blue:1.0 alpha:0.8];
    segment.currentSelectedIndex=1;
    
    
    
    [self.headerTitleArray addObject:@"今日课程"];
    [self.headerTitleArray addObject:@"今日作业"];
    [self.headerTitleArray addObject:@"我的课程"];
    [self refreshHeader];
    
    
    // Do any additional setup after loading the view.
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        
    }
    return self;
}
-(void)awakeFromNib
{
    NSLog(@"awake");
}
-(void)WBVerticalSegment:(WBSegment *)aSegment DidSelectedItemIndex:(NSInteger)index
{
    [super WBVerticalSegment:segment DidSelectedItemIndex:index];
    if(index==1)
    {
        [self.headerTitleArray removeAllObjects];
        [self.headerTitleArray addObject:@"今日课程"];
        [self.headerTitleArray addObject:@"今日作业"];
        [self.headerTitleArray addObject:@"我的课程"];
        [self refreshHeader];
    }
    else
    {
        [self.headerTitleArray removeAllObjects];
        [self.headerTitleArray addObject:@"全部课程"];
        [self.headerTitleArray addObject:@"未听课程"];
        [self.headerTitleArray addObject:@"数学"];
        [self refreshHeader];
    }
    
}
-(void)headerClicked:(WBCombListHeader*)aHeader
{
    [super headerClicked:aHeader];
   
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [super dealloc];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
