//
//  MainViewController.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-16.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "MainViewController.h"
#import "UINavgationView.h"
#import "ImageDishesView.h"
#import "UIImageView+WebCache.h"
#import "BottomView.h"
#import "LeftBottomView.h"
#import "RADataObject.h"
#import "OrderSumbitView.h"
#import "OrderListViewController.h"

#define MARK_NOTIFICATION @"mark_notification"
#define CUEE_CLICK @"curr_click"



@interface MainViewController ()<ImageDishViewDelegate,BottomViewDelegate,OrderSumbitViewDelegate>
{
    UINavgationView * nav;
    UIScrollView * scrollView;
    int menuID;
    LeftBottomView * leftBottom;
}
@property (nonatomic,strong) NSMutableArray * myClassArr,* myProArr;
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) OrderSumbitView * orderSumbitView;
@property (nonatomic,strong) NSMutableArray * clarrleftArr;
@property (nonatomic,strong) NSMutableDictionary * remberDishNumber;
@property (nonatomic,strong) NSMutableDictionary * remberMarkValueDic;
@property (nonatomic,strong) NSMutableDictionary * remberDishStatusDic;
-(void)signUpClick;
-(void)standMenu;
-(void)selfReNameMenu;
-(void)addDishUI;
-(void)addClassUI;
-(void)markNotification:(NSNotification *)aNotification;
-(void)sumbitOrder:(UIButton *)aButton;
-(void)orderManage:(UIButton *)aButton;
@end

