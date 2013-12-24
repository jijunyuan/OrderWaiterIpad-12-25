//
//  BaseViewController.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-11.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize navTitle,backBtn,navImage;
@synthesize bgImageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    navImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 44)];
    navImage.userInteractionEnabled = YES;
    self.bgImageView = navImage;
    navImage.backgroundColor=[UIColor colorWithRed:251.0/255.0 green:33.0/255.0 blue:47.0/255.0 alpha:1.0];
    [self.view addSubview:navImage];
    navTitle=[[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.height/2-100, 0, 200, 44)];
    navTitle.textColor=[UIColor whiteColor];
    navTitle.textAlignment=NSTextAlignmentCenter;
    navTitle.backgroundColor=[UIColor clearColor];
    navTitle.font=[UIFont systemFontOfSize:20.0];
    [self.view addSubview:navTitle];
    backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 44, 44);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"后退.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn_click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    UIImageView *aimage=[[UIImageView alloc] initWithFrame:CGRectMake(44, 0, 2, 44)];
    aimage.image=[UIImage imageNamed:@"标题线.png"];
    [self.view addSubview:aimage];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)backBtn_click
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
