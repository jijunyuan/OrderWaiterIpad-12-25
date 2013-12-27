//
//  OrderListViewController.m
//  OrderMenu-Waiter
//
//  Created by tiankong360 on 13-9-5.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListCell.h"

#import "DataBase.h"
#import "EGORefreshTableHeaderView.h"
#import "SearchViewController.h"
#import "Check_Order_DetailViewController.h"
#import "Checked_dishesViewController.h"
@interface OrderListViewController ()<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>
{
    int selectedSegmentIndex;
    EGORefreshTableHeaderView *_refreshTableView;
    BOOL _reloading;
}
@property (nonatomic,strong) IBOutlet UITableView * TV_tableview;
@property (nonatomic,strong) IBOutlet UIButton * Btn_search;
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) IBOutlet UIButton * checkYesBtn;
@property (nonatomic,strong) IBOutlet UIButton * checkNoBtn;

//@property (nonatomic,strong) IBOutlet UIImageView * line_imageView;
-(IBAction)searchClick:(id)sender;
-(IBAction)closeClick:(id)sender;
-(IBAction)segmentClick:(id)sender;
-(void)getData;
-(void)getData1;

//开始重新加载时调用的方法
- (void)reloadTableViewDataSource;
//完成加载时调用的方法
- (void)doneLoadingTableViewData;

@end

@implementation OrderListViewController
@synthesize TV_tableview;
@synthesize Btn_search;
@synthesize dataArr;
@synthesize checkNoBtn;
@synthesize checkYesBtn;
//@synthesize line_imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{    
    selectedSegmentIndex = 0;
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    if (selectedSegmentIndex == 0)
    {
        self.checkYesBtn.backgroundColor = [UIColor grayColor];
        self.checkYesBtn.titleLabel.textColor = [UIColor whiteColor];
        self.checkNoBtn.backgroundColor = [UIColor whiteColor];
        self.checkNoBtn.titleLabel.textColor = [UIColor blackColor];
        selectedSegmentIndex = 0;

        self.Btn_search.alpha = 0.0;
        shuxianImage.hidden=YES;
       // self.line_imageView.alpha = 0.0;
    }
    else
    {
        self.Btn_search.alpha = 1.0;
        shuxianImage.hidden=NO;
       // self.line_imageView.alpha = 1.0;
    }
    [self getData];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([WebService ISIOS7])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
  
    self.TV_tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 91, 1024, 657)];
    self.TV_tableview.dataSource = self;
    self.TV_tableview.delegate = self;
    [self.view addSubview:self.TV_tableview];
    
    self.TV_tableview.tableFooterView = [[UIView alloc] init];
    self.TV_tableview.tableHeaderView = [[UIView alloc] init];
    
    
    self.navTitle.text=@"订单管理";
    if (_refreshTableView == nil) {
        //初始化下拉刷新控件
        EGORefreshTableHeaderView *refreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.TV_tableview.bounds.size.height, self.view.frame.size.width, self.TV_tableview.bounds.size.height-20)];
        refreshView.delegate = self;
        //将下拉刷新控件作为子控件添加到UITableView中
        [self.TV_tableview addSubview:refreshView];
        _refreshTableView = refreshView;
    }
    Btn_search =[UIButton buttonWithType:UIButtonTypeCustom];
    Btn_search.frame=CGRectMake(1024-54, 0, 44, 44);
    [Btn_search setImage:[UIImage imageNamed:@"搜索.png"] forState:UIControlStateNormal];
    [Btn_search addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn_search];
    shuxianImage=[[UIImageView alloc] initWithFrame:CGRectMake(1024-60, 0, 2, 44)];
    shuxianImage.image=[UIImage imageNamed:@"标题线.png"];
    shuxianImage.hidden=YES;
    [self.view addSubview:shuxianImage];
}

