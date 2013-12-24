//
//  DishesClassCell.m
//  OrderMenu
//
//  Created by tiankong360 on 13-7-10.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "DishesClassCell.h"
@implementation DishesClassCell
@synthesize backgroundImageView;
@synthesize textContentLab;
@synthesize isClick;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.isClick = NO;
        
        UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 290, 44)];
        imageview.image = [UIImage imageNamed:@"选项.png"];
        self.backgroundImageView = imageview;
        [self addSubview:imageview];
        
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 220, 44)];
        lab.backgroundColor = [UIColor clearColor];
        lab.font = [UIFont systemFontOfSize:17];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.numberOfLines = 2;
        self.textContentLab = lab;
        [imageview addSubview:lab];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
