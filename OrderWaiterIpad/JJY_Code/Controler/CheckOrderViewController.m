//
//  CheckOrderViewController.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-13.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "CheckOrderViewController.h"
#import "DCRoundSwitch.h"
#import <QuartzCore/QuartzCore.h>
#import "CheckCell.h"
#import "DataBase.h"
#import "FPPopoverController.h"
#import "PersonList.h"
#import "Detail_DishesViewController.h"
#import "AddMainViewController.h"


#import "MainViewController.h"
#define TYPE_NAME @"typename"
#define NUMBER @"number"
@interface CheckOrderViewController ()<UIAlertViewDelegate>
{
    int currClickId;
    NSMutableArray * arr_dotNumber;
    int currClassID;
    FPPopoverController *  popover;
    NSString *table_id;
    UIAlertView *alert5;
}
//@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) IBOutlet UILabel * L_price;
@property (nonatomic,strong) IBOutlet UITableView * TV_myTableview;
@property (nonatomic,strong) IBOutlet UIButton * Btn_sumbit;
@property (nonatomic,strong) IBOutlet UILabel * L_zoomDishes;
@property (nonatomic,strong) IBOutlet UITextField * TF_peopleNum;
@property (nonatomic,strong) IBOutlet UITextField * TF_tableNum;
@property (nonatomic,strong) NSMutableArray * arrStatus;
@property (nonatomic,strong) IBOutlet UILabel * L_people,* L_tableNum;
@property (nonatomic,strong) IBOutlet UIImageView * lineImageView;
-(IBAction)sumbitClick:(id)sender;
-(void)getData2;
-(void)getClassProduct:(UITapGestureRecognizer *)aTap;
-(void)changeNumber;
@end
@implementation CheckOrderViewController
@synthesize dataArr;
@synthesize TV_myTableview;
@synthesize Btn_sumbit;
@synthesize contact;
@synthesize mark;
@synthesize tableNum;
@synthesize L_price;
@synthesize L_zoomDishes;
@synthesize DC_mark;
@synthesize TF_peopleNum;
@synthesize TF_tableNum;
@synthesize arrStatus;
@synthesize isAddDishes;
@synthesize lineImageView,L_people,L_tableNum;
@synthesize orderId;
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
    self.navTitle.text = @"核对菜单";
    currClassID = 0;
    self.TF_tableNum.inputView = [[UIView alloc] init];
    self.TF_peopleNum.inputView = [[UIView alloc] init];
    
    self.Btn_sumbit.layer.borderColor = [UIColor grayColor].CGColor;
    self.Btn_sumbit.layer.borderWidth = 1.0;
    self.Btn_sumbit.layer.cornerRadius = 5.0;
    
    if (self.isAddDishes)
    {
        self.TF_peopleNum.hidden = YES;
        self.TF_tableNum.hidden = YES;
        self.lineImageView.hidden = YES;
        self.L_tableNum.hidden = YES;
        self.L_people.hidden = YES;
    }
    
    UIView *view1 =[ [UIView alloc]init];
    view1.backgroundColor = [UIColor clearColor];
    [self.TV_myTableview setTableFooterView:view1];
