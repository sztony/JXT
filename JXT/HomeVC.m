//
//  HomeVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-19.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "HomeVC.h"

@interface HomeVC ()
{
    IBOutlet UIButton* btn1;

    IBOutlet UIButton* btn2;

    IBOutlet UIButton* btn3;

}
@end

@implementation HomeVC

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
    if(!IS_IOS_7)
    {
        NSLog(@"color:%@",self.view.backgroundColor);
        self.view.backgroundColor=MIAN_BACK_COLOR;
    }
    // Do any additional setup after loading the view.
    
    
    [self performSegueWithIdentifier:@"login" sender:self];
    
}
-(IBAction)btnClicked:(id)sender
{
    
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
