//
//  FulFillInfoVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-29.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "FulFillInfoVC.h"

@interface FulFillInfoVC ()
{
    BOOL clickGrade;
    NSMutableArray* gradeArray;
    NSMutableArray* schoolArray;
}
@end

@implementation FulFillInfoVC

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
    gradeArray=[[NSMutableArray alloc] initWithCapacity:0];
    schoolArray=[[NSMutableArray alloc] initWithCapacity:0];
    
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
-(void)dealloc
{
    [gradeArray release];
    [schoolHead release];
    [super dealloc];
}
-(void)fetchAreaList
{
    //URL
    NSURL* url=[NSURL URLWithString:[HOST_URL stringByAppendingString:URL_GetAreaList]];
    //参数
    NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
    [dict setObject:@"1" forKey:@"areaId"];
    
    //请求
    [WBHTTPRequest sendRequestWithURL:url parameterDict:dict type:kWBHTTPRequestPOSTType  queue:[dataCenter globalTaskQueue] completeHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"error:%@",connectionError);
        NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        //网络连接错误
        if(connectionError)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                statusLabel.text=[NSString stringWithFormat:@"连接错误:%@",connectionError];
                return ;
            });
        }
        //操作成功与否检测
        //        Boolean status=[[dict valueForKey:@"success"] boolValue];
        //        NSLog(@"value:%@",[dict valueForKey:@"success"]);
        //        NSLog(@"status:%d",status);
        //        if(!status)
        //        {
        //            dispatch_async(dispatch_get_main_queue(), ^{
        //                NSLog(@"操作失败!");
        //                alertLabel.text=@"操作失败!";
        //                return ;
        //            });
        //        }
        NSError* error=nil;
        NSDictionary * backDataDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"dict:%@",backDataDict);
        NSDictionary* resultDict=[backDataDict objectForKey:@"result"];
        [schoolArray addObjectsFromArray:[resultDict objectForKey:@"areaList"]];
        //NSLog(@"areaList:%@",schoolArray);
        if(!error)
        {
            //消息检测
            NSString* msg=[backDataDict objectForKey:@"msg"];
            if([msg hasPrefix:@"操作成功"])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"%@",msg);
                    statusLabel.text=msg;
                });
            }
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                statusLabel.text=@"操作失败!";
            });
        }
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"完善个人信息";
    
    gradeHead.rightImage=[UIImage imageNamed:@"detailDown.png"];
    schoolHead.rightImage=[UIImage imageNamed:@"detailDown.png"];
    
    
    [self fetchAreaList];//获取行政区列表
    // Do any additional setup after loading the view.
}
-(IBAction)gradeCombListClicked:(UIButton*)aHeader
{
    clickGrade=YES;
    //显示
    [WBCombList  showInRect:CGRectMake(aHeader.frame.origin.x,aHeader.frame.origin.y+aHeader.bounds.size.height,aHeader.bounds.size.width, 300) edgeInset:UIEdgeInsetsMake(3, 3, 3, 3) delegate:self inView:self.view withTag:1];
}
-(IBAction)schoolCombListClicked:(UIButton*)aHeader
{
    clickGrade=NO;
    //显示
    [WBCombList  showInRect:CGRectMake((320-aHeader.frame.size.width)/2.0,64,aHeader.bounds.size.width, 300) edgeInset:UIEdgeInsetsMake(3, 3, 3, 3) delegate:self inView:self.view withTag:2];
}
-(void)combList:(WBCombList *)aCombList SelectedIndexPath:(NSIndexPath *)aIndexPath
{
    //年级
    if(aCombList.tag==1)
    {
        
    }
}
#pragma mark - comblist
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(clickGrade)
        return gradeArray.count;
    else
        return schoolArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"]autorelease];
    }
    cell.backgroundColor=[UIColor whiteColor];
    if(clickGrade)
    {
        NSDictionary * tmpDict=[gradeArray objectAtIndex:indexPath.row];
        cell.textLabel.text= [tmpDict objectForKey:@"areaName"];
    }
    else
    {
        NSDictionary * tmpDict=[schoolArray objectAtIndex:indexPath.row];
        cell.textLabel.text= [tmpDict objectForKey:@"areaName"];
    }
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