@implementation MainViewController
@synthesize myClassArr,myProArr;
@synthesize dataArr;
@synthesize orderSumbitView;
@synthesize remberDishNumber;
@synthesize remberDishStatusDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    self.myProArr = [NSMutableArray arrayWithCapacity:0];
    self.myClassArr = [NSMutableArray arrayWithCapacity:0];
    self.clarrleftArr = [NSMutableArray arrayWithCapacity:0];
    self.remberDishNumber = [NSMutableDictionary dictionaryWithCapacity:0];
    self.remberMarkValueDic = [NSMutableDictionary dictionaryWithCapacity:0];
    self.remberDishStatusDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    //点击备注按钮  触发事件
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MARK_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(markNotification:) name:MARK_NOTIFICATION object:nil];
    
    //添加左下view
    leftBottom = [[LeftBottomView alloc] initWithFrame:CGRectMake(0, 558, 360, 210)];
    [leftBottom.sumbitBtn addTarget:self action:@selector(sumbitOrder:) forControlEvents:UIControlEventTouchUpInside];
    [leftBottom.orderManageBtn addTarget:self action:@selector(orderManage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBottom];
    
    //添加左上
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44, 360, 60)];
    imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    imageView.layer.shadowOffset = CGSizeMake(20, -5);
    imageView.image = [UIImage imageNamed:@"ordertitle.png"];
    [self.view addSubview:imageView];
    
    //添加菜单
    OrderSumbitView * orderView = [[OrderSumbitView alloc] initWithFrame:CGRectMake(0, 104, 360, 768-314) andDataArr:nil];
    orderView.delegate = self;
    self.orderSumbitView = orderView;
    [self.view addSubview:orderView];
    
     scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(360, 44, 664, 650)];
    [self.view addSubview:scrollView];
    
    //*********************
    //加导航条
    //获取搜索条  nav.mySarchBar
    //**********************
    nav = [[UINavgationView alloc] initWithFrame:CGRectMake(0, 0, 1024, 44)];
    [nav.signUpBtn addTarget:self action:@selector(signUpClick) forControlEvents:UIControlEventTouchUpInside];
    [nav.selfBtn addTarget:self action:@selector(selfReNameMenu) forControlEvents:UIControlEventTouchUpInside];
    [nav.standBtn addTarget:self action:@selector(standMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
    
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
    {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    #endif
    
    [self getClassData];
}
#pragma mark - 提交订单
-(void)sumbitOrder:(UIButton *)aButton
{
    if (leftBottom.TF_dishesNum.text.length>0 && leftBottom.TF_peopleNum.text.length>0)
    {
        [self sumbitMenu];
    }
    else
    {
        if (leftBottom.TF_peopleNum.text.length>0 && leftBottom.TF_dishesNum.text.length == 0)
        {
            [MyAlert ShowAlertMessage:@"请选择餐桌！" title:@"提示"];
        }
        else if (leftBottom.TF_peopleNum.text.length == 0 && leftBottom.TF_dishesNum.text.length > 0)
        {
             [MyAlert ShowAlertMessage:@"请选择人数！" title:@"提示"];
        }
        else
        {
          [MyAlert ShowAlertMessage:@"请选择人数和餐桌！" title:@"提示"];
        }
    }
}
-(void)sumbitMenu
{
    NSString * proidStr = [DataBase selectAllProId];
    NSString * copiesStr = [DataBase selectNumber];
    //mark
    NSMutableArray * arr_id = [DataBase selectAllArrayProId];
    NSMutableString * str_mutable = [NSMutableString stringWithFormat:@""];
    __block NSString * tempStr;
    [arr_id enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
        tempStr = [NSString stringWithFormat:@"%@",[self.remberMarkValueDic valueForKey:[NSString stringWithFormat:@"%@",obj]]];
        if ([tempStr isEqualToString:@"(null)"])
        {
            [str_mutable appendString:@","];
        }
        else
        {
            [str_mutable appendFormat:@"%@,",tempStr];
        }
    }];
    
    //status format classid,1;classdid,0
    __block NSMutableString * class_status = [NSMutableString stringWithFormat:@""];
    NSArray * tempArrstatus = [self.remberDishStatusDic allKeys];
    NSLog(@"tempArrstatus = %@",tempArrstatus);
    [tempArrstatus enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
    [class_status appendFormat:@"%@,%@;",[DataBase SelectTypeIDByTypeName:obj],[self.remberDishStatusDic valueForKey:obj]];
    }];
    NSLog(@"class_status = %@===str_mutable = %@",class_status,str_mutable);
    NSString * statusSTr = [class_status substringToIndex:class_status.length-1];
    
    ASIHTTPRequest * request = [WebService AddOrderRestId:[[[NSUserDefaults standardUserDefaults] valueForKey:KEY_CURR_RESTID] intValue] tel:@"" tableId:[leftBottom.tableId intValue] mark:[str_mutable substringToIndex:str_mutable.length-1] proid:proidStr copies:copiesStr userID:[[[NSUserDefaults standardUserDefaults] valueForKey:KEY_CURR_USERID] intValue] statue:statusSTr eatNumber:[leftBottom.TF_peopleNum.text intValue]];
    [request startAsynchronous];
    [request setStartedBlock:^{
        [MyActivceView startAnimatedInView:self.view];
    }];
    NSMutableData * reciveData = [NSMutableData dataWithCapacity:0];
    [request setDataReceivedBlock:^(NSData *data) {
        [reciveData appendData:data];
    }];
    
    __block UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"提交成功！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [request setCompletionBlock:^{
        [MyActivceView stopAnimatedInView:self.view];
        NSString * result = [NSString ConverStringfromData:reciveData name:@"SubmitOrder"];
        NSLog(@"result = %@",[[NSString alloc] initWithData:reciveData encoding:4]);
        if ([result isEqualToString:@"1"])
        {
            [alert show];
            [DataBase clearOrderMenu];
            [self.remberDishStatusDic removeAllObjects];
            [self.remberDishNumber removeAllObjects];
            [self.remberMarkValueDic removeAllObjects];
            [self.clarrleftArr removeAllObjects];
            [self reloadRATreeData];
            [self addDishUI];
            leftBottom.TF_peopleNum.text = @"";
            leftBottom.TF_dishesNum.text = @"";
            NSUserDefaults * user1 = [NSUserDefaults standardUserDefaults];
            [user1 removeObjectForKey:CUEE_CLICK];
            [user1 synchronize];
        }
        else
        {
            [MyAlert ShowAlertMessage:@"添加失败！" title:@"提示"];
        }
    }];
    [request setFailedBlock:^{
        [MyActivceView stopAnimatedInView:self.view];
        [MyAlert ShowAlertMessage:@"网络不给力，请重试！" title:@"提示"];
    }];

}
#pragma mark - 订单管理
-(void)orderManage:(UIButton *)aButton
{
    [DataBase clearOrderMenu];
    OrderListViewController * order = [[OrderListViewController alloc] init];
    [self.navigationController pushViewController:order animated:YES];
}
#pragma mark - 点击mark 确定 触发事件
-(void)markNotification:(NSNotification *)aNotification
{
    NSDictionary * dic = [aNotification userInfo];
    NSString * proidStr = [dic valueForKey:@"proid1"];
    NSString * markValue = [dic valueForKey:@"mark1"];
    if (markValue.length>0)
    {
      [self.remberMarkValueDic setValue:markValue forKey:proidStr];
    }
    else
    {
     [self.remberMarkValueDic removeObjectForKey:proidStr];
    }
    [self reloadRATreeData];
}
-(void)addClassUI
{
    BottomView * bottom1 = [[BottomView alloc] initWithFrame:CGRectMake(390, 706.5, 570+40, 49) andDataArr:self.myClassArr];
    bottom1.delegate = self;
    [self.view addSubview:bottom1];
    
    //加左右导航
    UIImageView * imageleft = [[UIImageView alloc] initWithFrame:CGRectMake(370, 696, 35, 70)];
    imageleft.image = [UIImage imageNamed:@"leftArr.png"];
    imageleft.clipsToBounds = YES;
    [self.view addSubview:imageleft];
    
    UIImageView * imageright = [[UIImageView alloc] initWithFrame:CGRectMake(983, 696, 35, 70)];
    imageright.image = [UIImage imageNamed:@"rightArr.png"]; //rightArr.png
    imageright.clipsToBounds = YES;
    [self.view addSubview:imageright];
}
-(void)addDishUI
{
    for (UIView * subview in [scrollView subviews])
    {
        [subview removeFromSuperview];
    }
    
    for (int i = 0; i<self.myProArr.count; i++)
    {
        NSDictionary * dishDictory = [self.myProArr objectAtIndex:i];
        
        float pointX = 20+i%4*(136+15+11.5);
        float pointY = 20+i/4*(186+25);
        
        NSString * proid = [NSString stringWithFormat:@"%@",[dishDictory valueForKey:@"ProID"]];
        NSArray * allkeys = [self.remberDishNumber allKeys];
        __block BOOL isHaveKey = NO;
        [allkeys enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
            if ([proid isEqualToString:obj])
            {
                isHaveKey = YES;
                *stop = YES;
            }
        }];
        
        double dotNumber2 = 0.0;
        if (isHaveKey)
        {
            dotNumber2 = [[self.remberDishNumber valueForKey:proid] doubleValue];
        }
        
        ImageDishesView * imageDishView1 = [[ImageDishesView alloc] initWithFrame:CGRectMake(pointX, pointY, 136, 205) andDotNumber:dotNumber2];
        imageDishView1.delegate = self;
        
        //get image
        NSString * currStr = [NSString stringWithFormat:@"%@",[dishDictory valueForKey:@"ProName"]];
        if (currStr.length>0)
        {
            NSString * pathURL = ALL_URL;
            NSURL * url = [NSURL URLWithString:[pathURL stringByAppendingFormat:@"%@",[dishDictory valueForKey:@"ProductImg"]]];
            [imageDishView1.imageDishView setImageWithURL:url placeholderImage:[UIImage imageNamed:ALL_NO_IMAGE]];
        }
        else
        {
          [imageDishView1.imageDishView setImage:[UIImage imageNamed:ALL_NO_IMAGE]];
        }
        NSString * priceStr = [NSString stringWithFormat:@"￥%@元/份",[dishDictory valueForKey:@"prices"]];
        imageDishView1.L_dishName.text = [NSString stringWithFormat:@"%@\n%@",[dishDictory valueForKey:@"ProName"],priceStr];
        imageDishView1.productId = [NSString stringWithFormat:@"%@",[dishDictory valueForKey:@"ProID"]];
        imageDishView1.dishDictory = dishDictory;
        [scrollView addSubview:imageDishView1];
    }
    float height = 0.0;
    if (self.myProArr.count%4==0)
    {
      height = (self.myProArr.count/4)*(186+20)+40;
    }
    else
    {
     height = (self.myProArr.count/4+1)*(186+20)+40;
    }
    if (height<625)
    {
        height = 625;
    }
    scrollView.contentSize = CGSizeMake(664, height);
    
}
#pragma mark - get data
-(void)getClassData
{
    //self.resultID
    ASIHTTPRequest * request = [WebService classInterfaceConfig:[[[NSUserDefaults standardUserDefaults] valueForKey:KEY_CURR_RESTID] intValue]];
    [request startAsynchronous];
    NSMutableData * reciveData = [NSMutableData dataWithCapacity:0];
    [request setStartedBlock:^{
        [MyActivceView startAnimatedInView:self.view];
    }];
    [request setDataReceivedBlock:^(NSData *data) {
        [reciveData appendData:data];
    }];
    [request setCompletionBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.myClassArr = (NSMutableArray *)[NSString ConverfromData:reciveData name:CLASS_NAME];
            [self addClassUI];
            NSLog(@"class = %@",self.myClassArr);
            [self getProductData:[[self.myClassArr objectAtIndex:0] valueForKey:@"classID"]];
            
        });
    }];
    [request setFailedBlock:^{
        [MyActivceView stopAnimatedInView:self.view];
        [MyAlert ShowAlertMessage:@"网速不给力！" title:@"请求超时"];
    }];
}
-(void)getProductData:(NSString *)aClassid
{
    for (UIView * subview in [scrollView subviews])
    {
        [subview removeFromSuperview];
    }
    
    __weak  ASIHTTPRequest * request = [WebService ProductListConfig:aClassid];
    [request startAsynchronous];
    NSMutableData * reciveData1 = [NSMutableData dataWithCapacity:0];
    [request setDataReceivedBlock:^(NSData *data) {
        [reciveData1 appendData:data];
    }];
    [request setCompletionBlock:^{
        [MyActivceView stopAnimatedInView:self.view];
        [self.myProArr removeAllObjects];
        self.myProArr = nil;
        
        self.myProArr = [NSMutableArray arrayWithArray:[NSString ConverfromData:reciveData1 name:PRODUCT_NAME]];
        NSLog(@"self.myproarr = %@",self.myProArr);
        if (self.myProArr>0)
        {
            [self addDishUI];
        }
    }];
    [request setFailedBlock:^{
        [request cancel];
        [MyActivceView stopAnimatedInView:self.view];
        [MyAlert ShowAlertMessage:@"网速不给力！" title:@"请求超时"];
    }];
}

