//
//  MainViewController.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-16.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "MainViewController.h"
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

@property (nonatomic,strong) NSMutableArray * dataArr;

-(void)standMenu;
-(void)selfReNameMenu;
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
@synthesize navView;
@synthesize leftBottomView;
@synthesize isFromAddMain;
@synthesize orderId;
@synthesize tableId;
@synthesize peopleNum;
@synthesize tableNum;
@synthesize dataProArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    //[DataBase1 clearOrderMenu];
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
    //[super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
   // [DataBase1 ShareDataBase];
    
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
    self.leftBottomView = leftBottom;
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
    self.navView = nav;
    [nav.selfBtn addTarget:self action:@selector(selfReNameMenu) forControlEvents:UIControlEventTouchUpInside];
    [nav.standBtn addTarget:self action:@selector(standMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
    nav.mySarchBar.delegate=self;
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
    if (proidStr.length>0)
    {
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
        [tempArrstatus enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
            [class_status appendFormat:@"%@,%@;",[DataBase SelectTypeIDByTypeName:obj],[self.remberDishStatusDic valueForKey:obj]];
        }];
        
        NSString * statusSTr = [class_status substringToIndex:class_status.length-1];
        
       
       // NSLog(@"status = %@===mark = %@,restid = %@,proidStr=%@,copiesStr=%@ tableid = %@,userid = %@,orderid = %@",statusSTr,[str_mutable substringToIndex:str_mutable.length-1],[[NSUserDefaults standardUserDefaults] valueForKey:KEY_CURR_RESTID],proidStr,copiesStr,self.leftBottomView.tableId,[[NSUserDefaults standardUserDefaults] valueForKey:KEY_CURR_USERID],self.orderId);
       
        ASIHTTPRequest * request;
        if (!self.isFromAddMain)
        {
             NSString * restid = [[NSUserDefaults standardUserDefaults] valueForKey:KEY_CURR_RESTID];
            NSString * mark1 = [str_mutable substringToIndex:str_mutable.length-1];
            NSString * userId1 = [[NSUserDefaults standardUserDefaults] valueForKey:KEY_CURR_USERID];
            NSString * peopleNum1 = leftBottom.TF_peopleNum.text;
            NSString * tableids = leftBottom.tableId;
            
           
          request = [WebService AddOrderRestId:[restid intValue] tel:@"" tableId:tableids mark:mark1 proid:proidStr copies:copiesStr userID:[userId1 intValue] statue:statusSTr eatNumber:[peopleNum1 intValue]];
        }
        else
        {
          //  NSString * tableids = leftBottom.tableId;
             NSLog(@"=proidStr = %@=tableid = %@===OrderID=%@==mark = %@=copies = %@=",proidStr,self.tableId,self.orderId,[str_mutable substringToIndex:str_mutable.length-1],copiesStr);
            request = [WebService AddishesRestID:[[[NSUserDefaults standardUserDefaults] valueForKey:KEY_CURR_RESTID] intValue] OrderID:[self.orderId intValue] proid:proidStr mark:[str_mutable substringToIndex:str_mutable.length-1] copies:copiesStr andTableId:[self.tableId intValue]];
        }
        [request startAsynchronous];
        [request setStartedBlock:^{
            [MyActivceView startAnimatedInView:self.view];
        }];
        NSMutableData * reciveData = [NSMutableData dataWithCapacity:0];
        [request setDataReceivedBlock:^(NSData *data) {
            [reciveData appendData:data];
        }];
        
       
        
        [request setCompletionBlock:^{
            [MyActivceView stopAnimatedInView:self.view];
            NSString * result;
            if (self.isFromAddMain)
            {
                result = [NSString ConverStringfromData:reciveData name:@"addOrderinfo"];
            }
            else
            {
              result = [NSString ConverStringfromData:reciveData name:@"SubmitOrder"];
            }
            NSLog(@"result = %@",[[NSString alloc] initWithData:reciveData encoding:4]);
            if ([result isEqualToString:@"1"])
            {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"提交成功！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
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
                
                if (self.isFromAddMain)
                {
                    for (UIViewController * controller1 in self.navigationController.viewControllers)
                    {
                        if ([controller1 isKindOfClass:[OrderListViewController class]])
                        {
                            OrderListViewController * orderList = (OrderListViewController *)controller1;
                            [self.navigationController popToViewController:orderList animated:YES];
                        }
                    }
                }
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
   else
   {
       [MyAlert ShowAlertMessage:@"亲，您还没有点菜哦！" title:@"提示"];
   }
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
//        if (self.isFromAddMain)
//        {
//            [DataBase1 UpdateDotNumber:[aChangeDishView.productId intValue] currDotNumber:aDotNumber];
//        }
    }
    else
    {
        [DataBase deleteProID:[aChangeDishView.productId intValue]];
//        if (self.isFromAddMain)
//        {
//             [DataBase1 deleteProID:[aChangeDishView.productId intValue]];
//        }
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
//        if (self.isFromAddMain)
//        {
//          [DataBase1 insertProID:[[dicTemp valueForKey:@"ProID"] intValue] menuid:menuID proName:[dicTemp valueForKey:@"ProName"] price:disCount image:[dicTemp valueForKey:@"ProductImg"] andNumber:1.0 typeID:[[dicTemp valueForKey:@"TypeId"] intValue] typeName:[dicTemp valueForKey:@"TypeName"]];
//        }
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
    NSLog(@"first++++++++ = %@",fristArr);
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
    StandardViewController *standVC=[[StandardViewController alloc] init];
    [self.navigationController pushViewController:standVC animated:YES];
}
#pragma mark - 自定义菜
-(void)selfReNameMenu
{
    [nav.mySarchBar resignFirstResponder];
    //UI
    backImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    backImage.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.6];
    backImage.alpha=0;
    backImage.userInteractionEnabled=YES;
    [self.view addSubview:backImage];
    customView=[[UIView alloc] initWithFrame:CGRectMake(1024/2-600/2, 768, 600, 400)];
    customView.backgroundColor=[UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1.0];
    customView.layer.borderColor=[UIColor grayColor].CGColor;
    customView.layer.borderWidth=0.5;
    customView.layer.cornerRadius =5.0;
    [self.view addSubview:customView];
    [UIView animateWithDuration:.3 animations:^{
        customView.frame=CGRectMake(1024/2-600/2, 768/2-400/2, 600, 400);
        backImage.alpha=1;
    }];
    UIView *navView1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 44)];
    navView1.backgroundColor=[UIColor colorWithRed:251.0/255.0 green:33.0/255.0 blue:47.0/255.0 alpha:1.0];
    navView1.layer.borderColor=[UIColor grayColor].CGColor;
    navView1.layer.borderWidth=0.5;
    navView1.layer.cornerRadius =3.0;
    [customView addSubview:navView1];
    UILabel *TitleLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    TitleLab.backgroundColor=[UIColor clearColor];
    TitleLab.center=navView1.center;
    TitleLab.text=@"添加自定义菜";
    TitleLab.textColor=[UIColor whiteColor];
    TitleLab.textAlignment=NSTextAlignmentCenter;
    [navView1 addSubview:TitleLab];
    UILabel *caimingLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 70, 100, 44)];
    caimingLab.text=@"菜名:";
    caimingLab.backgroundColor=[UIColor clearColor];
    [customView addSubview:caimingLab];
    UILabel *caijiaLab=[[UILabel alloc] initWithFrame:CGRectMake(20, 150, 100, 44)];
    caijiaLab.text=@"菜价:";
    caijiaLab.backgroundColor=[UIColor clearColor];
    [customView addSubview:caijiaLab];
    UIView *left2=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    nameTF=[[UITextField alloc] initWithFrame:CGRectMake(20, 110, 500, 30)];
    nameTF.borderStyle=UITextBorderStyleRoundedRect;
    nameTF.delegate=self;
    nameTF.leftView=left2;
    UIImageView *leftImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mingcheng.png"]];
    leftImage2.frame=CGRectMake(0, 0, 25, 25);
    [left2 addSubview:leftImage2];
    nameTF.leftViewMode = UITextFieldViewModeAlways;
    nameTF.placeholder=@"请输入菜品名称";
    [customView addSubview:nameTF];
    priceTF=[[UITextField alloc] initWithFrame:CGRectMake(20, 190, 500, 30)];
    priceTF.borderStyle=UITextBorderStyleRoundedRect;
    priceTF.delegate=self;
    UIView *left=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    priceTF.leftView=left;
    UIImageView *leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiaqian.png"]];
    leftImage.frame=CGRectMake(0, 0, 25, 25);
    [left addSubview:leftImage];
    priceTF.leftViewMode = UITextFieldViewModeAlways;
    priceTF.placeholder=@"请输入菜品价格";
    [customView addSubview:priceTF];
    cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor=[UIColor colorWithRed:251.0/255.0 green:33.0/255.0 blue:47.0/255.0 alpha:1.0];
    cancelBtn.frame=CGRectMake(30, 330, 250, 40);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelbtn_click) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:cancelBtn];
    sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.backgroundColor=[UIColor colorWithRed:251.0/255.0 green:33.0/255.0 blue:47.0/255.0 alpha:1.0];
    sureBtn.frame=CGRectMake(310, 330, 250, 40);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(surebtn_click) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:sureBtn];
    
    titleAry=[[NSArray alloc] initWithObjects:@"热菜",@"凉菜",@"酒水",@"果盘",@"烤鸭",@"面点",@"其他", nil];
    typeIDAry=[[NSArray alloc] initWithObjects:@"10",@"11",@"12",@"13",@"19",@"18",@"14", nil];
    btnAry=[[NSMutableArray alloc] init];
    for (int i = 0; i < 7; i++)
    {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(40+80*i, 270, 80, 20)];
        lab.font = [UIFont fontWithName:@"Arial" size:14];
        lab.text = [titleAry objectAtIndex:i];
        lab.backgroundColor = [UIColor clearColor];
        [customView addSubview:lab];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10+80*i, 267, 110, 30);
        btn.tag = i+1;
        [btn addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"no click.png"] forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(6, 9, 9, 85)];
        [btnAry addObject:btn];
        [customView addSubview:btn];
        typeID=1;
        if (btn.tag == 1)
        {
            //[self selectType:btn];
            [btn setImage:[UIImage imageNamed:@"on click.png"] forState:UIControlStateNormal];
        }
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
//搜索
-(void)searchBtn_Click
{
    [self searchRequest];
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
    [nameTF resignFirstResponder];
    [priceTF resignFirstResponder];
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:.3 animations:^{
        customView.frame=CGRectMake(1024/2-600/2, 768/2-400/2, 600, 400);
    }];
    
}
# pragma mark - --- searchbar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarShouldBeginEditing");
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchBtn_Click];
    [searchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}
