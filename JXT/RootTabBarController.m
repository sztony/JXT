//
//  RootTabBarController.m
//  JXT
//
//  Created by 伍 兵 on 14-7-19.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "RootTabBarController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

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
    //self.selectedIndex=1;
    NSArray* images=@[[UIImage imageNamed:@"首页1.png"],
                     [UIImage imageNamed:@"消息1.png"],
                     [UIImage imageNamed:@"搜索1.png"],
                     [UIImage imageNamed:@"设置1.png"]];
    NSArray* selectedImages=@[[UIImage imageNamed:@"首页2.png"],
                      [UIImage imageNamed:@"消息2.png"],
                      [UIImage imageNamed:@"搜索2.png"],
                      [UIImage imageNamed:@"设置2.png"]];
    NSDictionary* attriDict1=[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    NSDictionary* attriDict2=[NSDictionary dictionaryWithObjectsAndKeys:MAIN_COLOR,NSForegroundColorAttributeName,nil];
   for(UITabBarItem* item in self.tabBar.items)
   {
       NSLog(@"item.tag:%d",item.tag);
       if([[[UIDevice currentDevice] systemVersion] hasPrefix:@"7"])
       {
       item.image=[images[item.tag-1] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
       item.selectedImage=[selectedImages[item.tag-1] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
       
       }
       else
       {
        [item setFinishedSelectedImage:selectedImages[item.tag-1] withFinishedUnselectedImage:images[item.tag-1]];
    
       }
       [item setTitleTextAttributes:attriDict1 forState:UIControlStateNormal];
       [item setTitleTextAttributes:attriDict2 forState:UIControlStateSelected];
   }
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
