//
//  FetchTownVC.m
//  JXT
//
//  Created by 伍 兵 on 14-8-6.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "FetchTownVC.h"

@interface FetchTownVC ()

@end

@implementation FetchTownVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)fetchAreaList
{
    //URL
    NSURL* url=[NSURL URLWithString:[HOST_URL stringByAppendingString:URL_GetAreaList]];
    //参数
    NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
    [dict setObject:self.areaID forKey:@"areaId"];
    
    //请求
    [WBHTTPRequest sendRequestWithURL:url parameterDict:dict type:kWBHTTPRequestPOSTType  queue:[dataCenter globalTaskQueue] completeHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"error:%@",connectionError);
        NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        //网络连接错误
        if(connectionError)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //statusLabel.text=[NSString stringWithFormat:@"连接错误:%@",connectionError];
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
        [dataArray  addObjectsFromArray:[resultDict objectForKey:@"areaList"]];
        //NSLog(@"areaList:%@",schoolArray);
        if(!error)
        {
            //消息检测
            NSString* msg=[backDataDict objectForKey:@"msg"];
            if([msg hasPrefix:@"操作成功"])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"%@",msg);
                    //statusLabel.text=msg;
                    [self.tableView reloadData];
                });
            }
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                //statusLabel.text=@"操作失败!";
            });
        }
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchAreaList];
    // Do any additional setup after loading the view.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* tmpDict=[dataArray objectAtIndex:indexPath.row];

    FetchAreaBaseTableVC* fetchVC= [self.storyboard instantiateViewControllerWithIdentifier:@"FetchSchoolVCID"];
#if  0
    fetchVC.areaID= @"10";
#else
    
     fetchVC.areaID= [tmpDict objectForKey:@"areaId"];
#endif
    [self.navigationController pushViewController:fetchVC animated:YES];
   
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
