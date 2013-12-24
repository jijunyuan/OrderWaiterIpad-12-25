//
//  FirstModeCell.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-18.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "FirstModeCell.h"

@interface FirstModeCell()
-(void)SwichOnChange:(UISwitch *)aSwich;
@end

@implementation FirstModeCell
@synthesize swichState;
@synthesize isYes;
@synthesize typeName;
@synthesize L_status;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andISOn:(BOOL)isOn
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.isYes = isOn;
        //添加swich
//        DCRoundSwitch * swich = [[DCRoundSwitch alloc] initWithFrame:CGRectMake(10, 9.5, 70, 25)];
//        [swich addTarget:self action:@selector(SwichOnChange:) forControlEvents:UIControlEventValueChanged];
//        self.swichState = swich;
//        [swich setOn:isOn];
//        swich.onText = @"即起";
//        swich.offText = @"叫起";
//        swich.onTintColor = [UIColor colorWithRed:251.0/255.0 green:33.0/255.0 blue:47.0/255.0 alpha:1.0];
//        [self addSubview:swich];
        
        UISwitch * swich = [[UISwitch alloc] initWithFrame:CGRectMake(10, 7, 90, 30)];
        [swich addTarget:self action:@selector(SwichOnChange:) forControlEvents:UIControlEventValueChanged];
        self.swichState = swich;
        [swich setOn:isOn];
        swich.onImage = [UIImage imageNamed:@"icon.png"];
      //  swich.onText = @"即起";
       // swich.offText = @"叫起";
        swich.onTintColor = [UIColor colorWithRed:251.0/255.0 green:33.0/255.0 blue:47.0/255.0 alpha:1.0];
        [self addSubview:swich];
        
        UILabel * labState = [[UILabel alloc] initWithFrame:CGRectMake(65, 7, 80, 30)];
        labState.textAlignment = NSTextAlignmentCenter;
        labState.font = [UIFont systemFontOfSize:20];
        labState.backgroundColor = [UIColor clearColor];
        if (isOn)
        {
            labState.textColor = [UIColor redColor];
            labState.text = @"即起";
        }
        else
        {
          labState.textColor = [UIColor grayColor];
          labState.text = @"叫起";
        }
        self.L_status = labState;
        [self addSubview:labState];

        
        //添加lab
        UILabel * labTitle = [[UILabel alloc] initWithFrame:CGRectMake(200, 7, 133, 30)];
        labTitle.textAlignment = NSTextAlignmentRight;
        labTitle.font = [UIFont systemFontOfSize:20];
        labTitle.backgroundColor = [UIColor clearColor];
        self.L_title = labTitle;
        [self addSubview:labTitle];  
    }
    return self;
}
-(void)SwichOnChange:(UISwitch *)aSwich
{
    if (aSwich.on)
    {
        self.L_status.textColor = [UIColor redColor];
        self.L_status.text = @"即起";
    }
    else
    {
        self.L_status.textColor = [UIColor grayColor];
        self.L_status.text = @"叫起";
    }
    [self.delegate FirstModelCell:self andTypeName:self.L_title.text andIsOn:aSwich.on];
}
@end