#pragma mark -  left  and right button click
-(void)ChangeDishViewAtImageDishesView:(ImageDishesView *)aChangeDishView andLeftDotNumber:(double)aDotNumber andPreDotNumber:(double)aPreDotNumber
{
    NSLog(@"=====%g",aDotNumber);
    if (aDotNumber>0)
    {
        [DataBase UpdateDotNumber:[aChangeDishView.productId intValue] currDotNumber:aDotNumber];
    }
    else
    {
        [DataBase deleteProID:[aChangeDishView.productId intValue]];
    }
    [self.remberDishNumber setValue:[NSString stringWithFormat:@"%g",aDotNumber] forKey:[NSString stringWithFormat:@"%@",aChangeDishView.productId]];
    [self reloadReleaseRATreeData];
}
-(void)ChangeDishViewAtImageDishesView:(ImageDishesView *)aChangeDishView andRightDotNumber:(double)aDotNumber andPreDotNumber:(double)aPreDotNumber
{
    NSLog(@"%g",aDotNumber);
    if (aPreDotNumber == 0)
    {
        NSDictionary * dicTemp = aChangeDishView.dishDictory;
        double disCount = 0.0;
        if ([NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"DiscountPrice"]].length>0)
        {
            disCount = [[dicTemp valueForKey:@"DiscountPrice"] doubleValue];
        }
        else
        {
            disCount = [[dicTemp valueForKey:@"prices"] doubleValue];
        }
        
        __block BOOL isHaveClass = NO;
        __block int index = 0;
        [self.clarrleftArr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
            if ([[obj valueForKey:@"TypeId"] isEqualToString:[dicTemp valueForKey:@"TypeId"]])
            {
                isHaveClass = YES;
                index = idx;
                *stop = YES;
            }
            else
            {
                isHaveClass = NO;
            }
        }];
        if (!isHaveClass)
        {
            NSMutableDictionary * dic1 = [NSMutableDictionary dictionaryWithCapacity:0];
            [dic1 setValue:[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"TypeId"]] forKey:@"TypeId"];
            [dic1 setValue:[NSString stringWithFormat:@"%@",[dicTemp valueForKey:@"TypeName"]] forKey:@"TypeName"];
            [self.clarrleftArr addObject:dic1];
        }
        
        [DataBase insertProID:[[dicTemp valueForKey:@"ProID"] intValue] menuid:menuID proName:[dicTemp valueForKey:@"ProName"] price:disCount image:[dicTemp valueForKey:@"ProductImg"] andNumber:1.0 typeID:[[dicTemp valueForKey:@"TypeId"] intValue] typeName:[dicTemp valueForKey:@"TypeName"]];
        }
    else
    {
        [DataBase UpdateDotNumber:[aChangeDishView.productId intValue] currDotNumber:aDotNumber];
    }
    [self.remberDishNumber setValue:[NSString stringWithFormat:@"%g",aDotNumber] forKey:[NSString stringWithFormat:@"%@",aChangeDishView.productId]];
    [self reloadRATreeData];
}

