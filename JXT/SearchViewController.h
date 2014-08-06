//
//  SearchViewController.h
//  JXT
//
//  Created by 伍 兵 on 14-7-22.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultCell.h"
#import "RootVC.h"
@interface SearchViewController : RootVC<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UISearchBar * searchBar;
    IBOutlet UITableView * contentTableView;
    
    NSMutableArray* dataArray;
    
    NSInteger segmentCurrentSelectedIndex;
}
@end
