//
//  FollowBaseVC.m
//  JXT
//
//  Created by 伍 兵 on 14-8-8.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "FollowBaseVC.h"

@interface FollowBaseVC ()

@end

@implementation FollowBaseVC
@synthesize schoolId,phaseId;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if(self)
    {
        subjectsArray=[[NSMutableArray alloc] initWithCapacity:0];
        teachersArray=[[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}
-(void)dealloc
{
    [subjectsArray release];
    [teachersArray release];
    [super dealloc];
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
