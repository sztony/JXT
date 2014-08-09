//
//  FollowTeacherCell.m
//  JXT
//
//  Created by 伍 兵 on 14-8-9.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "FollowTeacherCell.h"

@implementation FollowTeacherCell
@synthesize schoolLabel;
@synthesize btnLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        
    }
    return self;
}
-(void)followTecherByTeacherId:(NSString*)aId orNot:(BOOL)wantFollow
{
    GlobalDataManager * dataCenter=[GlobalDataManager sharedDataManager];
    //URL
    NSString* urlSuffix=wantFollow?URL_addUserFollowTeacher:URL_delUserFollowTeacher;
    NSURL* url=[NSURL URLWithString:[HOST_URL stringByAppendingString:urlSuffix]];
    //参数
    NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
    [dict setObject:[dataCenter userID] forKey:@"userId"];
    [dict setObject:aId forKey:@"teacherId"];
    
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
                    NSString* title=wantFollow?@"取消关注":@"重新关注";
                    btnLabel.text=title;
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
-(void)btnLabelTapped:(UITapGestureRecognizer*)sender
{
    NSLog(@"tapped:%d",btnLabel.tag);
    BOOL wantFollow= ![btnLabel.text isEqualToString:@"取消关注"];
    [self followTecherByTeacherId:[NSString stringWithFormat:@"%d",btnLabel.tag] orNot:wantFollow];
    
        
}
-(void)dealloc
{
    [schoolLabel release];
    [btnLabel release];
    [super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
