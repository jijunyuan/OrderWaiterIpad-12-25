//
//  Checked_dishesViewController.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-13.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "Checked_dishesViewController.h"
#import "DCRoundSwitch.h"
#import "FPPopoverController.h"
#import "PersonList.h"
#import "DishesCustomCell.h"
#import "Add_dishesViewController.h"
#import "Detail_DishesViewController.h"
@interface Checked_dishesViewController ()

@end

@implementation Checked_dishesViewController
@synthesize checkedAry,allKeysAry,dishAry,dishesMutAry;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//-----------000
//00000000000
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitle.text=[self.checkedAry valueForKey:@"tel"];
    UILabel *checkLab=[[UILabel alloc] initWithFrame:CGRectMake(860, 0, 50, 44)];
    checkLab.backgroundColor=[UIColor clearColor];
    checkLab.textColor=[UIColor whiteColor];
    checkLab.text=@"审单";
    checkLab.font=[UIFont systemFontOfSize:20.0];
    [self.view addSubview:checkLab];
    UILabel *exchangeLab=[[UILabel alloc] initWithFrame:CGRectMake(950, 0, 50, 44)];
    exchangeLab.backgroundColor=[UIColor clearColor];
    exchangeLab.textColor=[UIColor whiteColor];
    exchangeLab.font=[UIFont systemFontOfSize:20.0];
    exchangeLab.text=@"换桌";
    [self.view addSubview:exchangeLab];
    UIButton *checkBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    checkBtn.frame=CGRectMake(825, 0, 100, 44);
    checkBtn.showsTouchWhenHighlighted=YES;
    [checkBtn addTarget:self action:@selector(checkBtn_Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBtn];
    UIButton *exchangeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [exchangeBtn addTarget:self action:@selector(exchangeBtn_Click) forControlEvents:UIControlEventTouchUpInside];
    exchangeBtn.frame=CGRectMake(920, 0, 100, 44);
    exchangeBtn.showsTouchWhenHighlighted=YES;
    [self.view addSubview:exchangeBtn];
    for (int p=0; p<2; p++)
    {
        UIImageView *shuxianImage=[[UIImageView alloc] initWithFrame:CGRectMake(925-p*90, 0, 2, 44)];
        shuxianImage.image=[UIImage imageNamed:@"标题线.png"];
        [self.view addSubview:shuxianImage];
    }

    ascrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 1024, 44)];
    [self.view addSubview:ascrollview];
    ascrollview.backgroundColor=[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    ascrollview.showsHorizontalScrollIndicator=NO;
    ascrollview.delegate=self;
    dishesTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 88, 1024, 748-88-140) style:UITableViewStylePlain];
    //    dishesTable.backgroundColor=[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    dishesTable.delegate=self;
    dishesTable.dataSource=self;
    [self.view addSubview:dishesTable];
