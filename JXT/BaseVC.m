//
//  BaseVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-22.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()
{
    
}
@end

@implementation BaseVC

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
    
    segment=[[WBSegment alloc] initWithFrame:CGRectMake(0, 64, 320, 50) titleArray:@[@"1",@"2"] normalColor:[UIColor whiteColor] directionVertical:NO];
    segment.delegate=self;
    [self.view addSubview:segment];
    // Do any additional setup after loading the view from its nib.
}
-(void)WBVerticalSegment:(WBSegment *)segment DidSelectedItemIndex:(NSInteger)index
{
    NSLog(@"index:%d",index);
}
-(void)dealloc
{
    [segment release];
    [super dealloc];
    NSLog(@"baseVC dealloc");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
