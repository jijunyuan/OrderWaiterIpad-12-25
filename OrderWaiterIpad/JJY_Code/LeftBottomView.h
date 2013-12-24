//
//  LeftBottomView.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-17.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftBottomView : UIView
@property (nonatomic,strong) UITextField * TF_dishesNum,* TF_peopleNum;
@property (nonatomic,strong) UILabel * L_dishNum,* L_sum;
@property (nonatomic,strong) UIButton * sumbitBtn,* orderManageBtn;
@property (nonatomic,strong) NSString * tableId;
@end
