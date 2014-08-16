//
//  MyLessonVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-19.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "MyLessonVC.h"

@interface MyLessonVC ()
{
   
}
@end

@implementation MyLessonVC
@synthesize header1ID,header2ID,header3ID;
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
    [super dataInit];
    //segmentSelectIndexInitValue=1;
    relativeLessonArray =[[NSMutableArray alloc] initWithCapacity:0];
    self.header1ID=@"1";
    self.header2ID=@"1";
    self.header3ID=@"1";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //一级标签
    //segment.backgroundColor=[UIColor purpleColor];
    segment.selectedColor=[UIColor whiteColor];
    segment.normalColor=[UIColor colorWithRed:94/255.0 green:195/255.0 blue:1.0 alpha:0.8];
    segment.delegate=self;
    [segment setTitleArray:@[@"学校课程",@"我的课程"]];
    [segment setSegmentDirection:kWBSegmentHorizonal];
    segment.currentSelectedIndex=segmentSelectIndexInitValue;
    
    //二级标签
    [self.headerTitleArray addObject:@"今日课程"];
    [self.headerTitleArray addObject:@"今日作业"];
    [self.headerTitleArray addObject:@"我的课表"];
    [self refreshHeader];
    
    
    currentClickedHeader=header1;
    
    [self loadTableContent];
    // Do any additional setup after loading the view.
}

-(void)loadTableContent
{
    [self.contentDataArray removeAllObjects];
    
    //参数
    NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
    NSString* urlSuffix;
    if(segmentSelectIndexInitValue==1)
    {
        [dict setObject:[dataCenter userID] forKey:@"userId"];
        if(currentClickedHeader==header1)//今日课程
        {
            urlSuffix=URL_CourseByDate;
            
            [dict setObject:header1ID forKey:@"subjectId"];
            [dict setObject:@"3" forKey:@"courseSize"]; //默认3个
            [dict setObject:@"2014-01-01" forKey:@"courseTime"]; //默认今天 2014-01-01
        }
        else if (currentClickedHeader==header2)//今日作业
        {
            urlSuffix=URL_HomeWorkByDate;
            
            [dict setObject:header2ID forKey:@"subjectId"];
            [dict setObject:@"2014-01-01" forKey:@"courseTime"]; //默认今天 2014-01-01
        }
        else
        {
            urlSuffix=URL_Schedule;//课表
        
            [dict setObject:@"2014-01-01" forKey:@"beginDate"];
            //[dict setObject:@"3" forKey:@"courseSize"]; //默认3个
            [dict setObject:@"2014-01-03" forKey:@"endDate"]; //默认今天 2014-01-01
        }
    }
    else
    {
        urlSuffix=URL_MyCourseList;
        [dict setObject:[dataCenter userID] forKey:@"userId"];
        [dict setObject:header3ID forKey:@"subjectId"];
        [dict setObject:header1ID forKey:@"courseType"];
        [dict setObject:header2ID forKey:@"courseStatus"];
        
    }

    //URL
    NSURL* url=[NSURL URLWithString:[HOST_URL stringByAppendingString:urlSuffix]];

    //请求
    [WBHTTPRequest sendRequestWithURL:url parameterDict:dict type:kWBHTTPRequestPOSTType  queue:[dataCenter globalTaskQueue] completeHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"error:%@",connectionError);
        NSLog(@"data:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        //失败
        if(connectionError)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"连接错误:%@",connectionError);
                return ;
            });
        }
            NSError* error=nil;
            NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"dict:%@",dict);
            
            if(!error)
            {
#if USE_TEST_DATA
                //伪数据
                int count= arc4random()%10+1;
                NSLog(@"count:%d",count);
                for(int i=0;i<count;i++)
                {
                    if(segmentSelectIndexInitValue==1)
                    {
                        NSLog(@"title:%@",currentClickedHeader.titleLabel.text);
                        NSString* subject=[currentClickedHeader titleForState:UIControlStateNormal];
                        [self.contentDataArray addObject:@{@"title":[NSString stringWithFormat:@"%@课程%d",subject,i],@"content":[NSString  stringWithFormat:@"%@课程简介%d:aaaaaaaabbbbbbbbbbbbbbccccccccccccccccccddddddddddddddddddddddddddddd",subject,i]}];
                    }
                    else
                    {
                        NSString* idString=[NSString stringWithFormat:@"%d",i+1];
                        [self.contentDataArray addObject:@{@"courseId":idString,@"courseName":@"数学讲义",@"teacherName":@"牛老师",@"coursePic":@"http://223.71.208.118:8180/jxt_files/common/teacherDefaultPic.jpg",@"courseLength":@"20分钟",@"filePath":@"http://223.71.208.118:8180/jxt_files/common/teacherDefaultPic.jpg"}];
                    }
                }
                NSLog(@"contentArray:%@",self.contentDataArray);
                [relativeLessonArray addObject:@{@"courseId":@"1",@"courseName":@"函数",@"coursePic":@"http://223.71.208.118:8180/jxt_files/common/teacherDefaultPic.jpg"}];
                [relativeLessonArray addObject:@{@"courseId":@"2",@"courseName":@"公式",@"coursePic":@"http://223.71.208.118:8180/jxt_files/common/teacherDefaultPic.jpg"}];
                [relativeLessonArray addObject:@{@"courseId":@"3",@"courseName":@"数学",@"coursePic":@"http://223.71.208.118:8180/jxt_files/common/teacherDefaultPic.jpg"}];
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
                if([msg isEqualToString:@"今日无课程内容!"])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"%@",msg);
                        return ;
                    });
                }
                //NSString* msgCode=[dict objectForKey:@"msgcode"];
                NSDictionary* resultDict=[dict objectForKey:@"result"];