-(void)reloadReleaseRATreeData
{
    NSMutableArray * fristArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<self.clarrleftArr.count; i++)
    {
        NSDictionary * dicTemp1 = [self.clarrleftArr objectAtIndex:i];
        NSMutableArray * arrTemp1 = (NSMutableArray *)[DataBase SelectProductByTypeID:[NSString stringWithFormat:@"%@",[dicTemp1 valueForKey:@"TypeId"]]];

        NSMutableArray * classGroubArr = [NSMutableArray arrayWithCapacity:0];
        for (int j = 0; j<arrTemp1.count; j++)
        {
             NSDictionary * dicPro = [arrTemp1 objectAtIndex:j];
            NSLog(@"dicpro = %@",dicPro);
             NSString * str1 = [DataBase ConverStringFromDictionary:dicPro];
            
            NSString * proidStr1 = [NSString stringWithFormat:@"%@",[dicPro valueForKey:@"ProID"]];
            NSArray * allMarkKeys = [self.remberMarkValueDic allKeys];
            __block BOOL isHaveMark = NO;
            [allMarkKeys enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
                if ([obj isEqualToString:proidStr1])
                {
                    isHaveMark = YES;
                    *stop = YES;
                }
            }];
            NSString * markValue1 = @"";
            if (isHaveMark)
            {
                markValue1 = [self.remberMarkValueDic valueForKey:proidStr1];
            }
            RADataObject * thirdMode = [RADataObject dataObjectWithName:[str1 stringByAppendingFormat:@",%@",markValue1] children:nil];
            
            RADataObject * secondMode = [RADataObject dataObjectWithName:str1 children:[NSArray arrayWithObjects:thirdMode, nil]];
            [classGroubArr addObject:secondMode];
        }
        NSArray * stausKeys = [self.remberDishStatusDic allKeys];
        __block BOOL isHaveCurrStaus = NO;
        [stausKeys enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
            if ([obj isEqualToString:[dicTemp1 valueForKey:@"TypeName"]])
            {
                isHaveCurrStaus = YES;
                *stop = YES;
            }
        }];
        NSString * strStsus;
        if (isHaveCurrStaus)
        {
            strStsus = [self.remberDishStatusDic valueForKey:[dicTemp1 valueForKey:@"TypeName"]];
        }
        else
        {
            strStsus = @"1";
            [self.remberDishStatusDic setValue:strStsus forKey:[dicTemp1 valueForKey:@"TypeName"]];
        }
        
        
        RADataObject * firstMode = [RADataObject dataObjectWithName:[[dicTemp1 valueForKey:@"TypeName"] stringByAppendingFormat:@",%@",strStsus] children:classGroubArr];
        [fristArr addObject:firstMode];
        
        [arrTemp1 removeAllObjects];
    }
    __block int indexD1 = 0;
    __block BOOL isHaveChildRen = YES;
    __block NSString * className;
    [fristArr enumerateObjectsUsingBlock:^(RADataObject * obj, NSUInteger idx, BOOL *stop) {
        if (obj.children.count == 0)
        {
            isHaveChildRen = NO;
            indexD1 = idx;
            className = obj.name;
            *stop = YES;
        }
    }];
    if (!isHaveChildRen)
    {
        [fristArr removeObjectAtIndex:indexD1];
        __block BOOL isHaveType = NO;
        __block int index2;
        [self.clarrleftArr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
            if ([[obj valueForKey:@"TypeName"] isEqualToString:className])
            {
                isHaveType = YES;
                index2 = idx;
                *stop = YES;
            }
        }];
        if (isHaveType)
        {
            [self.clarrleftArr removeObjectAtIndex:index2];
        }
    }
    self.orderSumbitView.dataArr = fristArr;
    [self.orderSumbitView.raTreeView reloadData];
    
    //计算总价
    NSMutableArray * dotArr = [DataBase selectAllProduct];
    __block double numberDot = 0;
    __block double sumMon = 0.0;
    [dotArr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
        numberDot += [[obj valueForKey:@"number"] doubleValue];
        sumMon += [[obj valueForKey:@"number"] doubleValue]*[[obj valueForKey:@"prices"] doubleValue];
    }];
    leftBottom.L_dishNum.text = [NSString stringWithFormat:@"%g",numberDot];
    leftBottom.L_sum.text = [NSString stringWithFormat:@"￥%g",sumMon];
    
    [dotArr removeAllObjects];
    dotArr = nil;
    
    [fristArr removeAllObjects];
    fristArr = nil;
}
-(void)reloadRATreeData
{
    NSMutableArray * fristArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<self.clarrleftArr.count; i++)
    {
        NSMutableDictionary * dicTemp1 = [self.clarrleftArr objectAtIndex:i];
        NSMutableArray  * arrTemp1 = (NSMutableArray *)[DataBase SelectProductByTypeID:[NSString stringWithFormat:@"%@",[dicTemp1 valueForKey:@"TypeId"]]];
        
        NSMutableArray * classGroubArr = [NSMutableArray arrayWithCapacity:0];
        for (int j = 0; j<arrTemp1.count; j++)
        {
            NSMutableDictionary * dicPro = (NSMutableDictionary *)[arrTemp1 objectAtIndex:j];

            NSString * proidStr1 = [NSString stringWithFormat:@"%@",[dicPro valueForKey:@"ProID"]];
            NSArray * allMarkKeys = [self.remberMarkValueDic allKeys];
            __block BOOL isHaveMark = NO;
            [allMarkKeys enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
                if ([obj isEqualToString:proidStr1])
                {
                    isHaveMark = YES;
                    *stop = YES;
                }
            }];
            NSString * markValue1 = @"";
            if (isHaveMark)
            {
                markValue1 = [self.remberMarkValueDic valueForKey:proidStr1];
            }
             NSString * str1 = [DataBase ConverStringFromDictionary:dicPro];
            RADataObject * thirdMode = [RADataObject dataObjectWithName:[str1 stringByAppendingFormat:@",%@",markValue1] children:nil];
            
            RADataObject * secondMode = [RADataObject dataObjectWithName:str1 children:[NSArray arrayWithObjects:thirdMode, nil]];
            [classGroubArr addObject:secondMode];
        }
        
        [arrTemp1 removeAllObjects];
        
        NSArray * stausKeys = [self.remberDishStatusDic allKeys];
        __block BOOL isHaveCurrStaus = NO;
        [stausKeys enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
            if ([obj isEqualToString:[dicTemp1 valueForKey:@"TypeName"]])
            {
                isHaveCurrStaus = YES;
                *stop = YES;
            }
        }];
        NSString * strStsus;
        if (isHaveCurrStaus)
        {
            strStsus = [self.remberDishStatusDic valueForKey:[dicTemp1 valueForKey:@"TypeName"]];
        }
        else
        {
            strStsus = @"1";
        }
        [self.remberDishStatusDic setValue:strStsus forKey:[dicTemp1 valueForKey:@"TypeName"]];
        RADataObject * firstMode = [RADataObject dataObjectWithName:[[dicTemp1 valueForKey:@"TypeName"] stringByAppendingFormat:@",%@",strStsus] children:classGroubArr];
        [fristArr addObject:firstMode];
    }
    self.orderSumbitView.dataArr = fristArr;
    [self.orderSumbitView.raTreeView reloadData];
    
    [fristArr removeAllObjects];
    fristArr = nil;
    
    //计算总价
    NSMutableArray * dotArr = [DataBase selectAllProduct];
    __block double numberDot = 0;
    __block double sumMon = 0.0;
    [dotArr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
        numberDot += [[obj valueForKey:@"number"] doubleValue];
        sumMon += [[obj valueForKey:@"number"] doubleValue]*[[obj valueForKey:@"prices"] doubleValue];
    }];
    leftBottom.L_dishNum.text = [NSString stringWithFormat:@"%g",numberDot];
    leftBottom.L_sum.text = [NSString stringWithFormat:@"￥%g",sumMon];
    
    [dotArr removeAllObjects];
    dotArr = nil;
}

