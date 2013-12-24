//
//  Detail_DishesViewController.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-11.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DishClickView.h"
@interface Detail_DishesViewController : BaseViewController
@property (nonatomic,strong) NSMutableDictionary * DC_mark;
@property (nonatomic,strong) UIButton * sumbit_order;
@property (nonatomic,strong) UIImageView * lineImg;
-(void)yesClick1:(id)sender;
@end
