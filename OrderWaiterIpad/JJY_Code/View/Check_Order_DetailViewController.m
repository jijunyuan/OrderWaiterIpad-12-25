//
//  Check_Order_DetailViewController.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-12.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "Check_Order_DetailViewController.h"
#import "DCRoundSwitch.h"
#import "FPPopoverController.h"
#import "PersonList.h"
#import "DishesCustomCell.h"
@interface Check_Order_DetailViewController ()
@end
@implementation Check_Order_DetailViewController
@synthesize check_ary,dishesMutAry;
@synthesize allKeysAry,dishAry;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initializationallKeysAry
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navTitle.text=[self.check_ary valueForKey:@"tel"];
    UIButton *checkBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    checkBtn.frame=CGRectMake(780, 650, 161, 61);
    [checkBtn setImage:[UIImage imageNamed:@"提交.png"] forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(checkBtn_Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBtn];
    UIImageView *BImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 89, 1024, 1)];
    BImage.backgroundColor=[UIColor colorWithRed:235.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    [self.view addSubview:BImage];
    ascrollview=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 1024, 44)];
    [self.view addSubview:ascrollview];
    ascrollview.backgroundColor=[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    //ascrollview.backgroundColor=[UIColor blackColor];
    ascrollview.showsHorizontalScrollIndicator=NO;
    ascrollview.delegate=self;
    

    dishesTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 88, 1024, 748-88-140) style:UITableViewStylePlain];
