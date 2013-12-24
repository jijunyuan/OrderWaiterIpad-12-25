//
//  LeftBottomView.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-17.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "LeftBottomView.h"
#import "PersonList.h"
#import "FPPopoverController.h"

@interface LeftBottomView()<UITextFieldDelegate>
{
    FPPopoverController * popover;
}
@end

@implementation LeftBottomView
@synthesize TF_dishesNum;
@synthesize TF_peopleNum;
@synthesize L_dishNum,L_sum;
@synthesize sumbitBtn,orderManageBtn;
@synthesize tableId;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popDismiss_table:) name:@"popoverVC_table" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popDismiss_person:) name:@"popoverVC_person" object:nil];
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowOffset = CGSizeMake(20, -20);
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        
        //餐桌号
        UILabel * dishLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 40)];
        dishLab.backgroundColor = [UIColor clearColor];
        dishLab.text = @"餐桌号:";
        [self addSubview:dishLab];
        
        UITextField * dishNumber = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 90, 40)];
        dishNumber.textAlignment = NSTextAlignmentCenter;
        dishNumber.delegate = self;
        dishNumber.tag = 1000;
        dishNumber.textColor = [UIColor redColor];
        self.TF_dishesNum = dishNumber;
        dishNumber.backgroundColor = [UIColor colorWithRed:202.0/255.0 green:202.0/255.0 blue:202.0/255.0 alpha:1.0];
        dishNumber.layer.cornerRadius = 3;
        [self addSubview:dishNumber];
        
        //人数
        UILabel * peopleLab = [[UILabel alloc] initWithFrame:CGRectMake(190, 10, 50, 40)];
        peopleLab.backgroundColor = [UIColor clearColor];
        peopleLab.text = @"人数:";
        [self addSubview:peopleLab];
        
        UITextField * peoNumber = [[UITextField alloc] initWithFrame:CGRectMake(240, 10, 90, 40)];
        peoNumber.textAlignment = NSTextAlignmentCenter;
        peoNumber.delegate = self;
        peoNumber.tag = 1001;
        peoNumber.textColor = [UIColor redColor];
        self.TF_peopleNum = peoNumber;
        peoNumber.backgroundColor = [UIColor colorWithRed:202.0/255.0 green:202.0/255.0 blue:202.0/255.0 alpha:1.0];
        peoNumber.layer.cornerRadius = 3;
        [self addSubview:peoNumber];
        
        //统计
        UILabel * lab1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 65, 20, 40)];
        lab1.backgroundColor = [UIColor clearColor];
        lab1.text = @"共";
        [self addSubview:lab1];
        
        UILabel * lab2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 65, 40, 40)];
        self.L_dishNum = lab2;
        lab2.textAlignment = NSTextAlignmentCenter;
        lab2.adjustsFontSizeToFitWidth = YES;
        lab2.backgroundColor = [UIColor clearColor];
        lab2.textColor = [UIColor redColor];
        lab2.text = @"0";
        [self addSubview:lab2];
        
        UILabel * lab3 = [[UILabel alloc] initWithFrame:CGRectMake(110, 65, 40, 40)];
        lab3.textAlignment = NSTextAlignmentRight;
        lab3.backgroundColor = [UIColor clearColor];
        lab3.text = @"份菜";
        [self addSubview:lab3];
        
        UILabel * lab11 = [[UILabel alloc] initWithFrame:CGRectMake(200, 65, 40, 40)];
        lab11.textAlignment = NSTextAlignmentRight;
        lab11.backgroundColor = [UIColor clearColor];
        lab11.text = @"合计";
        [self addSubview:lab11];
        
        UILabel * lab22 = [[UILabel alloc] initWithFrame:CGRectMake(240, 65, 60, 40)];
        self.L_sum = lab22;
        lab22.textAlignment = NSTextAlignmentCenter;
        lab22.adjustsFontSizeToFitWidth = YES;
        lab22.backgroundColor = [UIColor clearColor];
        lab22.textColor = [UIColor redColor];
        lab22.text = @"￥0";
        [self addSubview:lab22];
        
        //提交订单button
        UIButton * buttonSumbit = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonSumbit.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        self.sumbitBtn = buttonSumbit;
        buttonSumbit.showsTouchWhenHighlighted = YES;
        buttonSumbit.layer.cornerRadius = 4;
        [buttonSumbit setTitle:@"提交订单" forState:UIControlStateNormal];
        [buttonSumbit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        buttonSumbit.backgroundColor = [UIColor redColor];
        buttonSumbit.frame = CGRectMake(20, 110, 312, 35);
        [self addSubview:buttonSumbit];

        //订单管理
        UIButton * orderSumbit = [UIButton buttonWithType:UIButtonTypeCustom];
        [orderSumbit.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        self.orderManageBtn = orderSumbit;
        orderSumbit.showsTouchWhenHighlighted = YES;
        orderSumbit.layer.cornerRadius = 4;
        [orderSumbit setTitle:@"订单管理" forState:UIControlStateNormal];
        [orderSumbit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        orderSumbit.backgroundColor = [UIColor redColor];
        orderSumbit.frame = CGRectMake(20, 160, 312, 35);
        [self addSubview:orderSumbit];

    }
    return self;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.tag == 1001)
    {
        PersonList *controller = [[PersonList alloc] initWithStyle:UITableViewStylePlain];
        controller.aryID=0000;
        popover = [[FPPopoverController alloc] initWithViewController:controller];
        popover.tint = FPPopoverDefaultTint;
        popover.contentSize = CGSizeMake(150, 300);
        popover.arrowDirection = FPPopoverArrowDirectionDown;
        [popover presentPopoverFromView:textField];
        
    }
    else
    {
        PersonList *controller = [[PersonList alloc] initWithStyle:UITableViewStylePlain];
        controller.aryID=1111;
        popover = [[FPPopoverController alloc] initWithViewController:controller];
        popover.tint = FPPopoverDefaultTint;
        popover.contentSize = CGSizeMake(150, 300);
        popover.arrowDirection = FPPopoverArrowDirectionDown;
        [popover presentPopoverFromView:textField];
    }

}
- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
}
- (void)popDismiss_table:(NSNotification *)aNotification
{
    NSDictionary * dic = aNotification.userInfo;
    self.TF_dishesNum.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"tableId"]];
    self.tableId =[NSString stringWithFormat:@"%@",[dic objectForKey:@"table_Id"]];
     NSLog(@"self.tableId**%@******",self.tableId);
    [popover dismissPopoverAnimated:YES];
    
}
- (void)popDismiss_person:(NSNotification *)aNotification
{
    NSDictionary * dic = aNotification.userInfo;
    self.TF_peopleNum.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"personId"]];
    [popover dismissPopoverAnimated:YES];
    
}


@end
