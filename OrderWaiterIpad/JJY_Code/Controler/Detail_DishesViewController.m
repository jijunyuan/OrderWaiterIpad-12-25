//
//  Detail_DishesViewController.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-11.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "Detail_DishesViewController.h"
#import "DishesClassCell.h"
#import "DishesDetailListCell.h"
#import "ASIHTTPRequest.h"
#import "WebService.h"
#import "NSString+JsonString.h"
#import "DataBase.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>
#import "CheckOrderViewController.h"
#import "OrderListViewController.h"
@interface Detail_DishesViewController ()<UIAlertViewDelegate>
{
    int selectRow;
    BOOL isFirst;
    NSURL * tempUrl;
    UIImageView * bgView;
    UIImageView * imageView;
    int currClickId;
}
@property (nonatomic,strong) IBOutlet UITableView * TV_left;
@property (nonatomic,strong) IBOutlet UITableView * TV_right;
@property (nonatomic,strong) NSArray * myClassArr;
@property (nonatomic,strong) NSMutableArray * myProArr;
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) NSMutableArray * id_arr;
@property (nonatomic,strong)IBOutlet UITableView * classTableView;
@property (nonatomic,strong)IBOutlet UITableView * productTableView;
@property (nonatomic,strong) NSMutableDictionary * tempClassDic;
@property (nonatomic,strong) NSMutableDictionary * tempDotNumberDic;
-(void)yesClick:(id)sender;
-(void)scanBigImage:(UITapGestureRecognizer *)aTap;
-(void)cancleBigImage:(UITapGestureRecognizer *)aTap;
-(void)addMark:(UIButton *)aButton;
@end
@implementation Detail_DishesViewController
@synthesize TV_left;
@synthesize TV_right;
@synthesize myClassArr;
@synthesize myProArr;
@synthesize dataArr;
@synthesize id_arr;
@synthesize classTableView;
@synthesize productTableView;
@synthesize tempClassDic;
@synthesize tempDotNumberDic;
@synthesize DC_mark;
@synthesize sumbit_order;
@synthesize lineImg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    self.tempClassDic = [NSMutableDictionary dictionaryWithCapacity:0];
    self.tempDotNumberDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    selectRow = 0;
    
    self.id_arr = [NSMutableArray arrayWithCapacity:0];
    self.classTableView.bounces = NO;
    self.productTableView.bounces = NO;
    self.productTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.classTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getClassData];
    selectRow = 0;
    NSLog(@"self.dic = %@",self.DC_mark);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.DC_mark = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"注销.png"] forState:UIControlStateNormal];
    
    UIButton * btn_mange = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sumbit_order = btn_mange;
    btn_mange.showsTouchWhenHighlighted = YES;
    btn_mange.frame = CGRectMake(804, 0, 110, 44);
    [btn_mange setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_mange setTitle:@"订单管理" forState:UIControlStateNormal];
    //[btn_mange setBackgroundImage:[UIImage imageNamed:@"按钮.png"] forState:UIControlStateNormal];
    btn_mange.backgroundColor = [UIColor clearColor];
    [btn_mange addTarget:self action:@selector(yesClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:btn_mange];
    
    UIImageView * line = [[UIImageView alloc] initWithFrame:CGRectMake(914, 0, 2, 44)];
    line.image = [UIImage imageNamed:@"标题线.png"];
    [self.bgImageView addSubview:line];
    
    UIImageView * line1 = [[UIImageView alloc] initWithFrame:CGRectMake(803, 0, 2, 44)];
    self.lineImg = line1;
    line1.image = [UIImage imageNamed:@"标题线.png"];
    [self.bgImageView addSubview:line1];

    
    UIButton * YesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    YesBtn.showsTouchWhenHighlighted = YES;
    YesBtn.frame = CGRectMake(914, 0, 110, 44);
    [YesBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [YesBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    YesBtn.backgroundColor = [UIColor clearColor];
    [YesBtn addTarget:self action:@selector(yesClick1:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgImageView addSubview:YesBtn];
    
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(462, 5, 100, 34)];
    title.font = [UIFont systemFontOfSize:20];
    title.text = @"菜单列表";
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    [self.view addSubview:title];
}

#pragma mark - get data
-(void)getClassData
{
    //self.resultID
    ASIHTTPRequest * request = [WebService classInterfaceConfig:[[[NSUserDefaults standardUserDefaults] valueForKey:KEY_CURR_RESTID] intValue]];
    [request startAsynchronous];
    NSMutableData * reciveData = [NSMutableData dataWithCapacity:0];
    [request setStartedBlock:^{
        self.classTableView.alpha = 0.0;
        [MyActivceView startAnimatedInView:self.view];
    }];
    [request setDataReceivedBlock:^(NSData *data) {
        [reciveData appendData:data];
    }];
    [request setCompletionBlock:^{
        self.classTableView.alpha = 1.0;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.myClassArr = (NSMutableArray *)[NSString ConverfromData:reciveData name:CLASS_NAME];
            [self.myClassArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if (idx == 0)
                {
                    [self.tempClassDic setValue:@"1" forKey:[NSString stringWithFormat:@"%d",idx]];
                }
                else
                {
                    [self.tempClassDic setValue:@"0" forKey:[NSString stringWithFormat:@"%d",idx]];
                }
            }];
            self.dataArr = [DataBase selectAllProduct];
            [self.classTableView reloadData];
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
   __weak  ASIHTTPRequest * request = [WebService ProductListConfig:aClassid];
    [request startAsynchronous];
    NSMutableData * reciveData1 = [NSMutableData dataWithCapacity:0];
    [request setStartedBlock:^{
        self.productTableView.alpha = 0.0;
    }];
    [request setDataReceivedBlock:^(NSData *data) {
        [reciveData1 appendData:data];
    }];
    [request setCompletionBlock:^{
        self.productTableView.alpha = 1.0;
        [MyActivceView stopAnimatedInView:self.view];
        self.myProArr = [NSMutableArray arrayWithArray:[NSString ConverfromData:reciveData1 name:PRODUCT_NAME]];
        if (isFirst)
        {
            isFirst = NO;
            [self.myProArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self.tempDotNumberDic setValue:@"0" forKey:[[self.myProArr objectAtIndex:idx] valueForKey:@"ProID"]];
            }];
        }
        self.dataArr = [DataBase selectAllProduct];
        
        [self.dataArr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
            [self.tempDotNumberDic setValue:[obj valueForKey:@"number"] forKey:[obj valueForKey:@"ProID"]];
        }];
        [request cancel];
        [self.productTableView reloadData];
    }];
    [request setFailedBlock:^{
        [request cancel];
        [MyActivceView stopAnimatedInView:self.view];
        [MyAlert ShowAlertMessage:@"网速不给力！" title:@"请求超时"];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 101)
    {
        return 132;
    }
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100)
    {
        return self.myClassArr.count;
    }
    return self.myProArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100)
    {
        static NSString * strMark = @"cellMark";
        DishesClassCell * cell = [tableView dequeueReusableCellWithIdentifier:strMark];
        if (cell == nil)
        {
            cell = [[DishesClassCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strMark];
        }
        if (self.tempClassDic.count>0)
        {
            NSString * result = [self.tempClassDic valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
            if ([result isEqualToString:@"1"])
            {
                cell.backgroundImageView.image = [UIImage imageNamed:@"选项2.png"];
            }
            else
            {
                cell.backgroundImageView.image = [UIImage imageNamed:@"选项.png"];
            }
        }
        cell.textContentLab.text = [[self.myClassArr objectAtIndex:indexPath.row] valueForKey:@"ClassName"];
        cell.textContentLab.textColor = [UIColor blackColor];
        return cell;
    }
    
    NSString *str1 = [NSString stringWithFormat:@"cellmark%d",selectRow];
    NSString * strMark1 = str1; //不同类别用不同的重用标示符，目的是为了不同分类同一位置的重用现象。
    DishesDetailListCell * cell1 = [tableView dequeueReusableCellWithIdentifier:strMark1];
    __block int dotNumber = 0;
    if (indexPath.row < self.myProArr.count)
    {
        __block NSString * proID;
        NSString * currID = [[self.myProArr objectAtIndex:indexPath.row] valueForKey:@"ProID"];
        [self.dataArr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
            proID = [obj valueForKey:@"ProID"];
            if ([currID isEqualToString:proID])
            {
                dotNumber = [[[[DataBase selectNumberFromProId:[currID intValue]] objectAtIndex:0] valueForKey:@"number"] intValue];
            }
        }];
    }
    if (cell1 == nil)
    {
        cell1 = [[DishesDetailListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strMark1 andDotNumber:dotNumber];
    }
    int resylt = [[self.tempDotNumberDic valueForKey:[[self.myProArr objectAtIndex:indexPath.row] valueForKey:@"ProID"]] intValue];
    if (resylt == 0)
    {
        [cell1.dishView zeroState];
    }
    else
    {
        [cell1.dishView initView:resylt];
    }
    
    if (indexPath.row%2 == 0)
    {
        cell1.backgroundImageView.image = [UIImage imageNamed:@"展示.png"];
    }
    else
    {
        cell1.backgroundImageView.image = [UIImage imageNamed:@"展示.png"];
    }
    cell1.selectionStyle=UITableViewCellSelectionStyleNone;
    
    //判断是否有已经推荐过的菜系
    cell1.titleLab.text = [[self.myProArr objectAtIndex:indexPath.row] valueForKey:@"ProName"];
    NSString * str = @"￥";
    NSString * priceStr = [[self.myProArr objectAtIndex:indexPath.row] valueForKey:@"prices"];
    cell1.priceLab.text = [str stringByAppendingFormat:@"%@",priceStr];
    
    cell1.dishView.price = [priceStr doubleValue];
    cell1.dishView.index = indexPath.row;
    
    [cell1.dishView.rightButton addTarget:self action:@selector(rightButtonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [cell1.dishView.leftButton addTarget:self action:@selector(leftButtonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [cell1.dishView.bigButton addTarget:self action:@selector(bigButtonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImage:)];
    cell1.leftImageView.userInteractionEnabled = YES;
    [cell1.leftImageView addGestureRecognizer:tap];
    
    NSString * pathURL = ALL_URL;
    NSURL * url = [NSURL URLWithString:[pathURL stringByAppendingFormat:@"%@",[[self.myProArr objectAtIndex:indexPath.row] valueForKey:@"ProductImg"]]];
    tempUrl = url;
    [cell1.leftImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:ALL_NO_IMAGE]];
    
    [cell1.btn_mark addTarget:self action:@selector(addMark:) forControlEvents:UIControlEventTouchUpInside];
    cell1.btn_mark.tag = [[[self.myProArr objectAtIndex:indexPath.row] valueForKey:@"ProID"] intValue]+1000;
    if (self.DC_mark.allKeys.count>0)
    {
        NSString * str2 = [self.DC_mark valueForKey:[[self.myProArr objectAtIndex:indexPath.row] valueForKey:@"ProID"]];
        if (str2.length>0)
        {
            [cell1.btn_mark setBackgroundImage:[UIImage imageNamed:@"备注3.png"] forState:UIControlStateNormal];
        }
        else
        {
            [cell1.btn_mark setBackgroundImage:[UIImage imageNamed:@"备注.png"] forState:UIControlStateNormal];
         }
     }
    else
    {
      [cell1.btn_mark setBackgroundImage:[UIImage imageNamed:@"备注.png"] forState:UIControlStateNormal];
    }
    return cell1;
}

#pragma mark - 点菜触发事件
-(void)leftButtonClickEvent:(UIButton *)aButton
{
    DishesDetailListCell * cell = (DishesDetailListCell *)[[[aButton superview] superview] superview];
    NSDictionary * obj = [self.myProArr objectAtIndex:cell.dishView.index];
    if (cell.dishView.dotNumber == 0)
    {
        [DataBase deleteProID:[[obj valueForKey:@"ProID"] intValue]];
        [self.DC_mark setValue:@"" forKey:[obj valueForKey:@"ProID"]];
        [cell.btn_mark setBackgroundImage:[UIImage imageNamed:@"备注.png"] forState:UIControlStateNormal];
    }
    else
    {
        [DataBase UpdateDotNumber:[[obj valueForKey:@"ProID"] intValue] currDotNumber:cell.dishView.dotNumber];
    }
    
    [self.tempDotNumberDic setValue:[NSString stringWithFormat:@"%d",cell.dishView.dotNumber] forKey:[obj valueForKey:@"ProID"]];
}
-(void)rightButtonClickEvent:(UIButton *)aButton
{
    DishesDetailListCell * cell = (DishesDetailListCell *)[[[aButton superview] superview] superview];
    NSDictionary * obj = [self.myProArr objectAtIndex:cell.dishView.index];
    [DataBase UpdateDotNumber:[[obj valueForKey:@"ProID"] intValue] currDotNumber:cell.dishView.dotNumber];
    
    [self.tempDotNumberDic setValue:[NSString stringWithFormat:@"%d",cell.dishView.dotNumber] forKey:[obj valueForKey:@"ProID"]];
}
-(void)bigButtonClickEvent:(UIButton *)aButton
{
    NSLog(@"%@",[[[[aButton superview] superview] superview]  subviews]);
    DishesDetailListCell * cell = (DishesDetailListCell *)[[[aButton superview] superview] superview];
    if ([cell.dishView isKindOfClass:[DishClickView class]])
    {
        NSDictionary * obj = [self.myProArr objectAtIndex:cell.dishView.index];
        NSLog(@"obj = %@",obj);
        [DataBase insertProID:[[obj valueForKey:@"ProID"] intValue] menuid:[[obj valueForKey:@"Menuid"] intValue] proName:[obj valueForKey:@"ProName"] price:[[obj valueForKey:@"prices"] doubleValue] image:[obj valueForKey:@"ProductImg"] andNumber:1 typeID:[[obj valueForKey:@"TypeId"] intValue] typeName:[obj valueForKey:@"TypeName"]];
        [self.tempDotNumberDic setValue:[NSString stringWithFormat:@"%d",cell.dishView.dotNumber] forKey:[obj valueForKey:@"ProID"]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 100)
    {
        selectRow = indexPath.row;
        [self.myClassArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (idx == indexPath.row)
            {
                [self.tempClassDic setValue:@"1" forKey:[NSString stringWithFormat:@"%d",idx]];
            }
            else
            {
                [self.tempClassDic setValue:@"0" forKey:[NSString stringWithFormat:@"%d",idx]];
            }
            [self.classTableView reloadData];
        }];
        
        if (self.myProArr.count > 0)
        {
            [self.myProArr removeAllObjects];
        }
        NSString * classid = [[self.myClassArr objectAtIndex:indexPath.row] valueForKey:@"classID"];
        [self getProductData:classid];
    }
}
-(void)yesClick:(id)sender
{
    [DataBase clearOrderMenu];
    OrderListViewController * order = [[OrderListViewController alloc] init];
    [self.navigationController pushViewController:order animated:YES];
}
-(void)yesClick1:(id)sender
{
    NSArray * tempArr = [DataBase selectAllProduct];
    if (tempArr.count>0)
    {
        CheckOrderViewController * check = [[CheckOrderViewController alloc] initWithNibName:@"CheckOrderViewController" bundle:nil];
        check.DC_mark = self.DC_mark;
        [self.navigationController pushViewController:check animated:YES];
    }
    else
    {
        [MyAlert ShowAlertMessage:@"您还没有进行点菜！" title:@""];
    }
}
-(void)addMark:(UIButton *)aButton
{
    currClickId = aButton.tag-1000;
    DishesDetailListCell * cell =  (DishesDetailListCell *)[[aButton superview] superview];
    if (cell.dishView.dotNumber>0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"备注" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle=UIAlertViewStylePlainTextInput;
        [alert show];
    }
    else
    {
        [MyAlert ShowAlertMessage:@"您还未点此菜！" title:@"提示"];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *TF_mark=[alertView textFieldAtIndex:0];
    if (buttonIndex==1)
    {
        if (TF_mark.text.length>0)
        {
            [self.DC_mark setValue:TF_mark.text forKey:[NSString stringWithFormat:@"%d",currClickId]];
            UIButton * markBtn = (UIButton *)[self.view viewWithTag:1000+currClickId];
           [markBtn setBackgroundImage:[UIImage imageNamed:@"备注3.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.DC_mark setValue:TF_mark.text forKey:[NSString stringWithFormat:@"%d",currClickId]];
            UIButton * markBtn = (UIButton *)[self.view viewWithTag:1000+currClickId];
            [markBtn setBackgroundImage:[UIImage imageNamed:@"备注.png"] forState:UIControlStateNormal];
        }
    }
}
- (void)willPresentAlertView:(UIAlertView *)alertView
{
    NSString * curridStr = [NSString stringWithFormat:@"%d",currClickId];
    NSString * content = [self.DC_mark valueForKey:curridStr];
    UITextField *TF_mark1=[alertView textFieldAtIndex:0];
    TF_mark1.text = content;
}

-(void)scanBigImage:(UITapGestureRecognizer *)aTap
{
    
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [bgView setImage:[UIImage imageNamed:@"bigImage.png"]];
    bgView.userInteractionEnabled = YES;
    bgView.alpha = 0.6;
    bgView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bgView];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(180, 130, 664, 508)];
    imageView.alpha = 1.0;
    imageView.userInteractionEnabled = YES;
    [imageView setImageWithURL:tempUrl placeholderImage:[UIImage imageNamed:ALL_NO_IMAGE]];
    [self.view addSubview:imageView];
    
    UITapGestureRecognizer * cancleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleBigImage:)];
    [bgView addGestureRecognizer:cancleTap];
    [imageView addGestureRecognizer:cancleTap];
    [self.view addGestureRecognizer:cancleTap];
    
}
-(void)cancleBigImage:(UITapGestureRecognizer *)aTap
{
    [UIView animateWithDuration:0.5 animations:^{
        bgView.alpha = 0.0;
        imageView.alpha = 0.0;
    } completion:^(BOOL finished) {
            [bgView removeFromSuperview];
            [imageView removeFromSuperview];
    }];
}

-(void)backBtn_click
{
    [DataBase clearOrderMenu];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
