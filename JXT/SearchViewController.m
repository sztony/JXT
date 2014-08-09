//
//  SearchViewController.m
//  JXT
//
//  Created by 伍 兵 on 14-7-22.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

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
    segmentCurrentSelectedIndex=0;
    dataArray =[[NSMutableArray alloc] init];
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //NSLog(@"scope titles:%@", searchBar.scopeButtonTitles);
    // Do any additional setup after loading the view.
}
-(void)loadTableContent
{
    [dataArray removeAllObjects];
    
    //URL
    NSURL* url;
    if(segmentCurrentSelectedIndex==0)
        url=[NSURL URLWithString:[HOST_URL stringByAppendingString:URL_searchCourse]];
    else
        url=[NSURL URLWithString:[HOST_URL stringByAppendingString:URL_searchTeacher]];
    //参数
    NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
    [dict setObject:searchBar.text forKey:@"queryWord"];
    [dict setObject:@"" forKey:@"startIndex"];
    [dict setObject:@"7" forKey:@"size"];
    [dict setObject:@"1" forKey:@"orderFlag"];
    
    
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
#if 0
                //伪数据
                int count= arc4random()%10+1;
                NSLog(@"count:%d",count);
                for(int i=0;i<count;i++)
                {
                    if(segmentCurrentSelectedIndex==0)
                    {
                       
                        [dataArray addObject:@{@"title":[NSString stringWithFormat:@"课程%d",i],@"detail":[NSString  stringWithFormat:@"内容%d:aaaaaaaabbbbbbbbbbbbbbccccccccccccccccccddddddddddddddddddddddddddddd",i],@"image":@"chinese.png"}];
                    }
                    else
                    {
                       [dataArray addObject:@{@"title":[NSString stringWithFormat:@"老师%d",i],@"detail":[NSString  stringWithFormat:@"内容%d:aaaaaaaabbbbbbbbbbbbbbccccccccccccccccccddddddddddddddddddddddddddddd",i],@"image":@"teacherHead.png"}];
                    }
                }
                NSLog(@"contentArray:%@",dataArray);
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
                if([msg isEqualToString:@"暂无搜索记录!"])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"%@",msg);
                        return ;
                    });
                }
                //NSString* msgCode=[dict objectForKey:@"msgcode"];
                NSArray* courseList=[[dict objectForKey:@"result"] objectForKey:(segmentCurrentSelectedIndex==0?@"courseList":@"teacherList")];
                [dataArray addObjectsFromArray:courseList];
                NSLog(@"dataArray:%@",dataArray);
                
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
#pragma mark - UISearchBar delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar
{
    NSLog(@"start search!");
    [aSearchBar resignFirstResponder];
     if(searchBar.text.length>0)
     {
         [self loadTableContent];//搜索
     }
    else
    {
        
    }
}
-(void)searchBar:(UISearchBar *)aSearchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    NSLog(@"selected:%d",selectedScope);
    if(segmentCurrentSelectedIndex==selectedScope)
        return;
    segmentCurrentSelectedIndex=selectedScope;
    if(searchBar.text.length>0)
    {
        [self loadTableContent];//刷新数据
    }
}


#pragma mark - tableView datasource 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultCell * cell=[tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    NSDictionary* tmpDict=[dataArray objectAtIndex:indexPath.row];
    //课程搜索
    if(segmentCurrentSelectedIndex==0)
    {
        cell.titleLable.text=[tmpDict objectForKey:@"courseName"];
        cell.detailLabel.text=[tmpDict objectForKey:@"courseContent"];
        //cell.imageView.image=[UIImage imageNamed:[tmpDict objectForKey:@"coursePic"]];
        cell.imageView.image=[UIImage imageNamed:@"math.png"];
    }
    //老师搜索
    else
    {
        cell.titleLable.text=[tmpDict objectForKey:@"teacherName"];
        
        id introduce=[tmpDict objectForKey:@"teacherIntroduce"];
        
        if([introduce isKindOfClass:[NSNull class]])
            introduce=@"教师简介";
        cell.detailLabel.text=introduce;
        //cell.imageView.image=[UIImage imageNamed:[tmpDict objectForKey:@"teacherPic"]];
        cell.imageView.image=[UIImage imageNamed:@"teacherHead.png"];

    }
    return cell;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [searchBar resignFirstResponder];
}
-(void)dealloc
{
    [dataArray release];
    [super dealloc];
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
