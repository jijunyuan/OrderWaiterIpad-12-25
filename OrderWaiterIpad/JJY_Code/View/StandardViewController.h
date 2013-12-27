//
//  StandardViewController.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-17.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ImageDishesView.h"
#import "OrderSumbitView.h"
@interface StandardViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ImageDishViewDelegate>
{
    UITableView       *aTableView;
    NSMutableArray    *array;
    BOOL flag[26];//里面默认值为no；记录三个区是开是合
    NSMutableArray    *array3;
    UIScrollView      * scrollView;
    NSMutableArray    *myProArr;
    int               menuID;
    NSMutableArray    *menuIDary;
    int               taocanID;
}
@property(nonatomic,retain)NSMutableArray    *array;
@property (nonatomic,strong) NSMutableArray * myClassArr,* myProArr;
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) OrderSumbitView * orderSumbitView;
@property (nonatomic,strong) NSMutableArray * clarrleftArr;
@property (nonatomic,strong) NSMutableDictionary * remberDishNumber;
@property (nonatomic,strong) NSMutableDictionary * remberMarkValueDic;
@property (nonatomic,strong) NSMutableDictionary * remberDishStatusDic;
@end
