//
//  ViewController.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-11.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "ViewController.h"
#import "Detail_DishesViewController.h"
#import "MGSplitViewController.h"
#import "MainViewController.h"

@interface ViewController ()
@end
@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor grayColor];
    self.backBtn.hidden=YES;
    self.navImage.hidden=YES;
    UIImageView *bgImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    bgImage.image=[UIImage imageNamed:@"登录bg.png"];
    [self.view addSubview:bgImage];
    UIImageView  *dengluImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 534, 385)];
    dengluImage.image=[UIImage imageNamed:@"登录.png"];
    dengluImage.center=CGPointMake(self.view.bounds.size.height/2, self.view.bounds.size.width/2);
    [self.view addSubview:dengluImage];
    nameTF=[[UITextField alloc] initWithFrame:CGRectMake(325, 288, 400, 30)];
    nameTF.borderStyle=UITextBorderStyleNone;
    nameTF.backgroundColor=[UIColor clearColor];
    [self.view addSubview:nameTF];
    keyTF=[[UITextField alloc] initWithFrame:CGRectMake(325, 353, 400, 30)];
    keyTF.borderStyle=UITextBorderStyleNone;
    keyTF.secureTextEntry = YES;
    keyTF.backgroundColor=[UIColor clearColor];
    keyTF.delegate=self;
    keyTF.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:keyTF];
    remindBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    remindBtn.frame=CGRectMake(288, 416, 29, 29);
    [remindBtn setImage:[UIImage imageNamed:@"登录忘记2.png"]forState:UIControlStateNormal];
    [remindBtn addTarget:self action:@selector(remeberBtn_click) forControlEvents:UIControlEventTouchUpInside];
    i=1;
    [self.view addSubview:remindBtn];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(288, 471, 430, 40);
    btn.showsTouchWhenHighlighted=YES;
    [btn addTarget:self action:@selector(log_in) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)remeberBtn_click
{
    if (i==1)
    {
        i=0;
    }
    else if(i==0)
    {
        i=1;
    }
    [remindBtn setImage:i==1?[UIImage imageNamed:@"登录忘记2.png"]:[UIImage imageNamed:@"登录忘记1.png"] forState:UIControlStateNormal];
}
-(void)log_in
{
    if ([nameTF.text isEqualToString:@""]||[keyTF.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"用户名或密码不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [self nameKeyRequest];
    }

}

-(void)nameKeyRequest
{
    [MyActivceView startAnimatedInView:self.view];
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl: @"http://192.168.1.100:8082/luban/OM_Interface/Waiter.asmx?op=WaiterLogin"];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <WaiterLogin xmlns=\"http://tempuri.org/\">\
                       <UserName>%@</UserName>\
                       <Password>%@</Password>\
                       </WaiterLogin>\
                       </soap:Body>\
                       </soap:Envelope>",nameTF.text,keyTF.text];
    [request addRequestHeader:@"Host" value:@"interface.hcgjzs.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/WaiterLogin"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    request.delegate=self;
    [request startAsynchronous];
}
#pragma mark - asihttprequest
- (void)requestStarted:(ASIHTTPRequest *)request
{
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"%@",request.responseString);
    [MyActivceView stopAnimatedInView:self.view];
    NSArray *keyAry=[NSString ConverfromData:request.responseData name:@"WaiterLogin"];
    NSString *keyStr=[keyAry  valueForKey:@"Result"];
    
    if ([keyStr intValue]==0)
    {
        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"温馨提醒" message:@"用户名或密码输入有误，请重新输入！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([keyStr intValue]==1)
    {
//        Detail_DishesViewController *detailDishesVC=[[Detail_DishesViewController alloc] initWithNibName:@"Detail_DishesViewController" bundle:nil];
//        [self.navigationController pushViewController:detailDishesVC animated:YES];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setValue:[keyAry valueForKey:@"RestId"] forKey:KEY_CURR_RESTID];
        [user setValue:[keyAry valueForKey:@"UserId"] forKey:KEY_CURR_USERID];
        [user synchronize];
        NSLog(@" %@,%@",[user objectForKey:KEY_CURR_USERID],[user objectForKey:KEY_CURR_RESTID]);
        
        MainViewController * mainViewController = [[MainViewController alloc] init];
        [self.navigationController pushViewController:mainViewController animated:YES];
        
    }
    [[NSUserDefaults standardUserDefaults] setObject:nameTF.text forKey:@"nameTF"];
    [[NSUserDefaults standardUserDefaults] setObject:keyTF.text forKey:@"keyTF"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MyActivceView stopAnimatedInView:self.view];
    [MyAlert ShowAlertMessage:@"亲，网速不给力啊!" title:@"温馨提醒"];
}
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults  *userDefaults = [NSUserDefaults standardUserDefaults];
    if (i==0)
    {
        keyTF.text=nil;
        [userDefaults removeObjectForKey:@"keyTF"];
        
    }
    else
    {
        nameTF.text = [userDefaults objectForKey:@"nameTF"];
        keyTF.text = [userDefaults objectForKey:@"keyTF"];
    }
    [super viewWillAppear:animated];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"])
        
    {
        [textField resignFirstResponder];
        return NO;
        
    }
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [nameTF resignFirstResponder];
    [keyTF  resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
