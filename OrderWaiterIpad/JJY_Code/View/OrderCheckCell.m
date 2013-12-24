//
//  OrderCheckCell.m
//  OrderMenu-Waiter
//
//  Created by tiankong360 on 13-9-6.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "OrderCheckCell.h"

@implementation OrderCheckCell
@synthesize L_price;
@synthesize L_name;
@synthesize L_dishes;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel * labName = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 130, 34)];
        self.L_name = labName;
        labName.numberOfLines = 2;
        labName.backgroundColor = [UIColor clearColor];
        labName.font = [UIFont systemFontOfSize:14];
        labName.textColor = [UIColor blackColor];
        [self addSubview:labName];
        
        UILabel * labprice = [[UILabel alloc] initWithFrame:CGRectMake(150, 5, 50, 30)];
        self.L_price = labprice;
        labprice.textColor = [UIColor redColor];
        labprice.backgroundColor = [UIColor clearColor];
        labprice.font = [UIFont systemFontOfSize:17];
        [self addSubview:labprice];
        
        UILabel * labDishes = [[UILabel alloc] initWithFrame:CGRectMake(210, 5, 100, 30)];
        self.L_dishes = labDishes;
        labDishes.backgroundColor = [UIColor clearColor];
        labDishes.font = [UIFont systemFontOfSize:17];
        labDishes.textColor = [UIColor blackColor];
        [self addSubview:labDishes];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
