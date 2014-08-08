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
    passwordField.secureTextEntry=YES;
    nameField.text=[[NSUserDefaults standardUserDefaults] objectForKey:User_Mobile_Key];
    passwordField.text=[[NSUserDefaults standardUserDefaults] objectForKey:User_Password_Key];
    //self.navigationController.navigationBar.hidden=YES;
    // Do any additional setup after loading the view.
}
-(void)saveUserInfoDictWithDict:(NSDictionary*)aDict
{
    GlobalDataManager * m=[GlobalDataManager sharedDataManager];
    
    NSLog(@"aDict:%@",aDict);
    NSString* nickName;
    if([aDict objectForKey:@"nickName"]==[NSNull null])
    {
        nickName=@"昵称";
    }
    else
    {
        nickName=[aDict objectForKey:@"nickName"];
    }
    if([aDict objectForKey:@"schoolName"]==[NSNull null])
        m.userSchoolName=@"学校名称";
    else
        m.userSchoolName=[aDict objectForKey:@"schoolName"];
    
    m.userID=[aDict objectForKey:@"userId"];
    m.userMobile=[aDict objectForKey:@"mobile"];
    m.userRealName=[aDict objectForKey:@"realName"];
    m.userNickName=nickName;
    
    m.userPic=[aDict objectForKey:@"userPic"];
    m.userBigPic=[aDict objectForKey:@"userBigPic"];
    
    NSLog(@"id:%@",m.userID);
}
-(IBAction)loginBtnClicked:(id)sender
{
    //URL
    NSURL * url=[NSURL URLWithString:[HOST_URL stringByAppendingString:URL_Login]];
    NSString* code=[[NSString stringWithFormat:@"%@_%@_%@",nameField.text,passwordField.text,@"soshare_jxt"] MD5String];
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
                //NSString* msgCode=[dict objectForKey:@"msgcode"];
                NSDictionary* userInfoDict=[[dict objectForKey:@"result"] objectForKey:@"userInfo"];
                
                BOOL status=[[dict valueForKey:@"success"] boolValue];
                if(status&&[msg isEqualToString:@"登录成功"])
                {
                    //保存用户数据
                    [self saveUserInfoDictWithDict:userInfoDict];
                    //保存上次成功登录的账号
                    [[NSUserDefaults standardUserDefaults] setObject: nameField.text forKey:User_Mobile_Key];
                    [[NSUserDefaults standardUserDefaults] setObject:passwordField.text forKey:User_Password_Key];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
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
