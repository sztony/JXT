//
//  BaseVC.m
//  JXT
//
//  Created by 伍 兵 on 14-7-22.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()
{
    
}
@end

@implementation BaseVC
@synthesize headerTitleArray;
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
    headerTitleArray=[[NSMutableArray alloc] initWithCapacity:3];
    
    
    segment=[[WBSegment alloc] initWithFrame:CGRectMake(0, 64, 320, 50) titleArray:@[@"1",@"2"] normalColor:[UIColor whiteColor] directionVertical:NO];
    segment.delegate=self;
    [self.view addSubview:segment];
    // Do any additional setup after loading the view from its nib.
}
-(void)refreshHeader
{
    for(int i=1;i<=self.headerTitleArray.count;i++)
    {
        NSString* title=[self.headerTitleArray objectAtIndex:i-1];
        WBCombListHeader* header=(WBCombListHeader*) [self.view viewWithTag:i];
        //[header setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [header addTarget:self action:@selector(headerClicked:) forControlEvents:UIControlEventTouchUpInside];
        header.rightImage=[UIImage imageNamed:@"detailDown.png"];
        [header setTitle:title forState:UIControlStateNormal];
    }
}
-(void)WBVerticalSegment:(WBSegment *)aSegment DidSelectedItemIndex:(NSInteger)index
{
    NSLog(@"index:%d",index);
}
-(void)headerClicked:(WBCombListHeader*)aHeader
{
     NSLog(@"seg:%d",segment.currentSelectedIndex);
    NSLog(@"tag:%d",aHeader.tag);
    NSArray* array;
    if(segment.currentSelectedIndex==1)
    {
        switch (aHeader.tag) {
            case 1:
                array=@[@"item1",@"item2",@"item3"];
                break;
            case 2:
                array=@[@"item11",@"item22",@"item33"];
                break;
            default:
                 array=@[@"item111",@"item222",@"item333"];
                break;
        }
    }
    else
    {
        switch (aHeader.tag) {
            case 1:
                array=@[@"item1",@"item2",@"item3"];
                break;
            case 2:
                array=@[@"item11",@"item22",@"item33"];
                break;
            default:
                array=@[@"item111",@"item222",@"item333"];
                break;
        }
    }
     [WBCombList  showInRect:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) edgeInset:UIEdgeInsetsMake(10, 20, 10, 20) delegate:self inView:self.view withTag:2];
    
}
-(void)combList:(WBCombList *)aCombList SelectedIndexPath:(NSIndexPath *)aIndexPath
{
    
}
-(void)dealloc
{
    [headerTitleArray release];
    [segment release];
    [super dealloc];
    NSLog(@"baseVC dealloc");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