//    dishesTable.backgroundColor=[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    dishesTable.delegate=self;
    dishesTable.dataSource=self;
    [self.view addSubview:dishesTable];
    //    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    //    NSString *str=[userDefault objectForKey:@""];
    //    NSLog(@"=--==-==>>>  %@",str);
    UIImageView *shuxianImage=[[UIImageView alloc] initWithFrame:CGRectMake(245, 610, 1, 748-610)];
    shuxianImage.backgroundColor=[UIColor grayColor];
    [self.view addSubview:shuxianImage];
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
    
    UILabel *tableNumLab=[[UILabel alloc] initWithFrame:CGRectMake(46, 635, 100, 44)];
    tableNumLab.backgroundColor=[UIColor clearColor];
    tableNumLab.font=[UIFont systemFontOfSize:20.0];
    tableNumLab.text=@"餐桌号:";
    tableNumLab.textColor=[UIColor blackColor];
    [self.view addSubview:tableNumLab];
    UILabel *personNumLab=[[UILabel alloc] initWithFrame:CGRectMake(46, 685, 100, 44)];
    personNumLab.backgroundColor=[UIColor clearColor];
    personNumLab.font=[UIFont systemFontOfSize:20.0];
    personNumLab.text=@"人数:";
    personNumLab.textColor=[UIColor blackColor];
    [self.view addSubview:personNumLab];
    tableNumTF=[[UITextField alloc] initWithFrame:CGRectMake(115, 640, 100, 30)];
    tableNumTF.borderStyle=UITextBorderStyleBezel;
    tableNumTF.backgroundColor=[UIColor whiteColor];
    tableNumTF.userInteractionEnabled=NO;
    [self.view addSubview:tableNumTF];
    personNumTF=[[UITextField alloc] initWithFrame:CGRectMake(115, 690, 100, 30)];
    personNumTF.borderStyle=UITextBorderStyleBezel;
    personNumTF.backgroundColor=[UIColor whiteColor];
    personNumTF.userInteractionEnabled=NO;
    [self.view addSubview:personNumTF];
    UIButton *tableNumBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    tableNumBtn.frame=CGRectMake(115, 640, 100, 30);
    [tableNumBtn addTarget:self action:@selector(tableNumBtn_click:) forControlEvents:UIControlEventTouchUpInside];
    tableNumBtn.tag=1111;
    [self.view addSubview:tableNumBtn];
    UIButton *personNumBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    personNumBtn.frame=CGRectMake(115, 690, 100, 30);
    [personNumBtn addTarget:self action:@selector(personNumBtn_click:) forControlEvents:UIControlEventTouchUpInside];
    personNumBtn.tag=0000;
    [self.view addSubview:personNumBtn];
    [self checkRequest];
    mutAryID=[[NSMutableArray alloc] init];
    mutAryStatus=[[NSMutableArray alloc] init];
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
-(void)dishesBtn_click:(id)sender
{
    UIButton *bBtn=(UIButton *)sender;
    self.dishesMutAry=[self.dishAry valueForKey:[allKeysAry objectAtIndex:bBtn.tag-1]];
    int d=bBtn.tag-1;
    [UIView animateWithDuration:.3 animations:^{
        bgImage.frame=CGRectMake(1024/4*d, 0, 256, 44);
    }];
    [dishesTable reloadData];
}
-(void)aSwitch_click:(id)sender
{
    DCRoundSwitch  *aswitch=(DCRoundSwitch *)sender;
    NSLog(@"%d",aswitch.on);
}
-(void)checkBtn_Click
{
    [mutAryStatus removeAllObjects];
    for (int i=0; i<[self.allKeysAry count]; i++)
    {
        DCRoundSwitch *aswitch=(DCRoundSwitch *)[self.view viewWithTag:100+i];
        NSString *statusStr=[NSString stringWithFormat:@"%d",aswitch.on];
        [mutAryStatus addObject:statusStr];
    }
    NSMutableString *mutaStr=[[NSMutableString alloc] init];
    for (int i=0; i<[mutAryStatus count]; i++)
    {
        [mutaStr appendString:[NSString stringWithFormat:@"%@,",[mutAryStatus objectAtIndex:i]]];
    
    }
    NSRange range={mutaStr.length-1,1};
    [mutaStr deleteCharactersInRange:range];
    NSMutableString *mutaStrID=[[NSMutableString alloc] init];
    for (int i=0; i<[mutAryStatus count]; i++)
    {
        [mutaStrID appendString:[NSString stringWithFormat:@"%@,",[mutAryID objectAtIndex:i]]];
        
    }
    NSRange rangeID={mutaStrID.length-1,1};
    [mutaStrID deleteCharactersInRange:rangeID];
    if (tableNumTF.text==nil||personNumTF.text==nil)
    {
        [MyAlert ShowAlertMessage:@"餐桌号和人数不能为空" title:@"温馨提醒"];
    }
    else
    {
        [MyActivceView startAnimatedInView:self.view];
        NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
        ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl: @"http://192.168.1.100:8082/luban/OM_Interface/OrderInterface.asmx?op=UpdateOrder"];
        NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                           <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                           <soap:Body>\
                           <UpdateOrder xmlns=\"http://tempuri.org/\">\
                           <UserId>%d</UserId>\
                           <TableId>%d</TableId>\
                           <PeopleNum>%d</PeopleNum>\
                           <ClassID>%@</ClassID>\
                           <Statue>%@</Statue>\
                           <orderID>%d</orderID>\
                           </UpdateOrder>\
                           </soap:Body>\
                           </soap:Envelope>",[[userDefault objectForKey:KEY_CURR_USERID] intValue],[table_id intValue],[tableNumTF.text intValue],mutaStrID,mutaStr,[[self.check_ary valueForKey:@"Id"] intValue]];
        NSLog(@"%d,%d,%d,%@,%@,%d",[[userDefault objectForKey:KEY_CURR_USERID] intValue],[table_id intValue],[personNumTF.text intValue],mutaStrID,mutaStr,[[self.check_ary valueForKey:@"Id"] intValue]);
        [request addRequestHeader:@"Host" value:@"dmd.tiankong360.com"];
        [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
        [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
        request.tag=360;
        [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/UpdateOrder"];
        [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
        request.delegate=self;
        [request startAsynchronous];
    }
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
                       </soap:Envelope>",[[self.check_ary valueForKey:@"Id"] intValue]];
    [request addRequestHeader:@"Host" value:@"dmd.tiankong360.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    request.tag=361;
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/getOrderInfo"];
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
    if (request.tag==360)
    {
        NSString *resultStr=[NSString ConverStringfromData:request.responseData name:@"UpdateOrder"];
        if ([resultStr intValue]==0)
        {
            [MyAlert ShowAlertMessage:@"提交失败" title:@"温馨提醒"];
        }
        else
        {
            
            [self.navigationController popViewControllerAnimated:YES];
            [MyAlert ShowAlertMessage:@"提交成功，请耐心等待" title:@"温馨提醒"];
        }
    }
    else if (request.tag==361)
    {
        NSDictionary *resultDic=(NSDictionary *)[NSString ConverfromData:request.responseData name:@"getOrderInfo"];
        NSArray *resultAry=[NSString ConverfromData:request.responseData name:@"getOrderInfo"];
        self.dishAry=resultAry;
        self.allKeysAry=[resultDic allKeys];
        ascrollview.contentSize=CGSizeMake(1024/4*[self.allKeysAry count]+1, 44);
        NSMutableArray *diMutAry=nil;
        bgImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 256, 44)];
        bgImage.image=[UIImage imageNamed:@"核对标题f"];
        [ascrollview addSubview:bgImage];
        NSMutableArray *allDishesAry=[[NSMutableArray alloc] init];
        for (int i=0; i<[self.allKeysAry count]; i++)
        {
            UILabel *aLab=[[UILabel alloc] initWithFrame:CGRectMake(1024/4*i, 2, 120, 40)];
            aLab.text=[self.allKeysAry objectAtIndex:i];
            aLab.textAlignment=NSTextAlignmentCenter;
            aLab.backgroundColor=[UIColor clearColor];
            [ascrollview addSubview:aLab];
            UIImageView *aImage=[[UIImageView alloc] initWithFrame:CGRectMake(1024/4*(i+1)-1, 0, 1, 44)];
            aImage.backgroundColor=[UIColor grayColor];
            [ascrollview addSubview:aImage];
            DCRoundSwitch *aSwitch=[[DCRoundSwitch alloc] initWithFrame:CGRectMake(130+1024/4*i, 7, 90, 30)];
            aSwitch.onText=@"即起";
            aSwitch.offText=@"叫起";
            aSwitch.on=YES;
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
            diMutAry=[self.dishAry valueForKey:[allKeysAry objectAtIndex:i]];
            [allDishesAry addObject:diMutAry];
            NSString *classID=[[diMutAry objectAtIndex:0] valueForKey:@"ClassID"];
            [mutAryID addObject:classID];
        }
        double sum=0;
        
        NSString *s;
        NSMutableString *totalMutStr=[[NSMutableString alloc] init];
        for (int p=0; p<[allDishesAry count]; p++)
        {
            NSArray *ary=[allDishesAry objectAtIndex:p];
            NSString *dishesStr=[allKeysAry objectAtIndex:p];

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
        totalpriceLab2.text=[NSString stringWithFormat:@"共%g元",sum];
        self.dishesMutAry=[self.dishAry valueForKey:[allKeysAry objectAtIndex:0]];
        [dishesTable reloadData];
    }

    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MyActivceView stopAnimatedInView:self.view];
    [MyAlert ShowAlertMessage:@"网速不给力啊!" title:@"温馨提醒"];
}
-(void)tableNumBtn_click:(id)sender
{
    [self popover:sender];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popDismiss_table:) name:@"popoverVC_table" object:nil];
}
-(void)personNumBtn_click:(id)sender
{
    [self popover:sender];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popDismiss_person:) name:@"popoverVC_person" object:nil];
}
-(void)showPopOverView:(id)sender
{

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
- (void)popDismiss_person:(NSNotification *)aNotification
{
    NSDictionary * dic = aNotification.userInfo;
    personNumTF.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"personId"]];
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
