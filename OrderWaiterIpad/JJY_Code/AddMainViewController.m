//
//  AddMainViewController.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-25.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "AddMainViewController.h"

@interface AddMainViewController ()
-(void)loadDished;
@end

@implementation AddMainViewController
@synthesize dataClassArr;
@synthesize dataStausDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//-(void)viewWillAppear:(BOOL)animated
//{
// 
//}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //UI
    [self.navView.standBtn removeFromSuperview];
    [self.navView.lineView removeFromSuperview];
    [self.navView.signUpBtn setImage:[UIImage imageNamed:@"后退.png"] forState:UIControlStateNormal];
    [self.leftBottomView.orderManageBtn removeFromSuperview];
    
    NSLog(@"-peopleNum = %@------tableNum---%@",self.peopleNum,self.tableNum);
    self.leftBottomView.sumbitBtn.frame = CGRectMake(20, 140, 312, 55);
    self.leftBottomView.sumbitBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    
    self.leftBottomView.TF_peopleNum.userInteractionEnabled = NO;
    self.leftBottomView.TF_dishesNum.userInteractionEnabled = NO;
    
    self.isFromAddMain = YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    self.leftBottomView.TF_dishesNum.text = [NSString stringWithFormat:@"%@",self.tableNum];
    self.leftBottomView.TF_peopleNum.text = [NSString stringWithFormat:@"%@",self.peopleNum];
}
-(void)loadDished
{
    
//    self.remberDishStatusDic = self.dataStausDic;
//    NSLog(@"------%@",self.remberDishStatusDic);
//    
//    NSArray * arrKeys = [self.dataProArr allKeys];
//    [arrKeys enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
//        //class
//        NSMutableDictionary * dic1 = [NSMutableDictionary dictionaryWithCapacity:0];
//        [dic1 setValue:[NSString stringWithFormat:@"%@",[[[self.dataProArr valueForKey:obj] objectAtIndex:0] valueForKey:@"ClassID"]] forKey:@"TypeId"];
//        [dic1 setValue:[NSString stringWithFormat:@"%@",obj] forKey:@"TypeName"];
//        [self.clarrleftArr addObject:dic1];
//        
//        //pro
//        NSArray * arrTemp = [self.dataProArr valueForKey:obj];
//        [arrTemp enumerateObjectsUsingBlock:^(NSDictionary * obj1, NSUInteger idx, BOOL *stop) {
//            NSMutableDictionary * dic1 = [NSMutableDictionary dictionaryWithDictionary:obj1];
//            [dic1 setValue:obj forKey:@"TypeName"];
//            [self.remberDishNumber setValue:[obj1 valueForKey:@"Copies"] forKey:[obj1 valueForKey:@"ProId"]];
//            [self.myProArr addObject:dic1];
//        }];
//    }];
//    NSLog(@"self.datAarr = %@",self.myProArr);
//    //insert database
//    [self.myProArr enumerateObjectsUsingBlock:^(NSDictionary * dicTemp1, NSUInteger idx, BOOL *stop) {
//        [DataBase insertProID:[[dicTemp1 valueForKey:@"ProId"] intValue] menuid:[self.orderId intValue] proName:[dicTemp1 valueForKey:@"ProName"] price:[[dicTemp1 valueForKey:@"Price"] doubleValue] image:[dicTemp1 valueForKey:@"ProductImg"] andNumber:[[dicTemp1 valueForKey:@"Copies"] doubleValue] typeID:[[dicTemp1 valueForKey:@"ClassID"] intValue] typeName:[dicTemp1 valueForKey:@"TypeName"]];
//        
//        NSString * strTemp1 = [NSString stringWithFormat:@"%@",[dicTemp1 valueForKey:@"Mark"]];
//        NSLog(@"strTemp1 = %@",strTemp1);
//        if ([strTemp1 isEqualToString:@"无"])
//        {
//           //[self.remberMarkValueDic setValue:@"" forKey:[dicTemp1 valueForKey:@"ProId"]];
//        }
//       else
//       {
//         [self.remberMarkValueDic setValue:[dicTemp1 valueForKey:@"Mark"] forKey:[dicTemp1 valueForKey:@"ProId"]];
//       }
//    }];

    
   // [self reloadRATreeData];
   // [self addDishUI];
}

-(void)signUpClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
