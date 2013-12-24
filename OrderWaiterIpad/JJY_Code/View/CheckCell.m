//
//  CheckCell.m
//  OrderMenu
//
//  Created by tiankong360 on 13-8-5.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "CheckCell.h"
#import <QuartzCore/QuartzCore.h>
@interface CheckCell()
@end
@implementation CheckCell
@synthesize labName;
@synthesize labPrice;
@synthesize ClickView;
@synthesize bgImageView;
@synthesize btn_mark;
@synthesize L_mark;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDotNumber:(int)aDotNumber
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,1024,65)];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:@"核对展示.png"];
        self.bgImageView = imageView;
        [self addSubview:imageView];
        
        UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, 345, 45)];
        self.labName = lab1;
        lab1.font = [UIFont systemFontOfSize:17];
        lab1.numberOfLines = 2;
        lab1.backgroundColor = [UIColor clearColor];
        [imageView addSubview:lab1];
        UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake(380, 10, 90, 45)];
        lab2.font = [UIFont systemFontOfSize:15];
        lab2.textColor = [UIColor redColor];
        self.labPrice = lab2;
        lab2.backgroundColor = [UIColor clearColor];
        [imageView addSubview:lab2];
        
        UILabel * lab3 = [[UILabel alloc] initWithFrame:CGRectMake(500, 10, 200, 45)];
        self.L_mark = lab3;
        lab3.font = [UIFont systemFontOfSize:17];
        lab3.numberOfLines = 2;
        lab3.backgroundColor = [UIColor clearColor];
        [imageView addSubview:lab3];
        
        DishClickView * clickView = [[DishClickView alloc] initWithFrame:CGRectMake(850, 0, 170, 65) andNumber:aDotNumber];
        self.ClickView = clickView;
        [imageView addSubview:clickView];
        
        UIButton * btn_mark1 = [[UIButton alloc] init];
        self.btn_mark = btn_mark1;
        btn_mark1.frame = CGRectMake(700, 14, 92, 36);
        [btn_mark1 setBackgroundImage:[UIImage imageNamed:@"备注.png"] forState:UIControlStateNormal];
        [imageView addSubview:btn_mark1];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
