//
//  StandardViewController.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-17.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "StandardViewController.h"
#import "Check_Order_DetailViewController.h"
#import "ImageDishesView.h"
#import "UIImageView+WebCache.h"
#import "DataBase.h"
#import "ChangeDishView.h"
#import "CheckOrderViewController.h"
@interface StandardViewController ()

@end

@implementation StandardViewController
@synthesize array,myProArr;
@synthesize remberDishNumber;
@synthesize myClassArr,dataArr,orderSumbitView,clarrleftArr,remberMarkValueDic,remberDishStatusDic;
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
	self.navTitle.text=@"标餐";
    UIImageView * eatrightLine = [[UIImageView alloc] initWithFrame:CGRectMake(893, 0, 2, 44)];
    eatrightLine.image = [UIImage imageNamed:@"标题线.png"];
    [self.view addSubview:eatrightLine];
    UIButtonType buttonType;
    if ([WebService ISIOS7])
    {
        buttonType = UIButtonTypeSystem;
    }
    else
    {
        buttonType = UIButtonTypeCustom;
    }
    //提交订单按钮
    UIButton * eatStandBrn = [UIButton buttonWithType:buttonType];
    [eatStandBrn setTitle:@"提交订单" forState:UIControlStateNormal];
    [eatStandBrn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [eatStandBrn.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    eatStandBrn.frame = CGRectMake(913, 2, 90, 40);
    eatStandBrn.showsTouchWhenHighlighted=YES;
    [eatStandBrn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eatStandBrn];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self standardRequest];
    
    aTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 44, 360, 768-44) style:UITableViewStyleGrouped];
    aTableView.delegate=self;
    aTableView.dataSource=self;
//    aTableView.layer.borderColor=[UIColor grayColor].CGColor;
//    aTableView.layer.borderWidth=0.5;
//    aTableView.layer.cornerRadius =10.0;
   // [self.view addSubview:aTableView];
    self.array=[[NSMutableArray alloc] init];
    array3=[[NSMutableArray alloc] init];
    menuIDary=[[NSMutableArray alloc] init];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(360, 44, 664, 768-44)];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor=[UIColor whiteColor];

}
-(void)submit
{ 
    CheckOrderViewController *checkVC=[[CheckOrderViewController alloc] init];
    checkVC.dataArr=self.myProArr;
    [self.navigationController pushViewController:checkVC animated:YES];
}
#pragma mark Table view  delegate methods
//返回分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [array3 count];
}

// 返回每个分区的行的个数,启始返回0，点啥返回相应的分区的行的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//根据flag数组所对应的布尔值为真就返回正确的行数
	//如果flag数组所应对的布尔值为假就返回0
	NSInteger ns=[self numberOfRowsInSection2:section];
	return ns;
    //    return [_array count];
}
//返回每个分区的行数，根据flag数组对应的布尔值返回
- (int)numberOfRowsInSection2:(NSInteger)section
{
	
	if (flag[section]) {//如果某个分区对应的布尔值是真，则给相应分区制定行数
		return [[self.array objectAtIndex:section] count];
	}
	else
	{
		return 0;
	}
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"CellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //右边小箭头
        // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		//单元格的选择风格，选择时单元格不出现蓝条
		//cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        
    }
    NSString *aStr=[[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text=aStr;
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
	return cell;
}
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
//
//forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    NSInteger realRow = [self realRowNumberForIndexPath:indexPath inTableView:tableView];
//    
//    cell.backgroundColor = (realRow%2)?[UIColor lightGrayColor]:[UIColor whiteColor];
//    
//}
- (NSInteger)realRowNumberForIndexPath:(NSIndexPath *)indexPath

                           inTableView:(UITableView *)tableView {
    
    NSInteger retInt = 0;
    
    if (!indexPath.section) {
        
        return indexPath.row;
        
    }
    
    for (int i=0; i<indexPath.section;i++) {
        
        retInt += [tableView numberOfRowsInSection:i];
        
    }
    
    return retInt + indexPath.row;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *aview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 367, 44)];
    //    UIImageView *aimage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"a.png"]];
    //    aimage.frame=CGRectMake(0, 0, 60, 44);
    //    [aview addSubview:aimage];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 367, 36);
    [btn setTitle:[array3 objectAtIndex:section] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:[array3 objectAtIndex:section]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"选项2"] forState:UIControlStateNormal];
