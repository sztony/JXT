//
//  FindPasswordVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-23.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "FindPasswordVC.h"

@interface FindPasswordVC ()

@end

@implementation FindPasswordVC

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
    self.navigationController.navigationBar.hidden=NO;
    self.title=@"找回密码";
    // Do any additional setup after loading the view.
}
-(IBAction)sendBtnClicked:(id)sender
{
    //URL
    NSURL * url=[NSURL URLWithString:[HOST_URL stringByAppendingString:URL_FindPwd]];
    NSString* dataString = [NSString stringWithFormat:@"loginMobile=%@",acountField.text];
    NSLog(@"dataString:%@",dataString);
    //请求
    NSMutableURLRequest* request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];//请求类型
    [request setHTTPBody:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
    //连接
    [NSURLConnection sendAsynchronousRequest:request queue:[[GlobalDataManager sharedDataManager] globalTaskQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"error:%@",connectionError);
        NSLog(@"string:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        //成功
        if(!connectionError)
        {
            //发送的状态
            dispatch_async(dispatch_get_main_queue(), ^{
                statusLabel2.text=@"发送成功";
            });
            //解析
            NSError* error=nil;
            NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"dict:%@",dict);
            if(!error)
            {
                NSString* msg=[dict objectForKey:@"msg"];
                //NSLog(@"msg:%@")
                dispatch_async(dispatch_get_main_queue(), ^{
                    statusLabel1.text=msg;
                });
                NSString* msgCode=[dict objectForKey:@"msgcode"];
                NSDictionary* userInfoDict=[dict objectForKey:@"result"];
                BOOL status=[[dict valueForKey:@"success"] boolValue];
                if(status&&[msg isEqualToString:@"操作成功"])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //成功的处理
                    });
                }
                
            }
            else
            {
                NSLog(@"login parse error:%@",error);
            }
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                statusLabel2.text=[NSString stringWithFormat:@"发送错误:%@",connectionError];
            });
        }
        
    }];
    
    //
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
