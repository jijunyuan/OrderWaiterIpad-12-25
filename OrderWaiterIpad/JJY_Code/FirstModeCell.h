//
//  FirstModeCell.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-18.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DCRoundSwitch.h"

@protocol FirstModeCellDelegate;
@interface FirstModeCell : UITableViewCell
//@property (nonatomic,strong) DCRoundSwitch * swichState;
@property (nonatomic,strong) UISwitch * swichState;
@property (nonatomic,strong) UILabel * L_title;
@property (nonatomic,assign) BOOL isYes;
@property (nonatomic,strong) NSString * typeName;
@property (nonatomic,strong) id<FirstModeCellDelegate>delegate;
@property (nonatomic,strong) UILabel * L_status;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andISOn:(BOOL)isOn;
@end

@protocol FirstModeCellDelegate <NSObject>
@optional

-(void)FirstModelCell:(FirstModeCell *)aFirstCell andTypeName:(NSString *)aName andIsOn:(BOOL)aIsOn;
@end