//    //    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
//    //    NSString *str=[userDefault objectForKey:@""];
//    //    NSLog(@"=--==-==>>>  %@",str);
    UILabel *totalLab=[[UILabel alloc] initWithFrame:CGRectMake(260, 635, 100, 44)];
    totalLab.backgroundColor=[UIColor clearColor];
    totalLab.font=[UIFont systemFontOfSize:20.0];
    totalLab.text=@"总计:";
    totalLab.textColor=[UIColor blackColor];
    [self.view addSubview:totalLab];
    UILabel *totalpriceLab=[[UILabel alloc] initWithFrame:CGRectMake(260, 685, 100, 44)];
    totalpriceLab.backgroundColor=[UIColor clearColor];
    totalpriceLab.font=[UIFont systemFontOfSize:20.0];
    totalpriceLab.text=@"总价:";
    totalpriceLab.textColor=[UIColor blackColor];
    [self.view addSubview:totalpriceLab];
    totalLab2=[[UILabel alloc] initWithFrame:CGRectMake(335, 635, 500, 44)];
    totalLab2.backgroundColor=[UIColor clearColor];
    totalLab2.font=[UIFont systemFontOfSize:20.0];
    totalLab2.textColor=[UIColor blackColor];
    totalLab2.numberOfLines=0;
    [self.view addSubview:totalLab2];
    totalpriceLab2=[[UILabel alloc] initWithFrame:CGRectMake(335, 685, 200, 44)];
    totalpriceLab2.backgroundColor=[UIColor clearColor];
    totalpriceLab2.font=[UIFont systemFontOfSize:20.0];
    totalpriceLab2.textColor=[UIColor blackColor];
    [self.view addSubview:totalpriceLab2];
    UILabel *personNumLab=[[UILabel alloc] initWithFrame:CGRectMake(46, 685, 100, 44)];
    personNumLab.backgroundColor=[UIColor clearColor];
    personNumLab.font=[UIFont systemFontOfSize:20.0];
    personNumLab.text=@"人   数:";
    personNumLab.textColor=[UIColor blackColor];
    [self.view addSubview:personNumLab];
    personNumTF=[[UITextField alloc] initWithFrame:CGRectMake(115, 690, 100, 30)];
    personNumTF.borderStyle=UITextBorderStyleBezel;
    personNumTF.backgroundColor=[UIColor whiteColor];
    personNumTF.userInteractionEnabled=NO;
    personNumTF.text=[NSString stringWithFormat:@"%@",[self.checkedAry valueForKey:@"peopleNum"]];
    [self.view addSubview:personNumTF];
    UILabel *tableNumLab=[[UILabel alloc] initWithFrame:CGRectMake(46, 635, 100, 44)];
    tableNumLab.backgroundColor=[UIColor clearColor];
    tableNumLab.font=[UIFont systemFontOfSize:20.0];
    tableNumLab.text=@"餐桌号:";
    tableNumLab.textColor=[UIColor blackColor];
    [self.view addSubview:tableNumLab];
    tableNumTF=[[UITextField alloc] initWithFrame:CGRectMake(115, 640, 100, 30)];
    tableNumTF.borderStyle=UITextBorderStyleBezel;
    tableNumTF.backgroundColor=[UIColor whiteColor];
    tableNumTF.userInteractionEnabled=NO;
    tableNumTF.text=[self.checkedAry valueForKey:@"TableNum"];
    [self.view addSubview:tableNumTF];
    UIButton *tableNumBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    tableNumBtn.frame=CGRectMake(115, 640, 100, 30);
    [tableNumBtn addTarget:self action:@selector(tableNumBtn_click:) forControlEvents:UIControlEventTouchUpInside];
    tableNumBtn.tag=1111;
    [self.view addSubview:tableNumBtn];
    UIButton *addBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    addBtn.frame=CGRectMake(780, 650, 161, 61);
    [addBtn addTarget:self action:@selector(addBtn_Click) forControlEvents:UIControlEventTouchUpInside];
    [addBtn setImage:[UIImage imageNamed:@"加菜.png"] forState:UIControlStateNormal];
    [self.view addSubview:addBtn];
    [self checkRequest];
}

