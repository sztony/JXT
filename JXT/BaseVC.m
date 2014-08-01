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
@synthesize headerTitleArray;
@synthesize currentCombListItemArray;
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
    headerTitleArray=[[NSMutableArray alloc] initWithCapacity:3];
    currentCombListItemArray=[[NSMutableArray alloc] initWithCapacity:0];

}
//刷新二级标签标题
-(void)refreshHeader
{
    
#if 1
        for(WBCombListHeader*  header in [self.view subviews])
        {
            if( [header isKindOfClass:[WBCombListHeader class]])
            {
                NSLog(@"yes:%d",header.tag);
                [header addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
                header.rightImage=[UIImage imageNamed:@"detailDown.png"];
                [header setTitle:[self.headerTitleArray objectAtIndex:header.tag-1] forState:UIControlStateNormal];
            }
        }
#else
    //messageVC会出错
    for(int i=1;i<=self.headerTitleArray.count;i++)
    {
        NSString* title=[self.headerTitleArray objectAtIndex:i-1];
        NSLog(@"title:%@",title);
        WBCombListHeader* header=(WBCombListHeader*) [self.view viewWithTag:i];
        [header addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
        header.rightImage=[UIImage imageNamed:@"detailDown.png"];
        [header setTitle:title forState:UIControlStateNormal];
        //[header setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
#endif
        
    
}
//一级标签代理
-(void)WBSegment:(WBSegment *)aSegment DidSelectedItemIndex:(NSInteger)index
{
    NSLog(@"index:%d",index);
}
//二级标签事件函数
-(void)headerClicked:(WBCombListHeader*)aHeader
{
    currentClickedHeader=aHeader;
     NSLog(@"seg:%d",segment.currentSelectedIndex);
    NSLog(@"tag:%d",aHeader.tag);
}
#pragma mark - CombList数据源
//CombList数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return currentCombListItemArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //子类自定义
    return nil;
}

#pragma mark - WBCombListDelegate
//combList代理
-(void)combList:(WBCombList *)aCombList SelectedIndexPath:(NSIndexPath *)aIndexPath
{
    NSLog(@"selectCombListRow:%d",aIndexPath.row);
}
-(void)dealloc
{
    [currentCombListItemArray release];
    [headerTitleArray release];
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
