//
//  PersonalVC.m
//  JXT
//
//  Created by CW on 14-7-22.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "PersonalVC.h"

@interface PersonalVC ()
{
    GlobalDataManager* m;
}
@end

@implementation PersonalVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
     
    }
    return self;
}
-(void)awakeFromNib
{
   
}
-(void)viewWillAppear:(BOOL)animated
{
    nickNameLabel.text=m.userNickName;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    m = [GlobalDataManager sharedDataManager];
    
    NSLog(@"realName:%@",m.userRealName);
    
    
    realNameLabel.text=m.userRealName;
    schoolLabel.text=m.userSchoolName;
    mobileLabel.text=m.userMobile;
    
    NSLog(@"xx:%@",realNameLabel.text);
    
    // Do any additional setup after loading the view.
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
