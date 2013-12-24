//
//  BottomView.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-17.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BottomViewDelegate;
@interface BottomView : UIView

@property (nonatomic,strong) NSMutableArray * arry_class;
@property (nonatomic,assign) id<BottomViewDelegate>delegate;
- (id)initWithFrame:(CGRect)frame andDataArr:(NSMutableArray *)aArr;
@end

@protocol BottomViewDelegate <NSObject>
@optional
-(void)BottomView:(BottomView *)aView andClassId:(NSString *)aClassId;
@end