//    NSMutableArray * dataArr1 = [DataBase SelectAllTypeNameAndTypeID];
//    self.arrStatus = dataArr1;
//    UIScrollView * scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 1024, 44)];
//    scroll.bounces = NO;
//    scroll.maximumZoomScale = 1.0;
//    scroll.minimumZoomScale = 1.0;
//    scroll.backgroundColor = [UIColor grayColor];
//    
//    if (dataArr1.count<=4)
//    {
//        scroll.contentSize = CGSizeMake(1024, 44);
//    }
//    else
//    {
//        scroll.contentSize = CGSizeMake(dataArr1.count*256, 44);
//    }
//    
//    for (int i = 0; i<dataArr1.count; i++)
//    {
//        if (dataArr1.count>3)
//        {
//            UIView * bgView = [[UIView alloc] init];
//            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getClassProduct:)];
//            [bgView addGestureRecognizer:tap];
//            bgView.tag = 100+[[[dataArr1 objectAtIndex:i] valueForKey:@"typeID"] intValue];
//            if (i == 0)
//            {
//                bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"核对标题.png"]];
//            }
//            else
//            {
//                bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"核对标题1.png"]];
//            }
//            
//            bgView.frame = CGRectMake(i*256, 0, 256, 44);
//            
//            UILabel * lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
//            lable1.text = [[dataArr1 objectAtIndex:i] valueForKey:@"typeName"];
//            lable1.backgroundColor = [UIColor clearColor];
//            lable1.numberOfLines = 2;
//            lable1.font = [UIFont systemFontOfSize:15];
//            lable1.textAlignment = NSTextAlignmentCenter;
//            [bgView addSubview:lable1];
//            
//            DCRoundSwitch * swich = [[DCRoundSwitch alloc] initWithFrame:CGRectMake(150, 7, 90, 30)];
//            swich.tag = 1050+i;
//            swich.on = YES;
//            swich.onText = @"即起";
//            swich.offText = @"叫起";
//            swich.onTintColor = [UIColor colorWithRed:251.0/255.0 green:33.0/255.0 blue:47.0/255.0 alpha:1.0];
//            [bgView addSubview:swich];
//            [scroll addSubview:bgView];
//            if (self.isAddDishes)
//            {
//                swich.userInteractionEnabled = NO;
//            }
//        }
//        else
//        {
//            if (dataArr1.count == 1)
//            {
//                UIView * bgView = [[UIView alloc] init];
//                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getClassProduct:)];
//                [bgView addGestureRecognizer:tap];
//                bgView.tag = 100+[[[dataArr1 objectAtIndex:i] valueForKey:@"typeID"] intValue];
//                bgView.frame = CGRectMake(0, 0, 1024, 44);
//                bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"核对标题4.png"]];
//                
//                UILabel * lable1 = [[UILabel alloc] initWithFrame:CGRectMake(235, 0, 550, 44)];
//                lable1.text = [[dataArr1 objectAtIndex:i] valueForKey:@"typeName"];
//                lable1.backgroundColor = [UIColor clearColor];
//                lable1.numberOfLines = 2;
//                lable1.font = [UIFont systemFontOfSize:15];
//                lable1.textAlignment = NSTextAlignmentCenter;
//                [bgView addSubview:lable1];
//                
//                DCRoundSwitch * swich = [[DCRoundSwitch alloc] initWithFrame:CGRectMake(912, 7, 90, 30)];
//                swich.tag = 1050+i;
//                swich.on = YES;
//                swich.onText = @"即起";
//                swich.offText = @"叫起";
//                swich.onTintColor = [UIColor colorWithRed:251.0/255.0 green:33.0/255.0 blue:47.0/255.0 alpha:1.0];
//                [bgView addSubview:swich];
//                [scroll addSubview:bgView];
//                if (self.isAddDishes)
//                {
//                    swich.userInteractionEnabled = NO;
//                }
//            }
//            if (dataArr1.count == 2)
//            {
//                UIView * bgView = [[UIView alloc] init];
//                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getClassProduct:)];
//                [bgView addGestureRecognizer:tap];
//                bgView.tag = 100+[[[dataArr1 objectAtIndex:i] valueForKey:@"typeID"] intValue];
//                if (i == 0)
//                {
//                    bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"核对标题2.png"]];
//                }
//                else
//                {
//                    bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"核对标题2-1.png"]];
//                }
//                
//                bgView.frame = CGRectMake(i*512, 0, 512, 44);
//                UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(512, 0, 2, 44)];
//                lineImage.image = [UIImage imageNamed:@"审核标题线.png"];
//                [bgView addSubview:lineImage];
//                
//                
//                UILabel * lable1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 350, 44)];
//                lable1.text = [[dataArr1 objectAtIndex:i] valueForKey:@"typeName"];
//                lable1.backgroundColor = [UIColor clearColor];
//                lable1.numberOfLines = 2;
//                lable1.font = [UIFont systemFontOfSize:15];
//                lable1.textAlignment = NSTextAlignmentCenter;
//                [bgView addSubview:lable1];
//                
//                DCRoundSwitch * swich = [[DCRoundSwitch alloc] initWithFrame:CGRectMake(402,7, 90, 30)];
//                swich.tag = 1050+i;
//                swich.on = YES;
//                swich.onText = @"即起";
//                swich.offText = @"叫起";
//                swich.onTintColor = [UIColor colorWithRed:251.0/255.0 green:33.0/255.0 blue:47.0/255.0 alpha:1.0];
//                [bgView addSubview:swich];
//                [scroll addSubview:bgView];
//                if (self.isAddDishes)
//                {
//                    swich.userInteractionEnabled = NO;
//                }
//            }
//            if (dataArr1.count == 3)
//            {
//                UIView * bgView = [[UIView alloc] init];
//                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getClassProduct:)];
//                [bgView addGestureRecognizer:tap];
//                bgView.tag = 100+[[[dataArr1 objectAtIndex:i] valueForKey:@"typeID"] intValue];
//                bgView.frame = CGRectMake(i*341, 0, 341.5, 44);
//                if (i == 0)
//                {
//                    bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"核对标题3.png"]];
//                }
//                else
//                {
//                    bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"核对标题3-1.png"]];
//                }
//                UILabel * lable1 = [[UILabel alloc] initWithFrame:CGRectMake(95, 0, 150, 44)];
//                lable1.text = [[dataArr1 objectAtIndex:i] valueForKey:@"typeName"];
//                lable1.backgroundColor = [UIColor clearColor];
//                lable1.numberOfLines = 2;
//                lable1.font = [UIFont systemFontOfSize:15];
//                lable1.textAlignment = NSTextAlignmentCenter;
//                [bgView addSubview:lable1];
//                
//                DCRoundSwitch * swich = [[DCRoundSwitch alloc] initWithFrame:CGRectMake(230, 7, 90, 30)];
//                swich.tag = 1050+i;
//                swich.on = YES;
//                swich.onText = @"即起";
//                swich.offText = @"叫起";
//                swich.onTintColor = [UIColor colorWithRed:251.0/255.0 green:33.0/255.0 blue:47.0/255.0 alpha:1.0];
//                [bgView addSubview:swich];
//                [scroll addSubview:bgView];
//                if (self.isAddDishes)
//                {
//                    swich.userInteractionEnabled = NO;
//                }
//            }
//        }
//    }
//    [self.view addSubview:scroll];
//    arr_dotNumber = [NSMutableArray arrayWithCapacity:0];
//    //get number and name
//    for (int i = 0; i<dataArr1.count; i++)
//    {
//        NSDictionary * dic = [dataArr1 objectAtIndex:i];
//        NSMutableDictionary * dic1 = [NSMutableDictionary dictionaryWithCapacity:0];
//        [dic1 setValue:[dic valueForKey:@"typeName"] forKey:TYPE_NAME];
//        [dic1 setValue:[DataBase SelectNumberByTypeName:[dic valueForKey:@"typeName"]] forKey:NUMBER];
//        [arr_dotNumber addObject:dic1];
//    }
//    __block NSMutableString * tempStr = [NSMutableString stringWithFormat:@""];
//    __block NSString * temp;
//    [arr_dotNumber enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
//        temp = [NSString stringWithFormat:@"%@个%@,",[obj valueForKey:NUMBER],[obj valueForKey:TYPE_NAME]];
//        [tempStr appendString:temp];
//    }];
//    if (tempStr.length>0)
//    {
//        self.L_zoomDishes.text = [tempStr substringToIndex:tempStr.length-1];
//    }
    self.L_zoomDishes.text=[NSString stringWithFormat:@"共有%d个菜",[self.dataArr count]];
