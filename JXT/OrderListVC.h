//
//  OrderListVC.h
//  JXT
//
//  Created by 伍 兵 on 14-8-6.
//  Copyright (c) 2014年 伍 兵. All rights reserved.
//

#import "RootVC.h"
#import "OrderListCell.h"
@interface OrderListVC : RootVC<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView* contentTableView;
}
@end
