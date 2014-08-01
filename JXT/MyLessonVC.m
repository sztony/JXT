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
    
    //一级标签
    //segment.backgroundColor=[UIColor purpleColor];
    segment.normalColor=[UIColor whiteColor];
    segment.selectedColor=[UIColor colorWithRed:94/255.0 green:195/255.0 blue:1.0 alpha:0.8];
    segment.delegate=self;
    [segment setTitleArray:@[@"学校课程",@"我的课程"]];
    [segment setSegmentDirection:kWBSegmentHorizonal];
    segment.currentSelectedIndex=1;
    
    //二级标签
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
//复写一级标签代理
-(void)WBSegment:(WBSegment *)aSegment DidSelectedItemIndex:(NSInteger)index
{
    [super WBSegment:segment DidSelectedItemIndex:index];
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
//复写二级标签事件函数
-(void)headerClicked:(WBCombListHeader*)aHeader
{
    [super headerClicked:aHeader];
    NSArray* array;
    if(segment.currentSelectedIndex==1)
    {
        switch (aHeader.tag) {
            case 1:
                array=@[@"item1",@"item2",@"item3"];
                break;
            case 2:
                array=@[@"item11",@"item22",@"item33"];
                break;
            default:
                array=@[@"item111",@"item222",@"item333"];
                break;
        }
    }
    else
    {
        switch (aHeader.tag) {
            case 1:
                array=@[@"item1",@"item2",@"item3"];
                break;
            case 2:
                array=@[@"item11",@"item22",@"item33"];
                break;
            default:
                array=@[@"item111",@"item222",@"item333"];
                break;
        }
    }
    //更新数据
    [self.currentCombListItemArray  removeAllObjects];
    [self.currentCombListItemArray addObjectsFromArray:array];
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
