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
                
#endif
                [teachersArray  addObjectsFromArray:[resultDict objectForKey:@"teacherList"]];
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
-(void)login
{
    //URL
    NSURL * url=[NSURL URLWithString:[HOST_URL stringByAppendingString:URL_Login]];
    NSString* code=[[NSString stringWithFormat:@"%@_%@_%@",[dataCenter userMobile],[dataCenter userPassword],@"soshare_jxt"] MD5String];
    NSString* dataString = [NSString stringWithFormat:@"loginName=%@&password=%@&pwdmd5=%@",[dataCenter userMobile],[dataCenter userPassword],code];
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
                    //statusLabel.text=msg;
                });
                //NSString* msgCode=[dict objectForKey:@"msgcode"];
                NSDictionary* userInfoDict=[[dict objectForKey:@"result"] objectForKey:@"userInfo"];
                
                BOOL status=[[dict valueForKey:@"success"] boolValue];
                if(status&&[msg isEqualToString:@"登录成功"])
                {
                    //保存用户数据
                    [self saveUserInfoDictWithDict:userInfoDict];
                    //保存上次成功登录的账号
                    [[NSUserDefaults standardUserDefaults] setObject: [dataCenter userMobile] forKey:User_Mobile_Key];
                    [[NSUserDefaults standardUserDefaults] setObject:[dataCenter userPassword] forKey:User_Password_Key];
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
                NSLog(@"连接失败:%@",connectionError);
                //statusLabel.text=@"连接失败!";
//                [self dismissViewControllerAnimated:YES completion:^{
//                }];
            });
        }
        
    }];
    
    //
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
    [dict setObject: [self valueStringForTeacher] forKey:@"teachers"];

    
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
                    [self login];//登录
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
        [[NSNotificationCenter defaultCenter] postNotificationName:Select_All_Teacher_Notification object:aCheckBox];
        
        //NSLog(@"value:%@",[self valueStringForTeacher]);
    }
    btnTitleLabel.text=@"注册完成";
   
}
-(NSString*)valueStringForTeacher
{
    NSMutableString* valueString=[[NSMutableString alloc] init];
    for(int i=0;i<teachersArray.count;i++)
    {
        NSIndexPath * aPath=[NSIndexPath indexPathForRow:i inSection:0];
      RegisterFollowTeacherCell* cell= (RegisterFollowTeacherCell*)[teacherContainer cellForItemAtIndexPath:aPath];
        if(cell.checkBox.isChecked)
        {
            [valueString appendString:@","];
            [valueString appendFormat:@"%d",i];
        }
    }
    NSString* needString=@"";
    if(valueString.length>0)
        needString=[valueString substringFromIndex:1];
    [valueString release];
    NSLog(@"teacherValueString:%@",needString);
    return needString;
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

#pragma mark - collectionView datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return teachersArray.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* tmpDict=[teachersArray objectAtIndex:indexPath.row];
    if(indexPath.section==0)
    {
       RegisterFollowTeacherCell  *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"RegisterFollowTeacherCell" forIndexPath:indexPath];
        cell.nameLabel.text=[tmpDict objectForKey:@"teacherName"];
        cell.checkBox.tag=[[tmpDict objectForKey:@"teacherId"] integerValue];
        [cell.checkBox addTarget:cell action:@selector(checkBoxClicked:) forControlEvents:UIControlEventValueChanged];
        [cell.headImageView setImageWithURL:[NSURL URLWithString:[tmpDict objectForKey:@"teacherPic"]] placeholderImage:[UIImage imageNamed:@"teacherHead.png"]];
        return cell;
    }
    return nil;
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
