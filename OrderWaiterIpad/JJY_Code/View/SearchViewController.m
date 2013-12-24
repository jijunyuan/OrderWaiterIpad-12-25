//
//  SearchViewController.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-12.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "SearchViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Check_Order_DetailViewController.h"
@interface SearchViewController ()
@end
@implementation SearchViewController
@synthesize listAry;
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
    self.navTitle.text=@"订单搜索";

    //搜索栏
    aSearchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 44, 1024-60, 44)];
    aSearchBar.delegate=self;
    aSearchBar.placeholder=@"请输入订单号或者联系方式";
    [self.view addSubview:aSearchBar];
    UIView *segment=[aSearchBar.subviews objectAtIndex:0];
    [segment removeFromSuperview];
    aSearchBar.backgroundColor=[UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    aSearchBar.tintColor=[UIColor colorWithRed:251.0/255.0 green:33.0/255.0 blue:47.0/255.0 alpha:1.0];
    aSearchBar.keyboardType=UIKeyboardTypeNumberPad;
    UIButton *searBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searBtn.frame=CGRectMake(1024-55, 51, 45, 29);
    searBtn.backgroundColor=[UIColor colorWithRed:251.0/255.0 green:33.0/255.0 blue:47.0/255.0 alpha:1.0];
    searBtn.layer.borderColor=[[UIColor grayColor] CGColor];
    searBtn.layer.borderWidth=1;
    searBtn.layer.cornerRadius=5.0;
    [searBtn setTitle:@"搜索" forState:UIControlStateNormal];
    searBtn.titleLabel.font=[UIFont systemFontOfSize:12.0];
    searBtn.showsTouchWhenHighlighted=YES;
    [searBtn addTarget:self action:@selector(searchBtn_Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searBtn];
}
# pragma mark tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listAry count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableViewCell = @"tableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell];
        cell.selectionStyle=UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    UILabel *aLab=[[UILabel alloc] initWithFrame:CGRectMake(50, 0, 100, 44)];
    aLab.backgroundColor=[UIColor clearColor];
    aLab.text=@"订单号:";
    [cell addSubview:aLab];
    UILabel *aaLab=[[UILabel alloc] initWithFrame:CGRectMake(110, 0, 200, 44)];
    aaLab.backgroundColor=[UIColor clearColor];
    aaLab.text=[[listAry objectAtIndex:indexPath.row]valueForKey:@"OrderNum"];
    [cell addSubview:aaLab];
    UILabel *bLab=[[UILabel alloc] initWithFrame:CGRectMake(270, 0, 100, 44)];
    bLab.backgroundColor=[UIColor clearColor];
    bLab.text=@"下单时间:";
    [cell addSubview:bLab];
    UILabel *bbLab=[[UILabel alloc] initWithFrame:CGRectMake(350, 0, 250, 44)];
    bbLab.backgroundColor=[UIColor clearColor];
    bbLab.text=[[listAry objectAtIndex:indexPath.row]valueForKey:@"AddTime"];
    [cell addSubview:bbLab];
    UILabel *cLab=[[UILabel alloc] initWithFrame:CGRectMake(540, 0, 100, 44)];
    cLab.backgroundColor=[UIColor clearColor];
    cLab.text=@"联系方式:";
    [cell addSubview:cLab];
    UILabel *ccLab=[[UILabel alloc] initWithFrame:CGRectMake(620, 0, 150, 44)];
    ccLab.backgroundColor=[UIColor clearColor];
    ccLab.text=[[listAry objectAtIndex:indexPath.row]valueForKey:@"tel"];
    [cell addSubview:ccLab];
    UILabel *dLab=[[UILabel alloc] initWithFrame:CGRectMake(780, 0, 100, 44)];
    dLab.backgroundColor=[UIColor clearColor];
    dLab.text=@"餐桌号:";
    [cell addSubview:dLab];
    UILabel *ddLab=[[UILabel alloc] initWithFrame:CGRectMake(850, 0, 100, 44)];
    ddLab.backgroundColor=[UIColor clearColor];
    ddLab.text=@"无";
    [cell addSubview:ddLab];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    Check_Order_DetailViewController *checkVC=[[Check_Order_DetailViewController alloc] init];
    checkVC.check_ary=[self.listAry objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:checkVC animated:YES];
}
# pragma mark - --- searchbar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarShouldBeginEditing");

    searchBar.showsCancelButton=YES;
    for( id cc in [searchBar subviews]){
        if([cc isKindOfClass:[UIButton class]]){
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }    
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchBtn_Click];
    [searchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton=NO;
}

# pragma mark  ---asi http
-(void)searchBtn_Click
{
    [listAry removeAllObjects];
    [aTableView removeFromSuperview];
    [aSearchBar resignFirstResponder];
    [MyActivceView startAnimatedInView:self.view];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl: @"http://192.168.1.100:8082/luban/OM_Interface/Waiter.asmx?op=GetOrderForSearch"];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <GetOrderForSearch xmlns=\"http://tempuri.org/\">\
                       <RestId>%d</RestId>\
                       <Key>%@</Key>\
                       </GetOrderForSearch>\
                       </soap:Body>\
                       </soap:Envelope>",[[userDefault objectForKey:KEY_CURR_RESTID] intValue],aSearchBar.text];
    [request addRequestHeader:@"Host" value:@"interface.hcgjzs.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/GetOrderForSearch"];
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
    NSArray *Ary=[NSString ConverfromData:request.responseData name:@"GetOrderForSearch"];
    listAry=[NSMutableArray arrayWithArray:Ary];
    NSLog(@"list %@",listAry);
    aTableView=[[UITableView alloc] initWithFrame:CGRectMake(-20, 88, 1064, 748-88) style:UITableViewStyleGrouped];
    aTableView.delegate=self;
    aTableView.dataSource=self;
    [self.view addSubview:aTableView];
    if ([listAry count]==0)
    {
        [MyAlert ShowAlertMessage:@"没有搜索结果" title:@"温馨提醒"];
    }
    [aTableView reloadData];
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MyActivceView stopAnimatedInView:self.view];
    [MyAlert ShowAlertMessage:@"网速不给力啊!" title:@"温馨提醒"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
