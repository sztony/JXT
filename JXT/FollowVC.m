//
//  FollowVC.m
//  JXT
//
//  Created by 伍 兵 on 14-8-5.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "FollowVC.h"

@interface FollowVC ()

@end

@implementation FollowVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)fetchFollowInfo
{
    //URL
    NSURL* url=[NSURL URLWithString:[HOST_URL stringByAppendingString:URL_getUserFollowInfo]];
    //参数
    NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
    [dict setObject:[dataCenter userID] forKey:@"userId"];
   
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
                [teachersArray addObjectsFromArray:@[                                          @{@"teacherName":@"张荣汉",@"teacherId":@"1",@"teacherSchool":@"繁昌一中",@"teacherPic":@"http://223.71.208.118:8180/jxt_files/common/teacherDefaultPic.jpg",},
                    @{@"teacherName":@"朱丽丽",@"teacherId":@"2",@"teacherSchool":@"繁昌一中",@"teacherPic":@"http://223.71.208.118:8180/jxt_files/common/teacherDefaultPic.jpg",},
                    @{@"teacherName":@"梅小静",@"teacherId":@"3",@"teacherSchool":@"繁昌一中",@"teacherPic":@"http://223.71.208.118:8180/jxt_files/common/teacherDefaultPic.jpg",},
                    @{@"teacherName":@"刘佳佳",@"teacherId":@"4",@"teacherSchool":@"繁昌一中",@"teacherPic":@"http://223.71.208.118:8180/jxt_files/common/teacherDefaultPic.jpg",},
                    @{@"teacherName":@"方梅玉",@"teacherId":@"5",@"teacherSchool":@"繁昌一中",@"teacherPic":@"http://223.71.208.118:8180/jxt_files/common/teacherDefaultPic.jpg",},
                    @{@"teacherName":@"陈家明",@"teacherId":@"6",@"teacherSchool":@"繁昌一中",@"teacherPic":@"http://223.71.208.118:8180/jxt_files/common/teacherDefaultPic.jpg",}
                                                                                               ]];
                [subjectsArray addObjectsFromArray:[resultDict objectForKey:@"subjectList"]];
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
    [self fetchFollowInfo];
    
    [checkBox addTarget:self action:@selector(selectAllSubjects:) forControlEvents:UIControlEventValueChanged];
    // Do any additional setup after loading the view.
}
-(void)selectAllSubjects:(WBCheckBox*)aCheckBox
{
    aCheckBox.isChecked=!aCheckBox.isChecked;
    [subjectsContainer allCheck:aCheckBox.isChecked];
    
    [self followSubject:[subjectsContainer allValueString] orNot:aCheckBox.isChecked];
}
-(void)followSubject:(NSString*)aSubjectId orNot:(BOOL)wantFollow
{
    //URL
    NSString* urlSuffix=wantFollow?URL_addUserFollowSubject:URL_delUserFollowSubject;
    NSURL* url=[NSURL URLWithString:[HOST_URL stringByAppendingString:urlSuffix]];
    //参数
    NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
    [dict setObject:dataCenter.userID forKey:@"userId"];
    [dict setObject:aSubjectId forKey:@"subjectIds"];
    
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
                dispatch_async(dispatch_get_main_queue(), ^{
                    //NSLog(@"%@",msg);
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
-(void)SubjectContainerClickedCheckBox:(WBCheckBox *)aCheckBox
{
    [self followSubject:[NSString stringWithFormat:@"%d",aCheckBox.tag] orNot:aCheckBox.isChecked];
}
-(IBAction)addBtnClicked:(id)sender
{
    
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
        FollowTeacherCell  *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"FollowTeacherCell" forIndexPath:indexPath];
        cell.nameLabel.text=[tmpDict objectForKey:@"teacherName"];
        cell.btnLabel.tag=[[tmpDict objectForKey:@"teacherId"] integerValue];
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc] initWithTarget:cell action:@selector(btnLabelTapped:)];
        [cell.btnLabel addGestureRecognizer:tap];
        [tap release];
        cell.schoolLabel.text=[tmpDict objectForKey:@"teacherSchool"];
        [cell.headImageView setImageWithURL:[NSURL URLWithString:[tmpDict objectForKey:@"teacherPic"]] placeholderImage:[UIImage imageNamed:@"teacherHead.png"]];
        return cell;
    }
    return nil;
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