//    //load data
//    self.dataArr = [DataBase SelectProductByTypeID:[[dataArr1 objectAtIndex:0] valueForKey:@"typeID"]];
//    NSArray * arr = [DataBase selectAllProduct];
    __block double sum = 0;
    __block double sum2=0;
    __block int num = 0;
    [self.dataArr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
        sum += [[obj valueForKey:@"prices"] doubleValue]*[[obj valueForKey:@"number"] intValue];
        sum2 +=[[obj valueForKey:@"prices"] doubleValue];
        num += [[obj valueForKey:@"number"] intValue];
        self.L_price.text = [NSString stringWithFormat:@"%g元",sum2];
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popDismiss_table:) name:@"popoverVC_table" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popDismiss_person:) name:@"popoverVC_person" object:nil];
    self.DC_mark=[[NSMutableDictionary alloc] init];
}
-(void)getClassProduct:(UITapGestureRecognizer *)aTap
{
    
    UIView * dishesView = [aTap view];
    if (self.arrStatus.count == 2)
    {
        dishesView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"核对标题2.png"]];
        NSArray * arr = [[dishesView superview] subviews];
        __block UIView * tempView;
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIView class]])
            {
                tempView = (UIView *)obj;
                if (![obj isEqual:dishesView])
                {
                    tempView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"核对标题2-1.png"]];
                }
            }
        }];
    }
    if (self.arrStatus.count == 3)
    {
        dishesView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"核对标题3.png"]];
        NSArray * arr = [[dishesView superview] subviews];
        __block UIView * tempView;
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIView class]])
            {
                tempView = (UIView *)obj;
                if (![obj isEqual:dishesView])
                {
                    tempView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"核对标题3-1.png"]];
                }
            }
        }];
    }
    if (self.arrStatus.count > 3)
    {
        dishesView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"核对标题.png"]];
        NSArray * arr = [[dishesView superview] subviews];
        __block UIView * tempView;
        [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[UIView class]])
            {
                tempView = (UIView *)obj;
                if (![obj isEqual:dishesView])
                {
                    tempView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"核对标题1.png"]];
                }
            }
        }];
    }
    NSString * classID = [NSString stringWithFormat:@"%d",dishesView.tag-100];
    currClassID = [classID intValue];
    self.dataArr = [DataBase SelectProductByTypeID:classID];
    [self.TV_myTableview reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIderter = @"cellMark";
    CheckCell * cell = (CheckCell *)[tableView dequeueReusableCellWithIdentifier:cellIderter];
    if (cell == nil)
    {
        cell = [[CheckCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIderter andDotNumber:1];
    }
    cell.labName.numberOfLines = 2;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.labName.text = [[self.dataArr objectAtIndex:indexPath.row] valueForKey:@"ProName"];
    cell.labPrice.text =[NSString stringWithFormat:@"￥%@",[[self.dataArr objectAtIndex:indexPath.row] valueForKey:@"prices"]];
//    cell.ClickView.dotNumber = [[[self.dataArr objectAtIndex:indexPath.row] valueForKey:@"number"] intValue];
    cell.ClickView.dotNumber=1;
//    [cell.ClickView initView:[[[self.dataArr objectAtIndex:indexPath.row] valueForKey:@"number"] intValue]];
    [cell.ClickView initView:1];
    cell.ClickView.index = indexPath.row;
    [cell.ClickView.rightButton addTarget:self action:@selector(rightButtonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [cell.ClickView.leftButton addTarget:self action:@selector(leftButtonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    NSString * curridStr = [NSString stringWithFormat:@"%@",[[self.dataArr objectAtIndex:indexPath.row] valueForKey:@"ProID"]];
    NSString * content = [self.DC_mark valueForKey:curridStr];
   
    if (content.length>0)
    {
       cell.L_mark.text = [NSString stringWithFormat:@"备注:%@",content];
    }
    else
    {
      cell.L_mark.text = [NSString stringWithFormat:@"备注:无"];
    }
    
    cell.ClickView.leftButton.alpha = 0.0;
    cell.ClickView.rightButton.alpha = 0.0;
    
    
    [cell.btn_mark addTarget:self action:@selector(addMark:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn_mark.tag = [[[self.dataArr objectAtIndex:indexPath.row] valueForKey:@"ProID"] intValue]+1000;
    
    NSString * str = [self.DC_mark valueForKey:[[self.dataArr objectAtIndex:indexPath.row] valueForKey:@"ProID"]];
    if (str.length>0)
    {
        if (![str isEqualToString:@"(null)"])
        {
            [cell.btn_mark setBackgroundImage:[UIImage imageNamed:@"备注3.png"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.btn_mark setBackgroundImage:[UIImage imageNamed:@"备注.png"] forState:UIControlStateNormal];
        }
    }
    else
    {
        [cell.btn_mark setBackgroundImage:[UIImage imageNamed:@"备注.png"] forState:UIControlStateNormal];
    }
    return cell;
}
#pragma mark - 点菜触发事件
-(void)leftButtonClickEvent:(UIButton *)aButton
{

    CheckCell * cell = (CheckCell *)[[[aButton superview] superview] superview];
    NSDictionary * obj = [self.dataArr objectAtIndex:cell.ClickView.index];
    if (cell.ClickView.dotNumber == 0)
    {
        NSString * str = [obj valueForKey:@"ProID"];
        if (str.length != 0)
        {
            [DataBase deleteProID:[[obj valueForKey:@"ProID"] intValue]];
            [self.DC_mark setValue:@"" forKey:str];
            NSLog(@"self.dc_mark = %@", [self.DC_mark valueForKey:str]);
            if (self.dataArr.count>0)
            {
                self.dataArr = nil;
                self.dataArr = [DataBase SelectProductByTypeID:[NSString stringWithFormat:@"%d",currClassID]];
                [self.TV_myTableview reloadData];
            }
            else
            {
                self.dataArr = [DataBase SelectProductByTypeID:[NSString stringWithFormat:@"%d",currClassID]];
                [self.TV_myTableview reloadData];
            }
        }
    }
    else
    {
        [DataBase UpdateDotNumber:[[obj valueForKey:@"ProID"] intValue] currDotNumber:cell.ClickView.dotNumber];
    }
    [self changeNumber];
    [self getData2];
}
-(void)rightButtonClickEvent:(UIButton *)aButton
{
    CheckCell * cell = (CheckCell *)[[[aButton superview] superview] superview];
    NSDictionary * obj = [self.dataArr objectAtIndex:cell.ClickView.index];
    [DataBase UpdateDotNumber:[[obj valueForKey:@"ProID"] intValue] currDotNumber:cell.ClickView.dotNumber];
    [self changeNumber];
    [self getData2];
}

-(void)getData2
{
    NSMutableArray * arr = [DataBase selectAllProduct];
    __block double sum = 0;
    __block int num = 0;
    [arr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
        sum += [[obj valueForKey:@"prices"] doubleValue]*[[obj valueForKey:@"number"] intValue];
        num += [[obj valueForKey:@"number"] intValue];
        self.L_price.text = [NSString stringWithFormat:@"%g元",sum];
    }];
}


-(IBAction)sumbitClick:(id)sender
{
    if (!isAddDishes)
    {
        if (self.TF_peopleNum.text.length==0 || self.TF_tableNum.text.length==0)
        {
            [MyAlert ShowAlertMessage:@"餐桌号或者人数不能为空！" title:@""];
        }
        else
        {
            [self.TF_peopleNum resignFirstResponder];
            [self.TF_tableNum resignFirstResponder];
            
            NSMutableString *muStar=[[NSMutableString alloc] init];
            NSMutableString *muStarNum=[[NSMutableString alloc] init];
            NSMutableArray  *arr_id=[[NSMutableArray alloc] init];
            for (int p=0; p<self.dataArr.count; p++)
            {
                NSString * curridStr = [NSString stringWithFormat:@"%@,",[[self.dataArr objectAtIndex:p] valueForKey:@"ProID"]];
                [muStar appendString:curridStr];
                NSString * curridStr2 = [NSString stringWithFormat:@"%@,",@"1"];
                [muStarNum appendString:curridStr2];
                [arr_id addObject:[[self.dataArr objectAtIndex:p] valueForKey:@"ProID"]];
            }
            NSString * proidStr = [muStar substringWithRange:NSMakeRange(0, muStar.length-1)];
            NSString * copiesStr = [muStarNum substringWithRange:NSMakeRange(0, muStarNum.length-1)];
            NSLog(@"-- po=%@,cop=%@",proidStr,copiesStr);
//            NSString * proidStr = [DataBase selectAllProId];
//            NSString * copiesStr = [DataBase selectNumber];
            //mark
//            NSMutableArray * arr_id = [DataBase selectAllArrayProId];
            
            NSMutableString * str_mutable = [NSMutableString stringWithFormat:@""];
            __block NSString * tempStr;
            [arr_id enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
                tempStr = [NSString stringWithFormat:@"%@",[self.DC_mark valueForKey:[NSString stringWithFormat:@"%@",obj]]];
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
            NSMutableArray * tempArr = [NSMutableArray arrayWithCapacity:0];
//            for (int i = 0; i<self.arrStatus.count; i++)
//            {
//                DCRoundSwitch * swich = (DCRoundSwitch *)[self.view viewWithTag:1050+i];
//                NSString * str = [NSString stringWithFormat:@"%d",swich.on];
//                [tempArr addObject:str];
//            }
            
//            __block NSMutableString * class_status = [NSMutableString stringWithFormat:@""];
//            [self.arrStatus enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
//                ;
//                [class_status appendFormat:@"%@,%@;",[obj valueForKey:@"typeID"],[tempArr objectAtIndex:idx]];
//            }];
//            NSString * statusSTr = [class_status substringToIndex:class_status.length-1];
//            NSLog(@"status=%@",statusSTr);
            NSLog(@"restid = %@,tableid = %@,mark = %@,copies = %@,proid = %@,userid = %@,eatnu = %d,status = %@",[[NSUserDefaults standardUserDefaults] valueForKey:KEY_CURR_RESTID],table_id,[str_mutable substringToIndex:str_mutable.length-1],copiesStr,proidStr,[[NSUserDefaults standardUserDefaults] valueForKey:KEY_CURR_USERID],[self.TF_peopleNum.text intValue],copiesStr);
            ASIHTTPRequest * request = [WebService AddOrderRestId:[[[NSUserDefaults standardUserDefaults] valueForKey:KEY_CURR_RESTID] intValue] tel:self.contact tableId:table_id mark:[str_mutable substringToIndex:str_mutable.length-1] proid:proidStr copies:copiesStr userID:[[[NSUserDefaults standardUserDefaults] valueForKey:KEY_CURR_USERID] intValue] statue:copiesStr eatNumber:[self.TF_peopleNum.text intValue]];
            [request startAsynchronous];
            [request setStartedBlock:^{
                [MyActivceView startAnimatedInView:self.view];
            }];
            NSMutableData * reciveData = [NSMutableData dataWithCapacity:0];
            [request setDataReceivedBlock:^(NSData *data) {
                [reciveData appendData:data];
            }];
            __block UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"提交成功！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alert.tag = 5555;

           
            
            [request setCompletionBlock:^{
                [MyActivceView stopAnimatedInView:self.view];
                NSString * result = [NSString ConverStringfromData:reciveData name:@"SubmitOrder"];
                NSLog(@"result = %@",[[NSString alloc] initWithData:reciveData encoding:4]);
                if ([result isEqualToString:@"1"])
                {    
                    [alert show];
                    [DataBase clearOrderMenu];
                    [self.DC_mark removeAllObjects];
                    
                    for (UIViewController * viewController in self.navigationController.viewControllers)
                    {
                        if ([viewController isKindOfClass:[MainViewController class]])
                        {
                            [self.navigationController popToViewController:viewController animated:YES];
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
    }
    else
    {
        [self.TF_peopleNum resignFirstResponder];
        [self.TF_tableNum resignFirstResponder];
        
        NSString * proidStr = [DataBase selectAllProId];
        NSString * copiesStr = [DataBase selectNumber];
        //mark
        NSMutableArray * arr_id = [DataBase selectAllArrayProId];
        NSMutableString * str_mutable = [NSMutableString stringWithFormat:@""];
        __block NSString * tempStr;
        [arr_id enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
            tempStr = [NSString stringWithFormat:@"%@",[self.DC_mark valueForKey:[NSString stringWithFormat:@"%@",obj]]];
            if ([tempStr isEqualToString:@"(null)"])
            {
                [str_mutable appendString:@","];
            }
            else
            {
                [str_mutable appendFormat:@"%@,",tempStr];
            }
        }];
        NSLog(@"%d:%d:%@:%@:%@",[[[NSUserDefaults standardUserDefaults] valueForKey:KEY_CURR_RESTID] intValue],self.orderId,proidStr,[str_mutable substringToIndex:str_mutable.length-1],copiesStr);
        ASIHTTPRequest * request = [WebService AddishesRestID:[[[NSUserDefaults standardUserDefaults] valueForKey:KEY_CURR_RESTID] intValue] OrderID:self.orderId proid:proidStr mark:[str_mutable substringToIndex:str_mutable.length-1] copies:copiesStr andTableId:[NSString stringWithFormat:@"%d",self.tableNum]];
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
            NSString * result = [NSString ConverStringfromData:reciveData name:@"addOrderinfo"];
            
            
            if ([result isEqualToString:@"1"])
            {
                [DataBase clearOrderMenu];
                alert5 = [[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"提交成功！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                alert5.tag=1234;
                [alert5 show];
                [self.DC_mark removeAllObjects];
                
//                AddMainViewController * addMain = [[AddMainViewController alloc] init];
//                [self.navigationController pushViewController:addMain animated:YES];
                
                for (UIViewController * viewController in self.navigationController.viewControllers)
                {
                    if ([viewController isKindOfClass:[Detail_DishesViewController class]])
                    {
                        [self.navigationController popToViewController:viewController animated:YES];
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
}
-(void)addMark:(UIButton *)aButton
{
    currClickId = aButton.tag-1000;
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"备注" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    [alert show];
//    CheckCell * cell =  (CheckCell *)[[aButton superview] superview];
//    if (cell.ClickView.dotNumber>0)
//    {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"备注" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        alert.alertViewStyle=UIAlertViewStylePlainTextInput;
//        [alert show];
//    }
//    else
//    {
//        [MyAlert ShowAlertMessage:@"您还未点此菜！" title:@"提示"];
//    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"000-=== %d",buttonIndex);
    if (alertView.tag==5555)
    {
        NSLog(@"111111111111111111");
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    if (alertView.tag==1234)
    {
        NSLog(@"0..0.0.0.0.0..0000000......0000000");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    if (alertView.tag == 1023)
    {
        for (UIViewController *controller in self.navigationController.viewControllers)
        {
            if ([controller isKindOfClass:[Detail_DishesViewController class]])
            {
                [DataBase clearOrderMenu];
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }
    else
    {
        UITextField *TF_mark=[alertView textFieldAtIndex:0];
       
        if (buttonIndex==1)
        {
            if (TF_mark.text.length>0)
            {
                [self.DC_mark setValue:TF_mark.text forKey:[NSString stringWithFormat:@"%d",currClickId]];
                UIButton * markBtn = (UIButton *)[self.view viewWithTag:1000+currClickId];
                [markBtn setImage:[UIImage imageNamed:@"备注3.png"] forState:UIControlStateNormal];
            }
            else
            {
                [self.DC_mark setValue:TF_mark.text forKey:[NSString stringWithFormat:@"%d",currClickId]];
                UIButton * markBtn = (UIButton *)[self.view viewWithTag:1000+currClickId];
                [markBtn setImage:[UIImage imageNamed:@"备注.png"] forState:UIControlStateNormal];
            }
            [self.TV_myTableview reloadData];
             NSLog(@"-=-=-=-- %@",self.DC_mark);
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
//-(void)backBtn_click
//{
//    for (UIViewController * controller in self.navigationController.viewControllers)
//    {
//        if ([controller isKindOfClass:[Detail_DishesViewController class]])
//        {
//            Detail_DishesViewController * controller1 = (Detail_DishesViewController *)controller;
//           // [controller1.DC_mark removeAllObjects];
//            //[self.DC_mark removeAllObjects];
//            [self.navigationController popToViewController:controller1 animated:YES];
//            break;
//        }
//    }
//}
-(void)changeNumber
{
    NSMutableArray * dataArr1 = [DataBase SelectAllTypeNameAndTypeID];
    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
    //get number and name
    for (int i = 0; i<dataArr1.count; i++)
    {
        NSDictionary * dic = [dataArr1 objectAtIndex:i];
        NSMutableDictionary * dic1 = [NSMutableDictionary dictionaryWithCapacity:0];
        [dic1 setValue:[dic valueForKey:@"typeName"] forKey:TYPE_NAME];
        [dic1 setValue:[DataBase SelectNumberByTypeName:[dic valueForKey:@"typeName"]] forKey:NUMBER];
        [arr addObject:dic1];
    }
    __block NSMutableString * tempStr = [NSMutableString stringWithFormat:@""];
    __block NSString * temp;
    [arr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL *stop) {
        temp = [NSString stringWithFormat:@"%@个%@,",[obj valueForKey:NUMBER],[obj valueForKey:TYPE_NAME]];
        [tempStr appendString:temp];
    }];
    self.L_zoomDishes.text = [tempStr substringToIndex:tempStr.length-1];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 201)
    {
        PersonList *controller = [[PersonList alloc] initWithStyle:UITableViewStylePlain];
        controller.aryID=0000;
        popover = [[FPPopoverController alloc] initWithViewController:controller];
        //popover.arrowDirection = FPPopoverArrowDirectionAny;
        popover.tint = FPPopoverDefaultTint;
        popover.contentSize = CGSizeMake(150, 500);
        popover.arrowDirection = FPPopoverArrowDirectionAny;
        //sender is the UIButton view
        [popover presentPopoverFromView:textField];
        
    }
    else
    {
        PersonList *controller = [[PersonList alloc] initWithStyle:UITableViewStylePlain];
        controller.aryID=1111;
        popover = [[FPPopoverController alloc] initWithViewController:controller];
        popover.tint = FPPopoverDefaultTint;
        popover.contentSize = CGSizeMake(150, 500);
        popover.arrowDirection = FPPopoverArrowDirectionAny;
        [popover presentPopoverFromView:textField];
    }
}
- (void)popDismiss_table:(NSNotification *)aNotification
{
    NSDictionary * dic = aNotification.userInfo;
    self.TF_tableNum.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"tableId"]];
    table_id=[NSString stringWithFormat:@"%@",[dic objectForKey:@"table_Id"]];
    [popover dismissPopoverAnimated:YES];
    
}
- (void)popDismiss_person:(NSNotification *)aNotification
{
    NSDictionary * dic = aNotification.userInfo;
    self.TF_peopleNum.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"personId"]];
    [popover dismissPopoverAnimated:YES];
    
}
- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
    [visiblePopoverController dismissPopoverAnimated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.TF_peopleNum resignFirstResponder];
    [self.TF_tableNum resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