#pragma mark ---textField
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    cancelBtn.userInteractionEnabled=NO;
    sureBtn.userInteractionEnabled=NO;
    [UIView animateWithDuration:.3 animations:^{
        customView.frame=CGRectMake(1024/2-600/2, 0, 600, 400);
    }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    cancelBtn.userInteractionEnabled=YES;
    sureBtn.userInteractionEnabled=YES;
}
-(void)cancelbtn_click
{
    [UIView animateWithDuration:.3 animations:^{
        customView.frame=CGRectMake(1024/2-600/2, 768, 600, 400);
        backImage.alpha=0;
    } completion:^(BOOL finished) {
        [customView removeFromSuperview];
        [backImage removeFromSuperview];
    }];
}
-(void)surebtn_click
{
    if ([nameTF.text isEqualToString:@""]||[priceTF.text isEqualToString:@""])
    {
        [MyAlert ShowAlertMessage:@"请输入菜品名称和价格" title:@"温馨提醒"];
    }
    else
    {
        NSLog(@"0000");
        [self customRequest];
    }
    
}
- (void)selectType:(id)sender
{
    for (UIButton *btn  in btnAry)
    {
        [btn setImage:[UIImage imageNamed:@"no click.png"] forState:UIControlStateNormal];
    }
    UIButton *btn = (UIButton*)sender;
    [btn setImage:[UIImage imageNamed:@"on click.png"] forState:UIControlStateNormal];
    typeID=btn.tag;
}
#pragma mark - OrderSumbitView delegate
-(void)OrderSumbitView:(OrderSumbitView *)aOrderView andLeftDotNumber:(double)aDotNumber andProid:(NSString *)aProId andThirdCell:(ThirdModeCell *)aThirdCell
{
    if (aDotNumber>0)
    {
        [DataBase UpdateDotNumber:[aProId intValue] currDotNumber:aDotNumber];
//        if (self.isFromAddMain)
//        {
//           [DataBase1 UpdateDotNumber:[aProId intValue] currDotNumber:aDotNumber];
//        }
    }
    else
    {
        [DataBase deleteProID:[aProId intValue]];
//        if (self.isFromAddMain)
//        {
//           [DataBase1 deleteProID:[aProId intValue]];
//        }
    }
    [self.remberDishNumber setValue:[NSString stringWithFormat:@"%g",aDotNumber] forKey:[NSString stringWithFormat:@"%@",aProId]];
    [self reloadReleaseRATreeData];
    
    [self addDishUI];
}
-(void)OrderSumbitView:(OrderSumbitView *)aOrderView andRightDotNumber:(double)aDotNumber andProid:(NSString *)aProId andThirdCell:(ThirdModeCell *)aThirdCell
{
      NSLog(@"rightdot = %g,id = %@",aDotNumber,aProId);
    [DataBase UpdateDotNumber:[aProId intValue] currDotNumber:aDotNumber];
    
    if (self.isFromAddMain)
    {
       [DataBase UpdateDotNumber:[aProId intValue] currDotNumber:aDotNumber];
    }
    
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
#pragma mark --request
-(void)customRequest
{
    [MyActivceView startAnimatedInView:self.view];
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl: @"http://192.168.1.100:8082/luban/om_interface/product.asmx?op=AddCustomProduct"];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <AddCustomProduct xmlns=\"http://tempuri.org/\">\
                       <title>%@</title>\
                       <typeid>%d</typeid>\
                       <prices>%@</prices>\
                       </AddCustomProduct>\
                       </soap:Body>\
                       </soap:Envelope>",nameTF.text,[[typeIDAry objectAtIndex:typeID-1] intValue],priceTF.text];
    request.tag=11111;
    [request addRequestHeader:@"Host" value:@"192.168.1.100"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/AddCustomProduct"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    request.delegate=self;
    [request startAsynchronous];
    
}

