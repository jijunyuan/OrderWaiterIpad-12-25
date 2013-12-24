//
//  Checked_dishesViewController.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-13.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "BaseViewController.h"
#import "FPPopoverController.h"
@interface Checked_dishesViewController : BaseViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray         *checkedAry;
    UITextField     *tableNumTF;
    UITextField     *personNumTF;
    FPPopoverController *popover;
    NSString        *table_id;
    NSArray         *allKeysAry,*dishAry;
    UIScrollView    *ascrollview;
    UITableView     *dishesTable;
    NSMutableArray  *dishesMutAry;
    UIImageView     *bgImage;
    UILabel         *totalLab2,*totalpriceLab2;
}
@property(nonatomic,retain)NSArray *checkedAry,*allKeysAry,*dishAry;
@property(nonatomic,retain)NSMutableArray *dishesMutAry;
@end