-(void)dishesBtn_click:(id)sender
{
    UIButton *bBtn=(UIButton *)sender;
    self.dishesMutAry=[dishAry valueForKey:[self.allKeysAry objectAtIndex:bBtn.tag-1]];
    int d=bBtn.tag-1;
    [UIView animateWithDuration:.3 animations:^{
        bgImage.frame=CGRectMake(1024/4*d, 0, 256, 44);
    }];
    [dishesTable reloadData];
}
-(void)aSwitch_click:(id)sender
{
    UISwitch  *aswitch=(UISwitch *)sender;
    NSLog(@"aswitch  %d",aswitch.tag);
}
-(void)addBtn_Click
{
//    [MyActivceView startAnimatedInView:self.view];
//    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl: @"http://192.168.1.100:8082/luban/OM_Interface/OrderInterface.asmx?op=getOrderInfo"];
//    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
//                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
//                       <soap:Body>\
//                       <getOrderInfo xmlns=\"http://tempuri.org/\">\
//                       <OrderId>%d</OrderId>\
//                       </getOrderInfo>\
//                       </soap:Body>\
//                       </soap:Envelope>",[[self.checkedAry valueForKey:@"id"] intValue]];
//    NSLog(@"-===  %d",[[self.checkedAry valueForKey:@"id"] intValue]);
//    [request addRequestHeader:@"Host" value:@"dmd.tiankong360.com"];
//    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
//    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
//    request.tag=22;
//    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/getOrderInfo"];
//    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
//    request.delegate=self;
//    [request startAsynchronous];
    Add_dishesViewController *addVC=[[Add_dishesViewController alloc] initWithNibName:@"Detail_DishesViewController" bundle:nil];
    addVC.orderID=[[self.checkedAry valueForKey:@"Id"] intValue];
    [self.navigationController pushViewController:addVC animated:YES];
}
-(void)checkRequest
{
    [MyActivceView startAnimatedInView:self.view];
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl: @"http://192.168.1.100:8082/luban/OM_Interface/OrderInterface.asmx?op=getOrderInfo"];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <getOrderInfo xmlns=\"http://tempuri.org/\">\
                       <OrderId>%d</OrderId>\
                       </getOrderInfo>\
                       </soap:Body>\
                       </soap:Envelope>",[[self.checkedAry valueForKey:@"Id"] intValue]];
    NSLog(@"id = %@",[self.checkedAry valueForKey:@"Id"]);
    [request addRequestHeader:@"Host" value:@"dmd.tiankong360.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    request.tag=22;
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/getOrderInfo"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    request.delegate=self;
    [request startAsynchronous];
}
-(void)checkBtn_Click
{
    [MyActivceView startAnimatedInView:self.view];
     NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    int i=[[userDefault objectForKey:KEY_CURR_RESTID] intValue];
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl: @"http://192.168.1.100:8082/luban/OM_Interface/OrderInterface.asmx?op=auditingOrder"];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <auditingOrder xmlns=\"http://tempuri.org/\">\
                       <RestId>%d</RestId>\
                       <OrderId>%d</OrderId>\
                       </auditingOrder>\
                       </soap:Body>\
                       </soap:Envelope>",i,[[self.checkedAry valueForKey:@"Id"] intValue]];
    [request addRequestHeader:@"Host" value:@"dmd.tiankong360.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    request.tag=00;
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/auditingOrder"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    request.delegate=self;
    [request startAsynchronous];
}
-(void)exchangeBtn_Click
{
    if (table_id==nil)
    {
        [MyAlert ShowAlertMessage:@"请输入餐桌号" title:@"温馨提醒"];
    }
    else
    {
        [MyActivceView startAnimatedInView:self.view];
        ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl: @"http://192.168.1.100:8082/luban/OM_Interface/Waiter.asmx?op=EditTableNum"];
        NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                           <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                           <soap:Body>\
                           <EditTableNum xmlns=\"http://tempuri.org/\">\
                           <OrderId>%d</OrderId>\
                           <TableId>%d</TableId>\
                           <OldTableiId>%d</OldTableiId>\
                           </EditTableNum>\
                           </soap:Body>\
                           </soap:Envelope>",[[self.checkedAry valueForKey:@"Id"] intValue],[table_id intValue],[[self.checkedAry valueForKey:@"TableNum"] intValue]];
        NSLog(@"%d %d %d",[[self.checkedAry valueForKey:@"Id"] intValue],[table_id intValue],[[self.checkedAry valueForKey:@"TableId"] intValue]);
        [request addRequestHeader:@"Host" value:@"dmd.tiankong360.com"];
        [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
        [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
        request.tag=11;
        [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/EditTableNum"];
        [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
        request.delegate=self;
        [request startAsynchronous];
    }

}
- (void)requestStarted:(ASIHTTPRequest *)request
{
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [MyActivceView stopAnimatedInView:self.view];
    if (request.tag==11)
    {
        NSString *resultStr=[NSString ConverStringfromData:request.responseData name:@"EditTableNum"];
        if ([resultStr intValue]==1)
        {
            [MyAlert ShowAlertMessage:@"换桌成功" title:@"温馨提醒"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [MyAlert ShowAlertMessage:@"换桌失败" title:@"温馨提醒"];
        }
    }
    if (request.tag==00)
    {
        NSString *resultStr=[NSString ConverStringfromData:request.responseData name:@"auditingOrder"];
        if ([resultStr intValue]==1)
        {
            [MyAlert ShowAlertMessage:@"审单成功" title:@"温馨提醒"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [MyAlert ShowAlertMessage:@"审单失败" title:@"温馨提醒"];
        }
    }
    if (request.tag==22)
    {
       NSArray *resultAry=[NSString ConverfromData:request.responseData name:@"getOrderInfo"];
        self.dishAry=resultAry;
        NSDictionary *resultDic=(NSDictionary *)[NSString ConverfromData:request.responseData name:@"getOrderInfo"];
        self.allKeysAry=[resultDic allKeys];
        ascrollview.contentSize=CGSizeMake(1024/4*[self.allKeysAry count]+1, 44);
        if (self.allKeysAry.count>0)
        {
            bgImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 256, 44)];
            bgImage.image=[UIImage imageNamed:@"核对标题f"];
            [ascrollview addSubview:bgImage];
        }
        NSMutableArray *allDishesAry=[[NSMutableArray alloc] init];
        for (int i=0; i<[self.allKeysAry count]; i++)
        {
            UILabel *aLab=[[UILabel alloc] initWithFrame:CGRectMake(1024/4*i, 2, 120, 40)];
            aLab.text=[self.allKeysAry objectAtIndex:i];
            aLab.backgroundColor=[UIColor clearColor];
            aLab.textAlignment=NSTextAlignmentCenter;
            [ascrollview addSubview:aLab];
            UIImageView *aImage=[[UIImageView alloc] initWithFrame:CGRectMake(1024/4*(i+1)-1, 0, 1, 44)];
            aImage.backgroundColor=[UIColor grayColor];
            [ascrollview addSubview:aImage];
            DCRoundSwitch *aSwitch=[[DCRoundSwitch alloc] initWithFrame:CGRectMake(130+1024/4*i, 7, 90, 30)];
            aSwitch.onText=@"即起";
            aSwitch.offText=@"叫起";
            aSwitch.enabled=NO;
            aSwitch.onTintColor=[UIColor colorWithRed:251.0/255.0 green:33.0/255.0 blue:47.0/255.0 alpha:1.0];
            aSwitch.tag=i+100;
            [aSwitch addTarget:self action:@selector(aSwitch_click:) forControlEvents:UIControlEventValueChanged];
            [ascrollview addSubview:aSwitch];
            UIButton *dishesBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            dishesBtn.frame=CGRectMake(1024/4*i, 0, 120, 44);
            dishesBtn.showsTouchWhenHighlighted=YES;
            [dishesBtn addTarget:self action:@selector(dishesBtn_click:) forControlEvents:UIControlEventTouchUpInside];
            dishesBtn.tag=i+1;
            [ascrollview addSubview:dishesBtn];
            
            NSMutableArray *mutAy=[self.dishAry valueForKey:[allKeysAry objectAtIndex:i]];
            [allDishesAry addObject:mutAy];
            NSString *s=[[mutAy objectAtIndex:0] valueForKey:@"Status"];
            aSwitch.on=[s intValue];

        }
        double sum=0;
       // int  total=0;
        NSString *s;
        NSString *dishesStr;
        NSMutableString *totalMutStr=[[NSMutableString alloc] init];
        for (int p=0; p<[allDishesAry count]; p++)
        {
            NSArray *ary=[allDishesAry objectAtIndex:p];
            dishesStr=[allKeysAry objectAtIndex:p];
            int total = 0;
            for (int i=0; i<[ary count]; i++)
            {
                NSDictionary *dic=[ary objectAtIndex:i];
                double price=[[dic valueForKey:@"Price"]doubleValue];
                int    copies=[[dic valueForKey:@"Copies"] intValue];
                sum+=price*copies;
                total+=copies;
            }
            s=[NSString stringWithFormat:@"%d个%@,",total,dishesStr];
            [totalMutStr appendString:s];
        }
        NSLog(@"%@",[totalMutStr substringToIndex:totalMutStr.length-1]);
        totalLab2.text=[totalMutStr substringToIndex:totalMutStr.length-1];
        NSLog(@"------------ %g",sum);
        totalpriceLab2.text=[NSString stringWithFormat:@"共%g元",sum];
        if (self.allKeysAry.count >0)
        {
            self.dishesMutAry=[self.dishAry valueForKey:[allKeysAry objectAtIndex:0]];
            [dishesTable reloadData];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MyActivceView stopAnimatedInView:self.view];
    [MyAlert ShowAlertMessage:@"网速不给力啊!" title:@"温馨提醒"];
}
# pragma mark tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dishesMutAry count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    DishesCustomCell *cell = (DishesCustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        //记载xib相当于创建了xib当中的内容，返回的数组里面包含了xib当中的对象
        // NSLog(@"新创建的cell  %d",indexPath.row);
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DishesCustomCell" owner:nil options:nil];
        
        for (NSObject *object in array)
        {
            //判断数组中的对象是不是CustomCell 类型的
            if([object isKindOfClass:[DishesCustomCell class]])
            {
                //如果是，赋给cell指针
                cell = (DishesCustomCell *)object;
                //找到之后不再寻找
                break;
            }
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSLog(@"self %@",self.dishesMutAry);
    cell.nameLab.text=[NSString stringWithFormat:@"◎%@",[[self.dishesMutAry objectAtIndex:indexPath.row] valueForKey:@"ProName"]];
    cell.priceLab.text=[NSString stringWithFormat:@"¥%@",[[self.dishesMutAry objectAtIndex:indexPath.row] valueForKey:@"Price"]];
    cell.copiesLab.text=[NSString stringWithFormat:@"点%@份",[[self.dishesMutAry objectAtIndex:indexPath.row] valueForKey:@"Copies"]];
    cell.copiesLab.textColor=[UIColor redColor];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}
-(void)tableNumBtn_click:(id)sender
{
    [self popover:sender];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popDismiss_table:) name:@"popoverVC_table" object:nil];
}
-(void)popover:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    PersonList *controller = [[PersonList alloc] initWithStyle:UITableViewStylePlain];
    controller.aryID=btn.tag;
    popover = [[FPPopoverController alloc] initWithViewController:controller];
    //popover.arrowDirection = FPPopoverArrowDirectionAny;
    popover.tint = FPPopoverDefaultTint;
    popover.contentSize = CGSizeMake(150, 500);
    popover.arrowDirection = FPPopoverArrowDirectionAny;
    //sender is the UIButton view
    [popover presentPopoverFromView:sender];
}
- (void)popDismiss_table:(NSNotification *)aNotification
{
    NSDictionary * dic = aNotification.userInfo;
    tableNumTF.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"tableId"]];
    table_id=[NSString stringWithFormat:@"%@",[dic objectForKey:@"table_Id"]];
    [popover dismissPopoverAnimated:YES];
    
}
- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
