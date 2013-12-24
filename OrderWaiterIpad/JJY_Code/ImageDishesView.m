//
//  ImageDishesView.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-16.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "ImageDishesView.h"
#import "ChangeDishView.h"

@interface ImageDishesView()<ChangeDishViewDelegate>

@end

@implementation ImageDishesView
@synthesize imageDishView;
@synthesize L_dishName;
@synthesize delegate;
@synthesize dishView;
@synthesize productId;
@synthesize dishDictory;

- (id)initWithFrame:(CGRect)frame andDotNumber:(double)aDot
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
        
        //添加菜图片
        UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 136, 136)];
        imageView1.clipsToBounds = YES;
        imageView1.layer.cornerRadius = 5;
        self.imageDishView = imageView1;
        [self addSubview:imageView1];
        
        //添加菜名背景半透明
        UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 136, 36)];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.65;
        [imageView1 addSubview:bgView];
        
        //添加菜名lab
        UILabel * titleName = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 136, 36)];
        titleName.numberOfLines = 0;
        titleName.textAlignment = NSTextAlignmentCenter;
        titleName.adjustsFontSizeToFitWidth = YES;
        self.L_dishName = titleName;
        titleName.backgroundColor = [UIColor clearColor];
        titleName.textColor = [UIColor whiteColor];
        [imageView1 addSubview:titleName];
        
        //添加加减菜部分
        ChangeDishView * dishView1 = [[ChangeDishView alloc] initWithFrame:CGRectMake(0, 146, 136, 40) andIsRedButton:NO andDotNumber:aDot];
        dishView1.delegate = self;
        self.dishView = dishView1;
        [self addSubview:dishView1];
    }
    return self;
}
-(void)ChangeDishView:(ChangeDishView *)aChangeDishView andLeftDotNumber:(double)aDotNumber andPreDotNumber:(double)aPreDotNumber
{
    [self.delegate ChangeDishViewAtImageDishesView:self andLeftDotNumber:aDotNumber andPreDotNumber:aPreDotNumber];
}
-(void)ChangeDishView:(ChangeDishView *)aChangeDishView andRightDotNumber:(double)aDotNumber andPreDotNumber:(double)aPreDotNumber
{
    [self.delegate ChangeDishViewAtImageDishesView:self andRightDotNumber:aDotNumber andPreDotNumber:aPreDotNumber];
}

@end
