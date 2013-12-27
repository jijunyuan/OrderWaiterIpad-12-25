//
//  UINavgationView.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-16.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "UINavgationView.h"

@implementation UINavgationView
@synthesize signUpBtn;
@synthesize mySarchBar;
@synthesize selfBtn;
@synthesize lineView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:251.0/255.0 green:33.0/255.0 blue:47.0/255.0 alpha:1.0];
        
        //加注销分隔线
        UIImageView * signupLine = [[UIImageView alloc] initWithFrame:CGRectMake(55, 0, 2, 44)];
        signupLine.image = [UIImage imageNamed:@"标题线.png"];
        [self addSubview:signupLine];
        
        //加注销按钮
        UIButton * signupBrn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.signUpBtn = signupBrn;
        signupBrn.frame = CGRectMake(7, 2, 40, 40);
        [signupBrn setImage:[UIImage imageNamed:@"注销.png"] forState:UIControlStateNormal];
        [signUpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:signupBrn];
        
        //加searbar
        UISearchBar * searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(306, 2, 300, 40)];
        if ([WebService ISIOS7])
        {
            
        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
            searchBar.searchBarStyle = UISearchBarStyleDefault;
            searchBar.barTintColor = [UIColor clearColor];
        #endif
        }
        else
        {
            for (UIView * view1 in [searchBar subviews])
            {
                if ([view1 isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
                {
                    [view1 removeFromSuperview];
                    break;
                }
            }
        }
        searchBar.placeholder = @"请输入关键字的首字母";
        self.mySarchBar = searchBar;
        [self addSubview:searchBar];
        
        //加标餐左右边线
        UIImageView * eatleftLine = [[UIImageView alloc] initWithFrame:CGRectMake(800, 0, 2, 44)];
        self.lineView = eatleftLine;
        eatleftLine.image = [UIImage imageNamed:@"标题线.png"];
        [self addSubview:eatleftLine];
        
        UIImageView * eatrightLine = [[UIImageView alloc] initWithFrame:CGRectMake(893, 0, 2, 44)];
        eatrightLine.image = [UIImage imageNamed:@"标题线.png"];
        [self addSubview:eatrightLine];
        
       
        UIButtonType buttonType;
        if ([WebService ISIOS7])
        {
            buttonType = UIButtonTypeSystem;
        }
        else
        {
            buttonType = UIButtonTypeCustom;
        }
        
         //添加标餐按钮
        UIButton * eatStandBrn = [UIButton buttonWithType:buttonType];
        self.standBtn = eatStandBrn;
        [eatStandBrn setTitle:@"标餐" forState:UIControlStateNormal];
        [eatStandBrn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [eatStandBrn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        eatStandBrn.frame = CGRectMake(803, 2, 90, 40);
        [self addSubview:eatStandBrn];
        
        //添加自定义按钮
        UIButton * selfBtn1 = [UIButton buttonWithType:buttonType];
        self.selfBtn = selfBtn1;
        [selfBtn1 setTitle:@"自定义菜" forState:UIControlStateNormal];
        [selfBtn1.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        [selfBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        selfBtn1.frame = CGRectMake(896, 2, 130, 40);
        [self addSubview:selfBtn1];
        
    }
    return self;
}


@end