-(void)searchRequest
{
    [MyActivceView startAnimatedInView:self.view];
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl: @"http://192.168.1.100:8082/luban/om_interface/product.asmx?op=ProductListByPy"];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <ProductListByPy xmlns=\"http://tempuri.org/\">\
                       <keys>%@</keys>\
                       </ProductListByPy>\
                       </soap:Body>\
                       </soap:Envelope>",nav.mySarchBar.text];
    request.tag=22222;
    [request addRequestHeader:@"Host" value:@"192.168.1.100"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/ProductListByPy"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    request.delegate=self;
    [request startAsynchronous];
    
}
- (void)requestStarted:(ASIHTTPRequest *)request
{
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [MyActivceView stopAnimatedInView:self.view];
    if (request.tag==11111)
    {
        NSString *resultStr=[NSString ConverStringfromData:request.responseData name:@"AddCustomProduct"];
        if (resultStr==nil||[resultStr isEqualToString:@"0"])
        {
            [MyAlert ShowAlertMessage:@"添加菜品失败" title:@"温馨提醒"];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"添加成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }
    if (request.tag==22222)
    {
        NSArray *resultAry=[NSString ConverfromData:request.responseData name:@"ProductListByPy"];
        [self.myProArr removeAllObjects];
        self.myProArr=[NSMutableArray arrayWithArray:resultAry];
        [self addDishUI];
    }
    
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MyActivceView stopAnimatedInView:self.view];
    [MyAlert ShowAlertMessage:@"网速不给力啊!" title:@"温馨提醒"];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        [self cancelbtn_click];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
