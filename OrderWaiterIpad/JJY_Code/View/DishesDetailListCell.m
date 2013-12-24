//
//  DishesDetailListCell.m
//  OrderMenu
//
//  Created by tiankong360 on 13-7-10.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "DishesDetailListCell.h"
#import <QuartzCore/QuartzCore.h>
@interface DishesDetailListCell()
-(void)leftClick:(UIButton *)aLeft;
-(void)rightClick:(UIButton *)aRight;
-(void)bigClick:(UIButton *)aBig;
@end
@implementation DishesDetailListCell
@synthesize backgroundImageView;
@synthesize leftImageView;
@synthesize titleLab;
@synthesize priceLab;
@synthesize dishesButton;
@synthesize dishView;
@synthesize delegate;
@synthesize btn_mark;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView * bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 732, 132)];
        bgView.userInteractionEnabled = YES;
        self.backgroundImageView = bgView;
        [self addSubview:bgView];
        
        UIImageView * leftView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 112, 112)];
        leftView.layer.borderWidth = 1;
        leftView.layer.borderColor = [UIColor grayColor].CGColor;
        leftView.layer.cornerRadius = 4;
        self.leftImageView = leftView;
        [bgView addSubview:leftView];
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(152, 30, 240, 40)];
        title.numberOfLines = 2;
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:17];
        self.titleLab = title;
        [bgView addSubview:title];
        
        UILabel * price = [[UILabel alloc] initWithFrame:CGRectMake(152, 70, 200, 32)];
        price.font = [UIFont systemFontOfSize:17];
        price.textColor = [UIColor redColor];
        price.backgroundColor = [UIColor clearColor];
        self.priceLab = price;
        [bgView addSubview:price];
        

        DishClickView * clickView = [[DishClickView alloc] initWithFrame:CGRectMake(392, 51, 110, 30) andNumber:0];
        self.dishView = clickView;
        [bgView addSubview:clickView];
        
        UIButton * btn_mark1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn_mark = btn_mark1;
        btn_mark1.layer.borderWidth = 1;
        btn_mark1.layer.borderColor = [UIColor grayColor].CGColor;
        btn_mark1.layer.cornerRadius = 5;
        btn_mark1.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0];
        btn_mark1.frame = CGRectMake(914, 51, 80, 30);
        [btn_mark1 setTitle:@"备注" forState:UIControlStateNormal];
        [bgView addSubview:btn_mark1];
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDotNumber:(int)aDotNumber
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView * bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 732, 132)];
        bgView.userInteractionEnabled = YES;
        self.backgroundImageView = bgView;
        [self addSubview:bgView];
        
        UIImageView * leftView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 112, 112)];
        leftView.layer.borderWidth = 1;
        leftView.layer.borderColor = [UIColor grayColor].CGColor;
        leftView.layer.cornerRadius = 4;
        self.leftImageView = leftView;
        [bgView addSubview:leftView];
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(152, 30, 240, 40)];
        title.numberOfLines = 2;
        title.backgroundColor = [UIColor clearColor];
        title.font = [UIFont systemFontOfSize:17];
        self.titleLab = title;
        [bgView addSubview:title];
        
        UILabel * price = [[UILabel alloc] initWithFrame:CGRectMake(152, 70, 200, 32)];
        price.font = [UIFont systemFontOfSize:17];
        price.textColor = [UIColor redColor];
        price.backgroundColor = [UIColor clearColor];
        self.priceLab = price;
        [bgView addSubview:price];
        
        
        DishClickView * clickView = [[DishClickView alloc] initWithFrame:CGRectMake(392, 33.5, 170, 65) andNumber:0];
        self.dishView = clickView;
        [bgView addSubview:clickView];
        
        UIButton * btn_mark1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn_mark = btn_mark1;
        btn_mark1.frame = CGRectMake(590, 51, 92, 36);
        [btn_mark1 setBackgroundImage:[UIImage imageNamed:@"备注.png"] forState:UIControlStateNormal];
        [bgView addSubview:btn_mark1];
    }
    return self;
}

-(void)leftClick:(UIButton *)aLeft
{
    [self.delegate leftButtonClickEvent:aLeft];
}

-(void)rightClick:(UIButton *)aRight
{
    [self.delegate rightButtonClickEvent:aRight];
}

-(void)bigClick:(UIButton *)aBig
{
    [self.delegate bigButtonClickEvent:aBig];
}
@end
