//
//  SecondModeCell.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-18.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "SecondModeCell.h"

@implementation SecondModeCell
@synthesize L_name,L_price,L_number;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //添加lab
        UILabel * labName = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 170, 30)];
        labName.backgroundColor = [UIColor clearColor];
        self.L_name = labName;
        [self addSubview:labName];
        
        //添加单价
        UILabel * labprice = [[UILabel alloc] initWithFrame:CGRectMake(185, 7, 65, 30)];
        labprice.backgroundColor = [UIColor clearColor];
        labprice.textColor = [UIColor redColor];
        self.L_price = labprice;
        [self addSubview:labprice];
        
        //添加份数
        UILabel * labnumber = [[UILabel alloc] initWithFrame:CGRectMake(250, 7, 80, 30)];
        labnumber.textColor = [UIColor redColor];
        labnumber.backgroundColor = [UIColor clearColor];
        labnumber.textAlignment = NSTextAlignmentRight;
        self.L_number = labnumber;
        [self addSubview:labnumber];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
