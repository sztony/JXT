//
//  CartVC.m
//  JXT
//
//  Created by 伍 兵 on 14-8-6.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "CartVC.h"

@interface CartVC ()
{
    NSMutableArray* dataArray;
}
@end

@implementation CartVC

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
    dataArray=[[NSMutableArray alloc] init];
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
-(void)dealloc
{
    [dataArray release];
    [super dealloc];
}
-(void)reloadDataArray
{
    for(int i=0;i<=10;i++)
    {
        NSString* title=[NSString stringWithFormat:@"课程%d",i];
        [dataArray addObject:@{@"title":title,@"time":@"2014-08-04",@"price":@"$3.0",@"image":@"math.png"}];
    }
    
    [contentTableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self reloadDataArray];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListCell* cell=[tableView dequeueReusableCellWithIdentifier:@"CartListCell"];
    NSDictionary* tmpDict=[dataArray objectAtIndex:indexPath.row];
    cell.subjectImageView.image=[UIImage imageNamed:[tmpDict objectForKey:@"image"]];
    cell.subjectTitle.text=[tmpDict objectForKey:@"title"];
    cell.subjectBuyTime.text=[tmpDict objectForKey:@"time"];
    cell.subjectPrice.text=[tmpDict objectForKey:@"price"];
    return cell;
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
