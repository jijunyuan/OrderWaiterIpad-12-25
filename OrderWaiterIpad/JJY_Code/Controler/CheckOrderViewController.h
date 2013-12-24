//
//  CheckOrderViewController.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-13.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "BaseViewController.h"
@interface CheckOrderViewController : BaseViewController
@property (nonatomic,strong) NSString * contact;
@property (nonatomic,strong) NSString * mark;
@property (nonatomic) int tableNum;
@property (nonatomic,strong) NSMutableDictionary * DC_mark;
@property (nonatomic)BOOL isAddDishes;
@property (nonatomic) int orderId;
@end
