//
//  MessageVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-25.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "MessageVC.h"

@interface MessageVC ()

@end

@implementation MessageVC

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
    [segment setTitleArray:@[@"班级消息",@"学校公告"]];
    [segment setSegmentDirection:kWBSegmentHorizonal];
    segment.currentSelectedIndex=1;
    
    //二级标签(班级选择)
    [self.headerTitleArray addObject:@"高三(8)班"];
    [self refreshHeader];
    
    
    [self.currentCombListItemArray addObjectsFromArray:@[@"高三(8)班",@"高三(9)班",@"高三(10)班",@"高三(11)班"]];
    // Do any additional setup after loading the view.
}
//复写二级标签事件函数
-(void)headerClicked:(WBCombListHeader*)aHeader
{
    [super headerClicked:aHeader];
    //显示
    [WBCombList  showInRect:CGRectMake(aHeader.frame.origin.x,aHeader.frame.origin.y+aHeader.bounds.size.height,aHeader.bounds.size.width, 300) edgeInset:UIEdgeInsetsMake(3, 3, 3, 3) delegate:self inView:self.view withTag:2];
    
}
//复写combList代理
-(void)combList:(WBCombList *)aCombList SelectedIndexPath:(NSIndexPath *)aIndexPath

{
    [super combList:aCombList SelectedIndexPath:aIndexPath];
    [currentClickedHeader setTitle:[self.currentCombListItemArray objectAtIndex:aIndexPath.row] forState:UIControlStateNormal];
    
}
//combList自定义cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"]autorelease];
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.text=[self.currentCombListItemArray objectAtIndex:indexPath.row];
    return cell;
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