#endif
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //显示数据
                    [contentTableView reloadData];
                    [footerView reloadData];
                    if(segmentSelectIndexInitValue==1)
                    {
                        if(currentClickedHeader==header1)
                        {
                            footerView.hidden=NO;
                        }
                        else
                            footerView.hidden=YES;
                    }
                    else
                        footerView.hidden=YES;
                });
            }
            else
            {
                NSLog(@"login parse error:%@",error);
            }
    }];
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
-(void)awakeFromNib
{
    NSLog(@"awake");
}
//复写一级标签代理
-(void)WBSegment:(WBSegment *)aSegment DidSelectedItemIndex:(NSInteger)index
{
    [super WBSegment:segment DidSelectedItemIndex:index];
    segmentSelectIndexInitValue=aSegment.currentSelectedIndex;
    self.header1ID=@"1";
    self.header2ID=@"1";
    self.header3ID=@"1";
    if(index==1)
    {
        [self.headerTitleArray removeAllObjects];
        [self.headerTitleArray addObject:@"今日课程"];
        [self.headerTitleArray addObject:@"今日作业"];
        [self.headerTitleArray addObject:@"我的课表"];
        [self refreshHeader];
    }
    else
    {
        [self.headerTitleArray removeAllObjects];
        [self.headerTitleArray addObject:@"视频课程"];
        [self.headerTitleArray addObject:@"未听课程"];
        [self.headerTitleArray addObject:@"数学"];
        [self refreshHeader];
    }
    [self loadTableContent];
    
}
//复写二级标签事件函数
-(void)headerClicked:(WBCombListHeader*)aHeader
{
    [super headerClicked:aHeader];
    NSArray* array;
    
    if(segment.currentSelectedIndex==1)
    {
        switch (aHeader.tag) {
            case 1:
                
            case 2:
                array=[dataCenter subjectsArray];
                break;
            default:
                array=@[@""];
                break;
        }
    }
    else
    {
        switch (aHeader.tag) {
            case 1:
                array=@[@"视频课程",@"文本课程",];
                break;
            case 2:
                array=@[@"未听课程",@"已听课程"];
                break;
            default:
                array=[dataCenter subjectsArray];
                break;
        }
    }
    //更新数据
    [self.currentCombListItemArray  removeAllObjects];
    [self.currentCombListItemArray addObjectsFromArray:array];
    //显示
    [WBCombList  showInRect:CGRectMake(aHeader.frame.origin.x,aHeader.frame.origin.y+aHeader.bounds.size.height,aHeader.bounds.size.width, 300) edgeInset:UIEdgeInsetsMake(3, 3, 3, 3) delegate:self inView:self.view withTag:aHeader.tag];
}
//复写combList代理
-(void)combList:(WBCombList *)aCombList SelectedIndexPath:(NSIndexPath *)aIndexPath

