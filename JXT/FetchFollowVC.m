//
//  FetchFollowVC.m
//  JXT
//
//  Created by 伍 兵 on 14-8-8.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "FetchFollowVC.h"

@interface FetchFollowVC ()

@end

@implementation FetchFollowVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)fetchFollowList
{
    NSLog(@"schoolId:%@",dataCenter.userSchoolId);
    NSLog(@"pahseId:%@",dataCenter.userPhaseId);
    
    
    //URL
    NSURL* url=[NSURL URLWithString:[HOST_URL stringByAppendingString:URL_Recommed]];
    //参数
    NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
    [dict setObject:[dataCenter userSchoolId] forKey:@"schoolId"];
    [dict setObject:[dataCenter userPhaseId] forKey:@"phaseId"];
    [dict setObject:@"6" forKey:@"teacherSize"];
    
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
        
        //NSLog(@"areaList:%@",schoolArray);
        if(!error)
        {
            //消息检测
            NSString* msg=[backDataDict objectForKey:@"msg"];
            if([msg hasPrefix:@"操作成功"])
            {
               
#if USE_TEST_DATA
                
                [subjectsArray addObjectsFromArray:@[                                          @{@"subjectName":@"语文",@"subjectId":@"1"},
                    @{@"subjectName":@"数学",@"subjectId":@"2"},
                    @{@"subjectName":@"外语",@"subjectId":@"3"},
                    @{@"subjectName":@"物理",@"subjectId":@"4"},
                    @{@"subjectName":@"化学",@"subjectId":@"5"}]];
#else
                 [subjectsArray addObjectsFromArray:[resultDict objectForKey:@"subjectList"]];
                 [teachersArray  addObjectsFromArray:[resultDict objectForKey:@"teacherList"]];
#endif
               
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"%@",msg);
                    [subjectsContainer updateSubjectsArrayWithArray:subjectsArray];//科目
                    [teacherContainer reloadData];//教师
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
    
    checkBox1.fillColor=MAIN_COLOR;
    checkBox2.fillColor=MAIN_COLOR;
    [checkBox1 addTarget:self action:@selector(fullSelectCheckBoxClicked:) forControlEvents:UIControlEventValueChanged];
    [checkBox2 addTarget:self action:@selector(fullSelectCheckBoxClicked:) forControlEvents:UIControlEventValueChanged];
    
    
    [self fetchFollowList];
    // Do any additional setup after loading the view.
}
-(IBAction)endRegisterBtnClicked:(id)sender
{
    [subjectsContainer valueString];
    [self endRegister];
    
}
-(void)endRegister
{
    //URL
    NSURL* url=[NSURL URLWithString:[HOST_URL stringByAppendingString:URL_Register]];
    //参数
    NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
    [dict setObject:dataCenter.userRealName forKey:@"realName"];
    [dict setObject:dataCenter.userPassword forKey:@"password"];
    [dict setObject:dataCenter.userMobile forKey:@"mobile"];
    [dict setObject:dataCenter.userSchoolId forKey:@"schoolId"];
    [dict setObject:dataCenter.userPhaseId forKey:@"phaseId"];
    [dict setObject:[subjectsContainer valueString] forKey:@"subjecdts"];
    [dict setObject:@"4" forKey:@"teachers"];

    
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
        //NSLog(@"areaList:%@",schoolArray);
        if(!error)
        {
            //消息检测
            NSString* msg=[backDataDict objectForKey:@"msg"];
            if([msg hasPrefix:@"操作成功"])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"%@",msg);
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
-(void)fullSelectCheckBoxClicked:(WBCheckBox*)aCheckBox
{
    aCheckBox.isChecked=!aCheckBox.isChecked;
    if(aCheckBox.tag==1)
    {
        NSLog(@"handle subjects full select");
        [subjectsContainer allCheck:aCheckBox.isChecked];
    }
    else if(aCheckBox.tag==2)
    {
        NSLog(@"handle teachers full select");
    }
    btnTitleLabel.text=@"注册完成";
   
}
-(void)SubjectContainerClickedCheckBox:(WBCheckBox *)aCheckBox
{
     btnTitleLabel.text=@"注册完成";
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
