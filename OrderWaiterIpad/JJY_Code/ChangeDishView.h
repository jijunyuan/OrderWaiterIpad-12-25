//
//  ChangeDishView.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-17.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeDishViewDelegate;
@interface ChangeDishView : UIView
@property (nonatomic,strong) UIButton * leftButton,*rightButton;
@property (nonatomic,strong) UILabel * middleLab;
@property (nonatomic,assign) double dotNumber;
@property (nonatomic,assign) id<ChangeDishViewDelegate> delegate;
@property (nonatomic,assign) BOOL isOrderButton;

- (id)initWithFrame:(CGRect)frame andIsRedButton:(BOOL)isRed;
- (id)initWithFrame:(CGRect)frame andIsRedButton:(BOOL)isRed andDotNumber:(double)aDotNumber;
@end

@protocol ChangeDishViewDelegate <NSObject>
@optional
-(void)ChangeDishView:(ChangeDishView *)aChangeDishView andLeftDotNumber:(double)aDotNumber andPreDotNumber:(double)aPreDotNumber;
-(void)ChangeDishView:(ChangeDishView *)aChangeDishView andRightDotNumber:(double)aDotNumber andPreDotNumber:(double)aPreDotNumber;
@end