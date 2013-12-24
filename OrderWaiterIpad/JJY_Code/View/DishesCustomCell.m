//
//  DishesCustomCell.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-14.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "DishesCustomCell.h"
@implementation DishesCustomCell
@synthesize nameLab,priceLab,copiesLab;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
@end
