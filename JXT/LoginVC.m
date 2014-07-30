//
//  LoginVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-23.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.navigationController.navigationBar.hidden=YES;
    // Do any additional setup after loading the view.
}
-(IBAction)loginBtnClicked:(id)sender
{
    //URL
    NSURL * url=[NSURL URLWithString:[HOST_URL stringByAppendingString:URL_Login]];
    NSString* code=@"d3c6090d320b8b9e2a7fef7cbfc52ecf";
   NSString* dataString = [NSString stringWithFormat:@"loginName=%@&password=%@&pwdmd5=%@",nameField.text,passwordField.text,code];
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
            NSError* error=nil;
            NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"dict:%@",dict);
            if(!error)
            {
                NSString* msg=[dict objectForKey:@"msg"];
                //NSLog(@"msg:%@")
                dispatch_async(dispatch_get_main_queue(), ^{
                    statusLabel.text=msg;
                });
                NSString* msgCode=[dict objectForKey:@"msgcode"];
                NSDictionary* userInfoDict=[dict objectForKey:@"result"];
                BOOL status=[[dict valueForKey:@"success"] boolValue];
                if(status&&[msg isEqualToString:@"登录成功"])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self dismissViewControllerAnimated:YES completion:^{
                        }];
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
                statusLabel.text=@"连接失败!";
                [self dismissViewControllerAnimated:YES completion:^{
                }];
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
