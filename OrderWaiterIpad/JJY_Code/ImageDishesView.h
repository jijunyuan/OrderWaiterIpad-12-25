//
//  ImageDishesView.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-16.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImageDishViewDelegate;
@class ChangeDishView;
@interface ImageDishesView : UIView
@property (nonatomic,strong) UIImageView * imageDishView;
@property (nonatomic,strong) UILabel * L_dishName;
@property (nonatomic,assign) id<ImageDishViewDelegate>delegate;
@property (nonatomic,strong) ChangeDishView * dishView;
@property (nonatomic,strong) NSString * productId;
@property (nonatomic,strong) NSDictionary * dishDictory; //菜字典

- (id)initWithFrame:(CGRect)frame andDotNumber:(double)aDot;
@end

@protocol ImageDishViewDelegate <NSObject>
@optional
-(void)ChangeDishViewAtImageDishesView:(ImageDishesView *)aChangeDishView andLeftDotNumber:(double)aDotNumber andPreDotNumber:(double)aPreDotNumber;
-(void)ChangeDishViewAtImageDishesView:(ImageDishesView *)aChangeDishView andRightDotNumber:(double)aDotNumber andPreDotNumber:(double)aPreDotNumber;
@end