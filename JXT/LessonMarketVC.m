//
//  LessonMarketVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-19.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "LessonMarketVC.h"

@interface LessonMarketVC ()

@end

@implementation LessonMarketVC

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
    [segment setTitleArray:@[@"微课课程",@"名师课程"]];
    segment.selectedColor=[UIColor colorWithRed:94/255.0 green:195/255.0 blue:1.0 alpha:0.8];
    segment.currentSelectedIndex=1;
    
    
    [self.headerTitleArray addObject:@"高一"];
    [self.headerTitleArray addObject:@"数学"];
    [self.headerTitleArray addObject:@"本学期"];
    [self refreshHeader];
    // Do any additional setup after loading the view.
}
-(void)WBVerticalSegment:(WBSegment *)aSegment DidSelectedItemIndex:(NSInteger)index
{
    [super WBVerticalSegment:segment DidSelectedItemIndex:index];
    if(index==1)
    {
        [self.headerTitleArray removeAllObjects];
        [self.headerTitleArray addObject:@"高一"];
        [self.headerTitleArray addObject:@"数学"];
        [self.headerTitleArray addObject:@"本学期"];
        [self refreshHeader];
    }
    else
    {
        [self.headerTitleArray removeAllObjects];
        [self.headerTitleArray addObject:@"高二"];
        [self.headerTitleArray addObject:@"语文"];
        [self.headerTitleArray addObject:@"下学期"];
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
