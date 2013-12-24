//
//  Add_dishesViewController.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-14.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "Add_dishesViewController.h"
#import "CheckOrderViewController.h"
#import "DataBase.h"

@interface Add_dishesViewController ()

@end

@implementation Add_dishesViewController
@synthesize orderID;
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
    // Do any additional setup after loading the view from its nib.
    [self.backBtn setImage:[UIImage imageNamed:@"后退.png"] forState:UIControlStateNormal];
    self.sumbit_order.hidden = YES;
    self.lineImg.hidden = YES;
 
}

-(void)yesClick1:(id)sender
{
    NSArray * tempArr = [DataBase selectAllProduct];
    if (tempArr.count>0)
    {
        CheckOrderViewController * check = [[CheckOrderViewController alloc] initWithNibName:@"CheckOrderViewController" bundle:nil];
        check.isAddDishes = YES;
        check.orderId=self.orderID;
        check.DC_mark = self.DC_mark;
        [self.navigationController pushViewController:check animated:YES];
    }
    else
    {
        [MyAlert ShowAlertMessage:@"您还没有进行点菜！" title:@""];
    }

}
-(IBAction)sumbitClick:(id)sender
{
    [DataBase clearOrderMenu];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
