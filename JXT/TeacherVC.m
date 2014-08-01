//
//  TeacherVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-19.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "TeacherVC.h"

@interface TeacherVC ()

@end

@implementation TeacherVC

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
    //一级标签
    segment.normalColor=[UIColor whiteColor];
    segment.selectedColor=[UIColor colorWithRed:94/255.0 green:195/255.0 blue:1.0 alpha:0.8];
    segment.delegate=self;
    [segment setTitleArray:@[@"高中老师",@"初中老师",@"小学老师"]];
    [segment setSegmentDirection:kWBSegmentHorizonal];
    segment.currentSelectedIndex=1;
    
    // Do any additional setup after loading the view.
}
//复写一级标签代理
-(void)WBSegment:(WBSegment *)aSegment DidSelectedItemIndex:(NSInteger)index
{
    [super WBSegment:aSegment DidSelectedItemIndex:index];
    //自定义
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
