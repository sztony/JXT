//
//  MyLessonVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-19.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "MyLessonVC.h"

@interface MyLessonVC ()
{
    NSInteger segmentSelectIndexInitValue;//segment初始选中值
}
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
-(void)dataInit
{
    [super dataInit];
    segmentSelectIndexInitValue=1;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //一级标签
    //segment.backgroundColor=[UIColor purpleColor];
    segment.selectedColor=[UIColor whiteColor];
    segment.normalColor=[UIColor colorWithRed:94/255.0 green:195/255.0 blue:1.0 alpha:0.8];
    segment.delegate=self;
    [segment setTitleArray:@[@"学校课程",@"我的课程"]];
    [segment setSegmentDirection:kWBSegmentHorizonal];
    segment.currentSelectedIndex=segmentSelectIndexInitValue;
    
    //二级标签
    [self.headerTitleArray addObject:@"今日课程"];
    [self.headerTitleArray addObject:@"今日作业"];
    [self.headerTitleArray addObject:@"我的课表"];
    [self refreshHeader];
    
    
    currentClickedHeader=header1;
    
    [self loadTableContent];
    // Do any additional setup after loading the view.
}

-(void)loadTableContent
{
    [self.contentDataArray removeAllObjects];
    
    
    //URL
    NSURL* url=[NSURL URLWithString:[HOST_URL stringByAppendingString:URL_CourseByDate]];
    //参数
    NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
    [dict setObject:@"1" forKey:@"userId"];
    [dict setObject:@"1" forKey:@"subjectId"];
    [dict setObject:@"3" forKey:@"courseSize"]; //默认3个
    [dict setObject:@"2014-01-01" forKey:@"courseTime"]; //默认今天 2014-01-01
    
    
    //请求
    [WBHTTPRequest sendRequestWithURL:url parameterDict:dict type:kWBHTTPRequestPOSTType  queue:[dataCenter globalTaskQueue] completeHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"error:%@",connectionError);
        NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        //成功
        if(!connectionError)
        {
            NSError* error=nil;
            NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"dict:%@",dict);
            if(!error)
            {
#if USE_TEST_DATA
                //伪数据
                int count= arc4random()%10+1;
                NSLog(@"count:%d",count);
                for(int i=0;i<count;i++)
                {
                    if(segmentSelectIndexInitValue==1)
                    {
                        NSLog(@"title:%@",currentClickedHeader.titleLabel.text);
                        NSString* subject=[currentClickedHeader titleForState:UIControlStateNormal];
                        [self.contentDataArray addObject:@{@"title":[NSString stringWithFormat:@"%@课程%d",subject,i],@"content":[NSString  stringWithFormat:@"%@课程简介%d:aaaaaaaabbbbbbbbbbbbbbccccccccccccccccccddddddddddddddddddddddddddddd",subject,i]}];
                    }
                    else
                    {
                        [self.contentDataArray addObject:@{@"title":@"数学讲义",@"teacher":@"牛老师",@"image":@"math.png",@"time":@"20分钟"}];
                    }
                }
                NSLog(@"contentArray:%@",self.contentDataArray);
#else
                //操作成功与否检测
                BOOL status=[[dict valueForKey:@"success"] boolValue];
                if(!status)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"操作失败!");
                        return ;
                    });
                }
                //消息检测
                NSString* msg=[dict objectForKey:@"msg"];
                if([msg isEqualToString:@"今日无课程内容!"])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"%@",msg);
                        return ;
                    });
                }
                //NSString* msgCode=[dict objectForKey:@"msgcode"];
                NSDictionary* resultDict=[dict objectForKey:@"result"];
#endif
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //显示数据
                    [contentTableView reloadData];
                });
            }
            else
            {
                NSLog(@"login parse error:%@",error);
            }
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"连接错误:%@",connectionError);
            });
        }
        
        
        
    }];
    
    
    
    
    
   
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        [self dataInit];
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
    segmentSelectIndexInitValue=aSegment.currentSelectedIndex;
    if(index==1)
    {
        [self.headerTitleArray removeAllObjects];
        [self.headerTitleArray addObject:@"今日课程"];
        [self.headerTitleArray addObject:@"今日作业"];
        [self.headerTitleArray addObject:@"我的课表"];
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
    [self loadTableContent];
    
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
                array=@[@"语文",@"数学",@"外语",@"政治",@"历史",@"物理",@"化学",@"生物",@"地里"];
                break;
            case 2:
                array=@[@"语文",@"数学",@"外语",@"政治",@"历史",@"物理",@"化学",@"生物",@"地里"];
                break;
            default:
                array=@[@""];
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
    
    
    //更新数据
    [self loadTableContent];
    
    
}
#pragma mark - tableView datasource 
//CombList数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView.tag==TAG_ContentTable)
    {
        
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==TAG_ContentTable)
    {
        NSLog(@"count:%d",self.contentDataArray.count);
        return self.contentDataArray.count;
    }
    return self.currentCombListItemArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if(segmentSelectIndexInitValue==1&&currentClickedHeader==header2&&tableView.tag==TAG_ContentTable)
    {
        return 115;
    }
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(segmentSelectIndexInitValue==1&&currentClickedHeader==header2&&tableView.tag==TAG_ContentTable)
    {
        HomeWorkTopView* header=[[[HomeWorkTopView  alloc] init] autorelease];
        //header.backgroundColor=[UIColor yellowColor];
        return header;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==TAG_ContentTable)
    {
        if(segmentSelectIndexInitValue==1)
            return 120;
        else
            return 80;
    }
    return 30;
}
//combList自定义cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView.tag==TAG_ContentTable)
    {
        if(segment.currentSelectedIndex==1)
        {
            SchoolLessonCustomCell* cell=[tableView dequeueReusableCellWithIdentifier:@"SchoollLessonCell"];
            cell.subjectTitle.text=[[self.contentDataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
            cell.subjectContent.text=[[self.contentDataArray objectAtIndex:indexPath.row] objectForKey:@"content"];
            return cell;
            
        }
        else
        {
            MyLessonCustomCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyLessonCell"];
            NSDictionary* tmpDict=[self.contentDataArray objectAtIndex:indexPath.row];
            cell.subjectTitle.text=[tmpDict objectForKey:@"title"];
            cell.subjectTeacher.text=[tmpDict objectForKey:@"teacher"];
            cell.subjectTime.text=[tmpDict objectForKey:@"time"];
            cell.subjectImage.image=[UIImage imageNamed:[tmpDict objectForKey:@"image"]];
            return cell;
        }
        
    }
    
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"]autorelease];
    }
    cell.backgroundColor=[UIColor whiteColor];
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
