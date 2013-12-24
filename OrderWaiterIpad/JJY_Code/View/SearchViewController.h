//
//  SearchViewController.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-12.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "BaseViewController.h"
@interface SearchViewController : BaseViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UISearchBar *aSearchBar;
    NSMutableArray      *listAry;
    UITableView *aTableView;
}
@property(nonatomic,retain)NSMutableArray     *listAry;
@end
