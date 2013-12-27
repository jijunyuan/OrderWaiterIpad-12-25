//
//  MainViewController.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-16.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavgationView.h"
#import "LeftBottomView.h"
#import "OrderSumbitView.h"

#import "DataBase1.h"

#import "ImageDishesView.h"
#import "UIImageView+WebCache.h"
#import "BottomView.h"
#import "RADataObject.h"
#import "OrderListViewController.h"
#import "StandardViewController.h"

@interface MainViewController : UIViewController<UISearchBarDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UIView      *customView;
    UIImageView *backImage;
    UITextField *nameTF,*priceTF;
    UIButton    *cancelBtn,*sureBtn;
    NSArray     *titleAry,*typeIDAry;
    NSMutableArray *btnAry;
    int         typeID;
}
@property (nonatomic,strong) UINavgationView * navView;
@property (nonatomic,strong) LeftBottomView * leftBottomView;
@property (nonatomic,strong) NSMutableArray * clarrleftArr;
@property (nonatomic,strong) NSMutableArray * myClassArr,* myProArr;
@property (nonatomic,strong) OrderSumbitView * orderSumbitView;
@property (nonatomic,strong) NSMutableDictionary * remberDishNumber;
@property (nonatomic,strong) NSMutableDictionary * remberMarkValueDic;
@property (nonatomic,strong) NSMutableDictionary * remberDishStatusDic;

@property (nonatomic,strong) NSMutableDictionary * dataProArr;
@property (nonatomic,strong) NSString * orderId;
@property (nonatomic,strong) NSString * tableId;
@property (nonatomic,strong) NSString * tableNum;
@property (nonatomic,strong) NSString * peopleNum;

@property (nonatomic,assign) BOOL isFromAddMain;

-(void)viewWillAppear:(BOOL)animated;
-(void)signUpClick;

-(void)reloadRATreeData;
-(void)addDishUI;
@end