{
    [super combList:aCombList SelectedIndexPath:aIndexPath];
    NSString* clickedTitle=[self.currentCombListItemArray objectAtIndex:aIndexPath.row];
    [currentClickedHeader setTitle:clickedTitle forState:UIControlStateNormal];
    if(segmentSelectIndexInitValue==1)
    {
        if(aCombList.tag==1)
        {
            self.header1ID=[dataCenter subjectIdForSubject:clickedTitle];
        }
        else if(aCombList.tag==2)
        {
             self.header2ID=[dataCenter subjectIdForSubject:clickedTitle];
        }
        else
        {
            
        }
    }
    else
    {
        if(aCombList.tag==1)
        {
           self.header1ID=[NSString stringWithFormat:@"%d",aIndexPath.row+1];
        }
        else if(aCombList.tag==2)
        {
            self.header2ID=[NSString stringWithFormat:@"%d",aIndexPath.row+1];
        }
        else
        {
            self.header3ID=[dataCenter subjectIdForSubject:clickedTitle];
        }
    }
    
    //更新数据
    [self loadTableContent];
    
    
}
#pragma mark - tableView datasource 
//CombList数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView.tag==TAG_ContentTable)
    {
        
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag==TAG_ContentTable)
    {
        NSLog(@"count:%d",self.contentDataArray.count);
        return self.contentDataArray.count;
    }
    return self.currentCombListItemArray.count;
}
//今日课程相关课程footerView
/*
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(segmentSelectIndexInitValue==1&&currentClickedHeader==header1&&tableView.tag==TAG_ContentTable)
    {
        return 84;
    }
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(segmentSelectIndexInitValue==1&&currentClickedHeader==header1&&tableView.tag==TAG_ContentTable)
    {
        UICollectionView* footerView=[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:
    }
}
 */
#pragma mark - collectionView datasource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return relativeLessonArray.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* tmpDict=[relativeLessonArray objectAtIndex:indexPath.row];
    if(indexPath.section==0)
    {
        RelativeLessonCell  *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"RelativeLessonCell" forIndexPath:indexPath];
        cell.subjectName.text =[tmpDict objectForKey:@"courseName"];
        cell.tag=[[tmpDict objectForKey:@"courseId"] integerValue];
        [cell.subjectImageView setImageWithURL:[NSURL URLWithString:[tmpDict objectForKey:@"coursePic"]] placeholderImage:[UIImage imageNamed:@"teacherHead.png"]];
        return cell;
    }
    return nil;
}
//今日作业HeaderView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if(segmentSelectIndexInitValue==1&&currentClickedHeader==header2&&tableView.tag==TAG_ContentTable)
    {
        return 115;
    }
    return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(segmentSelectIndexInitValue==1&&currentClickedHeader==header2&&tableView.tag==TAG_ContentTable)
    {
        HomeWorkTopView* header=[[[HomeWorkTopView  alloc] init] autorelease];
        //header.backgroundColor=[UIColor yellowColor];
        return header;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==TAG_ContentTable)
    {
        if(segmentSelectIndexInitValue==1)
            return 120;
        else
            return 80;
    }
    return 30;
}
//combList自定义cell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView.tag==TAG_ContentTable)
    {
        if(segment.currentSelectedIndex==1)
        {
            SchoolLessonCustomCell* cell=[tableView dequeueReusableCellWithIdentifier:@"SchoollLessonCell"];
            cell.subjectTitle.text=[[self.contentDataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
            cell.subjectContent.text=[[self.contentDataArray objectAtIndex:indexPath.row] objectForKey:@"content"];
            return cell;
            
        }
        else
        {
            BOOL isVideo= [header1ID isEqualToString:@"1"]?YES:NO;
            MyLessonBaseCell* cell=[tableView dequeueReusableCellWithIdentifier:isVideo? @"MyLessonVideoCell":@"MyLessonTextCell"];
            NSDictionary* tmpDict=[self.contentDataArray objectAtIndex:indexPath.row];
            cell.subjectTitle.text=[tmpDict objectForKey:@"courseName"];
            cell.subjectTeacher.text=[tmpDict objectForKey:@"teacherName"];
            [cell.subjectImage setImageWithURL:[NSURL URLWithString:[tmpDict objectForKey:@"coursePic"] ] placeholderImage:[UIImage imageNamed:@"math.png"]];
            if(isVideo)
            {
                ((MyLessonVideoCell*)cell).subjectTime.text=[tmpDict objectForKey:@"courseLength"];
            }
            else
            {
                [((MyLessonTextCell*)cell).downloadBtn setTitle:[tmpDict objectForKey:@"filePath"] forState:UIControlStateNormal];
            }
            return cell;
        }
        
    }
    
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"]autorelease];
    }
    cell.backgroundColor=[UIColor whiteColor];
    cell.textLabel.text=[self.currentCombListItemArray objectAtIndex:indexPath.row];
    
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [relativeLessonArray release];
    [super dealloc];
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
