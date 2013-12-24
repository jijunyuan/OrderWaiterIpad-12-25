//
//  Check_Order_DetailViewController.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-12.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "BaseViewController.h"
#import "FPPopoverController.h"
@interface Check_Order_DetailViewController : BaseViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray        *check_ary;
    FPPopoverController *popover;
    UITextField    *tableNumTF;
    UITextField    *personNumTF;
    NSString       *table_id;
    NSMutableArray *dishesMutAry;
    UITableView    *dishesTable;
    NSArray        *allKeysAry;
    UIScrollView   *ascrollview;
    NSArray        *dishAry;
    NSMutableArray *mutAryID;
    NSMutableArray *mutAryStatus;
    NSString       *IDstr;
    UIImageView    *bgImage;
    UILabel        *totalLab2,*totalpriceLab2;
}
@property(nonatomic,retain)NSArray             *check_ary;
@property(nonatomic,retain)NSMutableArray      *dishesMutAry;
@property(nonatomic,retain)NSArray             *allKeysAry,*dishAry;
@end
