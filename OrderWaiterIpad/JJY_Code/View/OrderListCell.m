//
//  OrderListCell.m
//  OrderMenu-Waiter
//
//  Created by tiankong360 on 13-9-6.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "OrderListCell.h"

@implementation OrderListCell
@synthesize L_contact;
@synthesize L_time;
@synthesize L_tableNum;
@synthesize L_number;
@synthesize L_people;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel * labNum = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, 165, 30)];
        self.L_number = labNum;
        labNum.backgroundColor = [UIColor clearColor];
        labNum.font = [UIFont systemFontOfSize:17];
        labNum.textColor = [UIColor blackColor];
        [self addSubview:labNum];
        
        UILabel * labTime = [[UILabel alloc] initWithFrame:CGRectMake(180, 7, 180, 30)];
        self.L_time = labTime;
        labTime.backgroundColor = [UIColor clearColor];
        labTime.textColor = [UIColor grayColor];
        labTime.font = [UIFont systemFontOfSize:15];
        [self addSubview:labTime];
        
        UILabel * labContact = [[UILabel alloc] initWithFrame:CGRectMake(360, 7, 180, 30)];
        self.L_contact = labContact;
        labContact.backgroundColor = [UIColor clearColor];
        labContact.textColor = [UIColor grayColor];
        labContact.font = [UIFont systemFontOfSize:15];
        [self addSubview:labContact];
        
        UILabel * labTable = [[UILabel alloc] initWithFrame:CGRectMake(540, 7, 180, 30)];
        self.L_tableNum = labTable;
        labTable.backgroundColor = [UIColor clearColor];
        labTable.textColor = [UIColor grayColor];
        labTable.font = [UIFont systemFontOfSize:15];
        [self addSubview:labTable];
        
        UILabel * labPeople = [[UILabel alloc] initWithFrame:CGRectMake(720, 7, 180, 30)];
        self.L_people = labPeople;
        labPeople.backgroundColor = [UIColor clearColor];
        labPeople.textColor = [UIColor grayColor];
        labPeople.font = [UIFont systemFontOfSize:15];
        [self addSubview:labPeople];   
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
