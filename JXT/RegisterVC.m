//
//  RegisterVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-23.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()
{
    NSString* verifyCode;
}
@end

@implementation RegisterVC

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
    self.title=@"免费注册";
    // Do any additional setup after loading the view.
}
-(IBAction)getVertifyNumBtnClicked:(id)sender
{
    if(phoneNumField.text.length==11)
    {
        //URL
        NSURL* url=[NSURL URLWithString:[HOST_URL stringByAppendingString:URL_GetVertifyCode]];
        //参数
        NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
        [dict setObject:phoneNumField.text forKey:@"registMobile"];
        
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
            verifyCode=[[[backDataDict objectForKey:@"result"] objectForKey:@"verifyCode"] retain];
            
            if(!error)
            {
                NSString* msg=[backDataDict objectForKey:@"msg"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"%@",msg);
                    statusLabel.text=msg;
                });
                //消息检测
                if([msg hasPrefix:@"操作成功"])
                {
                    
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
    else
    {
         statusLabel.text=@"号码有误!";
    }
}
-(IBAction)registerBtnClicked:(id)sender
{
    
    if(nameField.text.length==0)
    {
        statusLabel.text=@"请输入姓名!";
        return;
    }
    if(passwordField.text.length==0)
    {
        statusLabel.text=@"请输入密码!";
        return;
    }
    if(phoneNumField.text.length==0)
    {
        statusLabel.text=@"请输入手机号!";
        return;
    }
    if(vertifyNumField.text.length==0)
    {
        statusLabel.text=@"请输入验证码!";
        return;
    }
    if(![vertifyNumField.text isEqualToString:verifyCode])
    {
        statusLabel.text=@"验证码错误!";
        return;
    }
     
     
    //保存待注册
    dataCenter.userRealName=nameField.text;
    dataCenter.userMobile=phoneNumField.text;
    dataCenter.userPassword=passwordField.text;
    
    //进入完善信息页
    [self performSegueWithIdentifier:@"RegistToFulfillInfoSegue" sender:nil];
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
