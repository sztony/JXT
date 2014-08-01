//
//  SettingsVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-19.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "SettingsVC.h"
#import "PersonalVC.h"
@interface SettingsVC ()
{
    GlobalDataManager * m;
}
@end

@implementation SettingsVC

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
    //self.tableView.delegate=self;
    m=[GlobalDataManager sharedDataManager];
    
    nameLabel.text=m.userRealName;
    acountID.text=m.userMobile;
    
    
    
    // Do any additional setup after loading the view.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {

        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
    NSLog(@"indexpath:%d",indexPath.row);
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
