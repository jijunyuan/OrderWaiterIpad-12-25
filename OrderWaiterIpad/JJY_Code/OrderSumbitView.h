//
//  OrderSumbitView.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-18.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RATreeView.h"

@protocol OrderSumbitViewDelegate;
@class ThirdModeCell;
@class FirstModeCell;
@interface OrderSumbitView : UIView
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) NSMutableArray * extendArr;
@property (nonatomic,strong) RATreeView * raTreeView;
@property (nonatomic,assign) id<OrderSumbitViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame andDataArr:(NSMutableArray *)aArr;
@end

@protocol OrderSumbitViewDelegate <NSObject>
@optional
-(void)OrderSumbitView:(OrderSumbitView *)aOrderView andLeftDotNumber:(double)aDotNumber andProid:(NSString *)aProId andThirdCell:(ThirdModeCell *)aThirdCell;
-(void)OrderSumbitView:(OrderSumbitView *)aOrderView andRightDotNumber:(double)aDotNumber andProid:(NSString *)aProId andThirdCell:(ThirdModeCell *)aThirdCell;
-(void)OrderSumbitView:(OrderSumbitView *)aOrderView andFirstCell:(FirstModeCell *)aFirstCell andTypeName:(NSString *)aName andIson:(BOOL)aIsYes;
-(void)OrderSumbitView:(OrderSumbitView *)aOrderView treeView:(RATreeView *)treeView shouldExpandItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo;
@end