#pragma mark - 点击分类按钮触发事件
-(void)BottomView:(BottomView *)aView andClassId:(NSString *)aClassId
{
    if (aClassId.length>0)
    {
        menuID = [aClassId intValue];
        [self getProductData:aClassId];
    }
}

#pragma mark - 注销按钮
-(void)signUpClick
{
    [DataBase clearOrderMenu];
    [self.remberDishStatusDic removeAllObjects];
    [self.remberDishNumber removeAllObjects];
    [self.remberMarkValueDic removeAllObjects];
    [self.clarrleftArr removeAllObjects];
    [self reloadRATreeData];
    [self addDishUI];
    leftBottom.TF_peopleNum.text = @"";
    leftBottom.TF_dishesNum.text = @"";
    NSUserDefaults * user1 = [NSUserDefaults standardUserDefaults];
    [user1 removeObjectForKey:CUEE_CLICK];
    [user1 synchronize];

    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 标餐
-(void)standMenu
{

}
#pragma mark - 自定义菜
-(void)selfReNameMenu
{
 
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
#endif

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [nav.mySarchBar resignFirstResponder];
}

#pragma mark - OrderSumbitView delegate
-(void)OrderSumbitView:(OrderSumbitView *)aOrderView andLeftDotNumber:(double)aDotNumber andProid:(NSString *)aProId andThirdCell:(ThirdModeCell *)aThirdCell
{
    if (aDotNumber>0)
    {
        [DataBase UpdateDotNumber:[aProId intValue] currDotNumber:aDotNumber];
    }
    else
    {
        [DataBase deleteProID:[aProId intValue]];
    }
    [self.remberDishNumber setValue:[NSString stringWithFormat:@"%g",aDotNumber] forKey:[NSString stringWithFormat:@"%@",aProId]];
    [self reloadReleaseRATreeData];
    
    [self addDishUI];
}
-(void)OrderSumbitView:(OrderSumbitView *)aOrderView andRightDotNumber:(double)aDotNumber andProid:(NSString *)aProId andThirdCell:(ThirdModeCell *)aThirdCell
{
      NSLog(@"rightdot = %g,id = %@",aDotNumber,aProId);
    [DataBase UpdateDotNumber:[aProId intValue] currDotNumber:aDotNumber];
    [self.remberDishNumber setValue:[NSString stringWithFormat:@"%g",aDotNumber] forKey:[NSString stringWithFormat:@"%@",aProId]];
    [self reloadRATreeData];
    [self addDishUI];
}
-(void)OrderSumbitView:(OrderSumbitView *)aOrderView treeView:(RATreeView *)treeView shouldExpandItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    if (treeNodeInfo.treeDepthLevel == 1)
    {
       // [self.orderSumbitView.raTreeView reloadData];
   //   RADataObject * object = (RADataObject *)treeView.itemForSelectedRow;

    }
}
#pragma mark - 叫起 即起
-(void)OrderSumbitView:(OrderSumbitView *)aOrderView andFirstCell:(FirstModeCell *)aFirstCell andTypeName:(NSString *)aName andIson:(BOOL)aIsYes
{
    NSLog(@"++++++aisuyes = %d",aIsYes);
    NSString * str1;
    if (aIsYes)
    {
        str1 = @"1";
    }
    else
    {
        str1 = @"0";
    }
    [self.remberDishStatusDic setValue:str1 forKey:aName];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
