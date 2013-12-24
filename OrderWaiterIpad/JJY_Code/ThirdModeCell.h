//
//  ThirdModeCell.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-18.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChangeDishView.h"

@protocol ThirdModelCellDelegate;

@class MarkButton;
@interface ThirdModeCell : UITableViewCell<ChangeDishViewDelegate>
@property (nonatomic,strong) ChangeDishView * dishView;
@property (nonatomic,strong) MarkButton * markBtn;
@property (nonatomic,assign) double dotNumber;
@property (nonatomic,strong) NSString * proId;
@property (nonatomic,assign) id<ThirdModelCellDelegate>delegate;
@property (nonatomic,strong) NSString * markValue;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDotNumber:(double)aDotNum andMarkvalue:(NSString *)aValue;
@end

@protocol ThirdModelCellDelegate <NSObject>

@optional
-(void)ThirdModelCell:(ThirdModeCell *)thirdCell andleftDotNumber:(double)aDotNumber andProid:(NSString *)aProid;
-(void)ThirdModelCell:(ThirdModeCell *)thirdCell andrightDotNumber:(double)aDotNumber andProid:(NSString *)aProid;
@end