-(void)getData
{
    if (self.dataArr.count>0)
    {
        self.dataArr = nil;
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    
    int status = 1;
    if (selectedSegmentIndex == 0)
    {
        status = 1;
    }
    else
    {
        status = 0;
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    ASIHTTPRequest * request = [WebService GetOrderListRestId:[[user valueForKey:KEY_CURR_RESTID] intValue] WaiterId:[[user valueForKey:KEY_CURR_USERID] intValue] Status:status];
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
        self.dataArr = (NSMutableArray *)[NSString ConverfromData:reciveData name:@"GetOrderList"];
        NSLog(@"8888888   %@",self.dataArr);
        [self.TV_tableview reloadData];
    }];
    [request setFailedBlock:^{
        [MyActivceView stopAnimatedInView:self.view];
        [MyAlert ShowAlertMessage:@"加载失败！" title:@"提示"];
    }];
}

-(void)getData1
{
    if (self.dataArr.count>0)
    {
        self.dataArr = nil;
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    
    int status = 1;
    if (selectedSegmentIndex == 0)
    {
        status = 1;
    }
    else
    {
        status = 0;
    }
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    ASIHTTPRequest * request = [WebService GetOrderListRestId:[[user valueForKey:KEY_CURR_RESTID] intValue] WaiterId:[[user valueForKey:KEY_CURR_USERID] intValue] Status:status];
    [request startAsynchronous];
    [request setStartedBlock:^{
    }];
    NSMutableData * reciveData = [NSMutableData dataWithCapacity:0];
    [request setDataReceivedBlock:^(NSData *data) {
        [reciveData appendData:data];
    }];
    [request setCompletionBlock:^{
        self.dataArr = (NSMutableArray *)[NSString ConverfromData:reciveData name:@"GetOrderList"];
        NSLog(@"00000000>>>  %@",self.dataArr);
    }];
    [request setFailedBlock:^{
        [MyActivceView stopAnimatedInView:self.view];
        [MyAlert ShowAlertMessage:@"加载失败！" title:@"提示"];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIderter = @"cellMark";
    OrderListCell * cell = (OrderListCell *)[tableView dequeueReusableCellWithIdentifier:cellIderter];
    if (cell == nil)
    {
        cell = [[OrderListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIderter];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString * orderNum = [[self.dataArr objectAtIndex:indexPath.row] valueForKey:@"OrderNum"];
    cell.L_number.text = [NSString stringWithFormat:@"%@",orderNum];
    cell.L_time.text = [[self.dataArr objectAtIndex:indexPath.row] valueForKey:@"AddTime"];
    cell.L_contact.text = [[self.dataArr objectAtIndex:indexPath.row] valueForKey:@"tel"];
    if (selectedSegmentIndex == 0)
    {
       
        cell.L_people.text = [NSString stringWithFormat:@"就餐人数：%@人",[[self.dataArr objectAtIndex:indexPath.row] valueForKey:@"peopleNum"]];
        cell.L_people.alpha = 1.0;
    }
    else
    {
        cell.L_people.alpha = 0.0;
    }
    
    NSString * tableNum = [[self.dataArr objectAtIndex:indexPath.row] valueForKey:@"TableNum"];
    if (selectedSegmentIndex == 1)
    {
         cell.L_tableNum.text = @"餐桌号:未分配";
    }
    else
    {
       cell.L_tableNum.text = [NSString stringWithFormat:@"餐桌号：%@",tableNum];
    }
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedSegmentIndex==0)
    {
        Checked_dishesViewController *checkedVC=[[Checked_dishesViewController alloc] init];
        checkedVC.checkedAry=[self.dataArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:checkedVC animated:YES];
    }else
    {
        Check_Order_DetailViewController *checkVC=[[Check_Order_DetailViewController alloc] init];
        checkVC.check_ary=[self.dataArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:checkVC animated:YES];
    }
    NSLog(@"%@",[self.dataArr objectAtIndex:indexPath.row]);
}

-(void)searchClick:(id)sender
{
    SearchViewController *searchVC=[[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

//-(IBAction)addClick:(id)sender
//{
//    AddDishesInfoViewController * add;
//    if (IPhone5)
//    {
//        add = [[AddDishesInfoViewController alloc] initWithNibName:@"AddDishesInfoViewController" bundle:nil];
//    }
//    else
//    {
//       add = [[AddDishesInfoViewController alloc] initWithNibName:@"AddDishesInfoViewController" bundle:nil];
//    }
//    [self.navigationController pushViewController:add animated:YES];
//}

-(IBAction)closeClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)segmentClick:(id)sender
{
 
    UIButton * tempBtn = (UIButton *)sender; 
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    if (tempBtn.tag == 1000)
    {
        self.checkYesBtn.backgroundColor = [UIColor grayColor];
        self.checkYesBtn.titleLabel.textColor = [UIColor whiteColor];
        self.checkNoBtn.backgroundColor = [UIColor whiteColor];
        self.checkNoBtn.titleLabel.textColor = [UIColor blackColor];
        selectedSegmentIndex = 0;
        self.Btn_search.alpha = 0.0;
        shuxianImage.hidden=YES;
        //self.line_imageView.alpha = 0.0;
    }
    else if (tempBtn.tag == 1001)
    {
        self.checkNoBtn.backgroundColor = [UIColor grayColor];
        [self.checkNoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.checkYesBtn.backgroundColor = [UIColor whiteColor];
        self.checkYesBtn.titleLabel.textColor = [UIColor blackColor];
        selectedSegmentIndex = 1;
        self.Btn_search.alpha = 1.0;
        shuxianImage.hidden=NO;
       // self.line_imageView.alpha = 1.0;
    }
    [UIView commitAnimations];
    [self getData];
}

#pragma mark Data Source Loading / Reloading Methods
//开始重新加载时调用的方法
- (void)reloadTableViewDataSource
{
    _reloading = YES;
    //开始刷新后执行后台线程，在此之前可以开启HUD或其他对UI进行阻塞
    [NSThread detachNewThreadSelector:@selector(doInBackground) toTarget:self withObject:nil];
}

//完成加载时调用的方法
- (void)doneLoadingTableViewData{
    NSLog(@"doneLoadingTableViewData");
    
    _reloading = NO;
    [_refreshTableView egoRefreshScrollViewDataSourceDidFinishedLoading:self.TV_tableview];
    //刷新表格内容
    //[self.TV_tableview reloadData];
}
#pragma mark Background operation
//这个方法运行于子线程中，完成获取刷新数据的操作
-(void)doInBackground
{
    NSLog(@"doInBackground");
    
//    NSArray *dataArray2 = [NSArray arrayWithObjects:@"Ryan2",@"Vivi2", nil];
//    self.dataArr = (NSMutableArray *)dataArray2;
  //  [self getData];
   sleep(1.5);
//    if (self.dataArr.count>0)
//    {
//        self.dataArr = nil;
//        self.dataArr = [NSMutableArray arrayWithCapacity:0];
//    }
//    
//    int status = 1;
//    if (selectedSegmentIndex == 0)
//    {
//        status = 1;
//    }
//    else
//    {
//        status = 0;
//    }
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    ASIHTTPRequest * request = [WebService GetOrderListRestId:[[user valueForKey:KEY_CURR_RESTID] intValue] WaiterId:[[user valueForKey:KEY_CURR_USERID] intValue] Status:status];
//    [request startAsynchronous];
//    [request setStartedBlock:^{
//    }];
//    NSMutableData * reciveData = [NSMutableData dataWithCapacity:0];
//    [request setDataReceivedBlock:^(NSData *data) {
//        [reciveData appendData:data];
//    }];
//    [request setCompletionBlock:^{
//        self.dataArr = (NSMutableArray *)[NSString ConverfromData:reciveData name:@"GetOrderList"];
         [self performSelectorOnMainThread:@selector(doneLoadingTableViewData) withObject:nil waitUntilDone:YES];
//    }];
//    [request setFailedBlock:^{
//        [MyAlert ShowAlertMessage:@"加载失败！" title:@"提示"];
//    }];
}
#pragma mark EGORefreshTableHeaderDelegate Methods
//下拉被触发调用的委托方法
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSource];
}

//返回当前是刷新还是无刷新状态
-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}

//返回刷新时间的回调方法
-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
//滚动控件的委托方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshTableView egoRefreshScrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_refreshTableView egoRefreshScrollViewDidEndDragging:scrollView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
