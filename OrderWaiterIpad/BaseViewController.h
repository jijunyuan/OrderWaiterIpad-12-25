//
//  BaseViewController.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-11.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "MyActivceView.h"
#import "MyAlert.h"
#import "TKHttpRequest.h"
#import "NSString+JsonString.h"
@interface BaseViewController : UIViewController
{
    UILabel     *navTitle;
    UIButton    *backBtn;
    UIImageView *navImage;
}
@property(nonatomic,retain)UILabel     *navTitle;
@property(nonatomic,retain)UIButton    *backBtn;
@property(nonatomic,retain)UIImageView *navImage;
@property (nonatomic,strong) UIImageView * bgImageView;
@end
