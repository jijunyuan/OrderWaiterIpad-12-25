//
//  DishesCustomCell.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-14.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DishesCustomCell : UITableViewCell
{
    IBOutlet UILabel  *nameLab,*priceLab,*copiesLab;
}
@property(nonatomic,retain)UILabel  *nameLab,*priceLab,*copiesLab;
@end
