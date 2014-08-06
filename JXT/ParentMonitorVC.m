//
//  ParentMonitorVC.m
//  JXT
//
//  Created by 伍 兵 on 14-8-5.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "ParentMonitorVC.h"

@interface ParentMonitorVC ()

@end

@implementation ParentMonitorVC

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
    // Do any additional setup after loading the view.
}
-(IBAction)makePhoneCall:(id)sender
{
    NSURL* url=[NSURL URLWithString:@"tel://8008808888"];
    if([[UIApplication sharedApplication] canOpenURL:url])
        [[UIApplication sharedApplication] openURL:url];
    else
    {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请使用iPhone" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
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
