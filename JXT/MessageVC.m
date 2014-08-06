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
    segment.selectedColor=[UIColor whiteColor];
    segment.normalColor=[UIColor colorWithRed:94/255.0 green:195/255.0 blue:1.0 alpha:0.8];
    segment.delegate=self;
    [segment setTitleArray:@[@"班级消息",@"学校公告"]];
    [segment setSegmentDirection:kWBSegmentHorizonal];
    segment.currentSelectedIndex=1;
    
    //二级标签(班级选择)
    [self.headerTitleArray addObject:@"高三(8)班"];
    [self refreshHeader];
    
    
    [self.currentCombListItemArray addObjectsFromArray:@[@"高三(8)班",@"高三(9)班",@"高三(10)班",@"高三(11)班"]];
    
    
    [self loadTableContent];//加载数据
    // Do any additional setup after loading the view.
}

//复写一级标签事件函数
-(void)WBSegment:(WBSegment *)aSegment DidSelectedItemIndex:(NSInteger)index
{
    [super WBSegment:aSegment DidSelectedItemIndex:index];
    segmentSelectIndexInitValue=aSegment.currentSelectedIndex;
    if(index==1)
    {
    }
    else
    {
    }
    [self loadTableContent];
}
//复写二级标事件函数
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
            ClassMsgCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ClassMsgCell"];
            NSDictionary* tmpDict=[self.contentDataArray objectAtIndex:indexPath.row];
            
            cell.nameLabel.text=[tmpDict objectForKey:@"name"];
            cell.timeLabel.text=[tmpDict objectForKey:@"time"];
            cell.contentLabel.text=[tmpDict objectForKey:@"content"];
            return cell;
            
        }
        else
        {
            SchoolMsgCell * cell=[tableView dequeueReusableCellWithIdentifier:@"SchoolMsgCell"];
            NSDictionary* tmpDict=[self.contentDataArray objectAtIndex:indexPath.row];
            
            cell.nameLabel.text=[tmpDict objectForKey:@"name"];
            cell.timeLabel.text=[tmpDict objectForKey:@"time"];
            cell.contentLabel.text=[tmpDict objectForKey:@"content"];
            return cell;
            
        }
        
    }
    
    
    
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"]autorelease];
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.text=[self.currentCombListItemArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)loadTableContent
{
    [self.contentDataArray removeAllObjects];
    
    
    //URL
    NSURL* url=[NSURL URLWithString:[HOST_URL stringByAppendingString:URL_GetUserMessageList]];
    //参数
    NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
    [dict setObject:@"1" forKey:@"startIndex"];
    [dict setObject:@"1" forKey:@"orderFlag"];
    [dict setObject:@"6" forKey:@"size"];
    [dict setObject:@"1" forKey:@"userId"];
    
    
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
                        [self.contentDataArray addObject:@{@"name":[NSString stringWithFormat:@"发送者%d",i],@"content":[NSString  stringWithFormat:@"内容%d:aaaaaaaabbbbbbbbbbbbbbccccccccccccccccccddddddddddddddddddddddddddddd",i],@"time":@"2014-08-04"}];
                    }
                    else
                    {
                       [self.contentDataArray addObject:@{@"name":[NSString stringWithFormat:@"学校公告%d",i],@"content":[NSString  stringWithFormat:@"内容%d:aaaaaaaabbbbbbbbbbbbbbccccccccccccccccccddddddddddddddddddddddddddddd",i],@"time":@"2014-08-04"}];
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