//    [btn setBackgroundColor:[UIColor colorWithRed:1.0/255.0 green:241.0/255.0 blue:255.0/255.0 alpha:1.0]];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [aview  addSubview:btn];
    [tableView addSubview:aview];
    btn.tag=section;
    //    btn.backgroundColor=[UIColor colorWithRed:100.0/255.0 green:50.0/255.0 blue:222.0/255.0 alpha:1.0];
    return aview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSAssert(0, @"崩溃");
    NSString *aStr=[[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        NSLog(@"%@",aStr);
    NSString *s=[[menuIDary objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    taocanID=[s intValue];
    [self taocanRequest];
}
-(void)click:(id)sender
{
    UIButton *aBtn=(UIButton *)sender;
    flag[aBtn.tag]= !flag[aBtn.tag];
    //[_tableView reloadData];
    NSIndexSet *set=[NSIndexSet indexSetWithIndex:aBtn.tag];
    [aTableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark --- request delegate

-(void)taocanRequest
{
    [MyActivceView startAnimatedInView:self.view];
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl: @"http://192.168.1.100:8082/luban/om_interface/product.asmx?op=GetPackage"];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <GetPackage xmlns=\"http://tempuri.org/\">\
                       <restid>%d</restid>\
                       <menuid>%d</menuid>\
                       </GetPackage>\
                       </soap:Body>\
                       </soap:Envelope>",[KEY_CURR_RESTID intValue],taocanID];
    request.tag=11111;
    [request addRequestHeader:@"Host" value:@"192.168.1.100"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/GetPackage"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    request.delegate=self;
    [request startAsynchronous];
}
-(void)standardRequest
{
    [MyActivceView startAnimatedInView:self.view];
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl: @"http://192.168.1.100:8082/luban/OM_Interface/Product.asmx?op=GetChannelList"];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                        <GetChannelList xmlns=\"http://tempuri.org/\" />\
                       </soap:Body>\
                       </soap:Envelope>"];
    request.tag=22222;
    [request addRequestHeader:@"Host" value:@"192.168.1.100"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/GetChannelList"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    request.delegate=self;
    [request startAsynchronous];
}
//-(void)submitRequest
//{
//    [MyActivceView startAnimatedInView:self.view];
//    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl: @"http://192.168.1.100:8082/luban/om_interface/OrderInterface.asmx?op=SubmitOrder"];
//    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
//                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
//                       <soap:Body>\
//                       <SubmitOrder xmlns=\"http://tempuri.org/\">\
//                       <UserId>%d</UserId>\
//                       <RestId>%d</RestId>\
//                       <TableId>%@</TableId>\
//                       <MenuId>int</MenuId>\
//                       <Time>string</Time>\
//                       <PeopleNum>int</PeopleNum>\
//                       <IdStr>string</IdStr>\
//                       <CopiesSt>string</CopiesSt>\
//                       <DishesMark>string</DishesMark>\
//                       <Statue>string</Statue>\
//                       </SubmitOrder>\
//                       </soap:Body>\
//                       </soap:Envelope>",[KEY_CURR_USERID intValue],[KEY_CURR_RESTID intValue]];
//    request.tag=33333;
//    [request addRequestHeader:@"Host" value:@"192.168.1.100"];
//    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
//    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
//    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/SubmitOrder"];
//    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
//    request.delegate=self;
//    [request startAsynchronous];
//}
- (void)requestStarted:(ASIHTTPRequest *)request
{
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [MyActivceView stopAnimatedInView:self.view];
    if (request.tag==11111)
    {
        NSArray *resultAry=[NSString ConverfromData:request.responseData name:@"GetPackage"];
        self.myProArr=[NSMutableArray arrayWithArray:[resultAry valueForKey:@"products"]];
        [self addDishUI];
    }
    if (request.tag==22222)
    {
        NSArray *resultAry=[NSString ConverfromData:request.responseData name:@"GetChannelList"];
        NSMutableArray *taocanAry=[[NSMutableArray alloc] init];
        for (int i=0; i<[resultAry count]; i++)
        {
            [array3 addObject:[[resultAry objectAtIndex:i] valueForKey:@"title"]];
            [taocanAry addObject:[[resultAry objectAtIndex:i] valueForKey:@"package"]];
            [array addObject:[[taocanAry objectAtIndex:i] valueForKey:@"username"]];
            [menuIDary addObject:[[taocanAry objectAtIndex:i] valueForKey:@"Id"]];
        }
        [self.view addSubview:aTableView];
        taocanID=[[[menuIDary objectAtIndex:0] objectAtIndex:0] intValue];
        [self taocanRequest];
    }
    
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MyActivceView stopAnimatedInView:self.view];
    [MyAlert ShowAlertMessage:@"网速不给力啊!" title:@"温馨提醒"];
}
#pragma mark ----------
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
        imageDishView1.dishView.hidden=YES;
        imageDishView1.productId = [NSString stringWithFormat:@"%@",[dishDictory valueForKey:@"ProID"]];
        imageDishView1.dishDictory = dishDictory;
        imageDishView1.backgroundColor=[UIColor clearColor];
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
//            RADataObject * thirdMode = [RADataObject dataObjectWithName:[str1 stringByAppendingFormat:@",%@",markValue1] children:nil];
//            
//            RADataObject * secondMode = [RADataObject dataObjectWithName:str1 children:[NSArray arrayWithObjects:thirdMode, nil]];
//            [classGroubArr addObject:secondMode];
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
        
        
//        RADataObject * firstMode = [RADataObject dataObjectWithName:[[dicTemp1 valueForKey:@"TypeName"] stringByAppendingFormat:@",%@",strStsus] children:classGroubArr];
//        [fristArr addObject:firstMode];
        
        [arrTemp1 removeAllObjects];
    }
    __block int indexD1 = 0;
    __block BOOL isHaveChildRen = YES;
    __block NSString * className;
//    [fristArr enumerateObjectsUsingBlock:^(RADataObject * obj, NSUInteger idx, BOOL *stop) {
//        if (obj.children.count == 0)
//        {
//            isHaveChildRen = NO;
//            indexD1 = idx;
//            className = obj.name;
//            *stop = YES;
//        }
//    }];
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
//    leftBottom.L_dishNum.text = [NSString stringWithFormat:@"%g",numberDot];
//    leftBottom.L_sum.text = [NSString stringWithFormat:@"￥%g",sumMon];
    
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
//            RADataObject * thirdMode = [RADataObject dataObjectWithName:[str1 stringByAppendingFormat:@",%@",markValue1] children:nil];
//            
//            RADataObject * secondMode = [RADataObject dataObjectWithName:str1 children:[NSArray arrayWithObjects:thirdMode, nil]];
//            [classGroubArr addObject:secondMode];
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
//        RADataObject * firstMode = [RADataObject dataObjectWithName:[[dicTemp1 valueForKey:@"TypeName"] stringByAppendingFormat:@",%@",strStsus] children:classGroubArr];
//        [fristArr addObject:firstMode];
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
//    leftBottom.L_dishNum.text = [NSString stringWithFormat:@"%g",numberDot];
//    leftBottom.L_sum.text = [NSString stringWithFormat:@"￥%g",sumMon];
    
    [dotArr removeAllObjects];
    dotArr = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
