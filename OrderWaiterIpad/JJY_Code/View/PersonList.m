//
//  PersonList.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-13.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "PersonList.h"
#import "TKHttpRequest.h"
@interface PersonList ()
@property (nonatomic,strong) NSMutableDictionary * tableDic;
@end
@implementation PersonList
@synthesize PersonArray,tableNumAry;
@synthesize aryID;
@synthesize tableDic;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableDic removeAllObjects];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsMultipleSelection = YES;
    self.tableDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    PersonArray =[[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
    [self projectList];
    

}
#pragma mark ---asihttp request
-(void)projectList
{
    [MyActivceView startAnimatedInView:self.view];
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl: @"http://192.168.1.100:8082/luban/OM_Interface/Waiter.asmx?op=GetTableList"];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <GetTableList xmlns=\"http://tempuri.org/\">\
                       <RestId>%d</RestId>\
                       </GetTableList>\
                       </soap:Body>\
                       </soap:Envelope>",[[user objectForKey:KEY_CURR_RESTID] intValue]];
    [request addRequestHeader:@"Host" value:@"interface.hcgjzs.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/GetTableList"];
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
    NSArray *Ary=[NSString ConverfromData:request.responseData name:@"GetTableList"];
    self.tableNumAry=Ary;
    NSLog(@"ary %@",Ary);
    [self.tableView reloadData];
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    [MyActivceView stopAnimatedInView:self.view];
   // [MyAlert ShowAlertMessage:@"网速不给力啊!" title:@"温馨提醒"];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.aryID==0000)
    {
        return [PersonArray count];
    }
    return [tableNumAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
 	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   // cell.accessoryType=UITableViewCellAccessoryCheckmark;
    if (self.aryID==0000)
    {
        cell.textLabel.text=[self.PersonArray objectAtIndex:indexPath.row];
        return cell;
    }
    cell.textLabel.text=[[self.tableNumAry objectAtIndex:indexPath.row] valueForKey:@"Title"];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.aryID==0000)
    {
        NSDictionary *dic;
        dic=[NSDictionary dictionaryWithObjectsAndKeys:[self.PersonArray objectAtIndex:indexPath.row],@"personId",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"popoverVC_person" object:nil userInfo:dic];
    }else
    {
      //  dic=[NSDictionary dictionaryWithObjectsAndKeys:[[self.tableNumAry objectAtIndex:indexPath.row] valueForKey:@"Title"],@"tableId",[[self.tableNumAry objectAtIndex:indexPath.row] valueForKey:@"Id"],@"table_Id",nil];
        NSLog(@"----%@++++%@",self.tableNumAry,[[self.tableNumAry objectAtIndex:indexPath.row] valueForKey:@"Title"]);
        
        NSString * tableid = [NSString stringWithFormat:@"%@",[[self.tableNumAry objectAtIndex:indexPath.row] valueForKey:@"Id"]];
        NSArray * allkeys = [self.tableDic allKeys];
        __block BOOL isHave = NO;
        [allkeys enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
            if ([tableid isEqualToString:obj])
            {
                isHave = YES;
                *stop = YES;
            }
            else
            {
                isHave = NO;
            }
        }];
        if (isHave)
        {
            [self.tableDic removeObjectForKey:tableid];
        }
        else
        {
            [self.tableDic setValue:[[self.tableNumAry objectAtIndex:indexPath.row] valueForKey:@"Title"] forKey:[[self.tableNumAry objectAtIndex:indexPath.row] valueForKey:@"Id"]];
        }
        NSLog(@"=======%@",self.tableDic);
       [[NSNotificationCenter defaultCenter] postNotificationName:@"popoverVC_table" object:nil userInfo:self.tableDic];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableDic removeObjectForKey:[[self.tableNumAry objectAtIndex:indexPath.row] valueForKey:@"Id"]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popoverVC_table" object:nil userInfo:self.tableDic];
    NSLog(@"=======%@",self.tableDic);
}

@end
