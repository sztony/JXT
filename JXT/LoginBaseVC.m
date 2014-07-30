//
//  LoginBaseVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-30.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "LoginBaseVC.h"

@interface LoginBaseVC ()

@end

@implementation LoginBaseVC

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   for(UIView * aView in  [self.view subviews])
   {
       if([aView isKindOfClass:[UITextField class]])
       {
           [aView resignFirstResponder];
       }
   }
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
