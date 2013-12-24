//
//  WebService.m
//  OrderMenu
//
//  Created by tiankong360 on 13-7-17.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "WebService.h"
#import "TKHttpRequest.h"
@implementation WebService

+(BOOL)ISIOS7
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    if (_deviceSystemMajorVersion >= 7)
    {
        return YES;
    }
    return NO;
}


+(ASIHTTPRequest *)classInterfaceConfig:(int)aResultID
{
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl:CLASS_URL];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <GetList xmlns=\"http://tempuri.org/\">\
                       <id>%d</id>\
                       </GetList>\
                       </soap:Body>\
                       </soap:Envelope>",aResultID];
    [request addRequestHeader:@"Host" value:@"interface.hcgjzs.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/GetList"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    return request;
}
#pragma mark - 获取分类下面对应的菜列表
+(ASIHTTPRequest *)ProductListConfig:(NSString *)aClassId
{
    NSLog(@"aClassId = %@",aClassId);
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl:PRODUCT_URL];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <ProductList xmlns=\"http://tempuri.org/\">\
                       <id>%d</id>\
                       </ProductList>\
                       </soap:Body>\
                       </soap:Envelope>",[aClassId intValue]];
    [request addRequestHeader:@"Host" value:@"interface.hcgjzs.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/ProductList"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    return request;
}

#pragma mark - 登陆
+(ASIHTTPRequest *)LoginIn:(NSString *)aUserName andPWD:(NSString *)aPwd
{
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl:LOGIN_IN];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <WaiterLogin xmlns=\"http://tempuri.org/\">\
                       <UserName>%@</UserName>\
                       <Password>%@</Password>\
                       </WaiterLogin>\
                       </soap:Body>\
                       </soap:Envelope>",aUserName,aPwd];
    [request addRequestHeader:@"Host" value:@"interface.hcgjzs.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/WaiterLogin"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    return request;
}

#pragma mark - 获取订单列表
+(ASIHTTPRequest *)GetOrderListRestId:(int)aRestId WaiterId:(int)aWaiterId Status:(int)aStatus
{
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl:GET_ORDER_LIST];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <GetOrderList xmlns=\"http://tempuri.org/\">\
                       <RestId>%d</RestId>\
                       <WaiterId>%d</WaiterId>\
                       <Status>%d</Status>\
                       </GetOrderList>\
                       </soap:Body>\
                       </soap:Envelope>",aRestId,aWaiterId,aStatus];
    [request addRequestHeader:@"Host" value:@"interface.hcgjzs.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/GetOrderList"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    return request;
}
#pragma mark - 查询订单列表
+(ASIHTTPRequest *)SearchOrderListRestId:(int)aRestId andKey:(NSString *)aKey
{
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl:SEARCH_ORDER_LIST];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <GetOrderForSearch xmlns=\"http://tempuri.org/\">\
                       <RestId>%d</RestId>\
                       <Key>%@</Key>\
                       </GetOrderForSearch>\
                       </soap:Body>\
                       </soap:Envelope>",aRestId,aKey];
    [request addRequestHeader:@"Host" value:@"interface.hcgjzs.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/GetOrderForSearch"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    return request;
}

#pragma mark - 获取某一订单下所点菜列表
+(ASIHTTPRequest *)GetDishesListByOrderId:(int)aOrderId
{
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl:GET_DOT_DISHES_LIST];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <GetProductList xmlns=\"http://tempuri.org/\">\
                       <id>%d</id>\
                       </GetProductList>\
                       </soap:Body>\
                       </soap:Envelope>",aOrderId];
    [request addRequestHeader:@"Host" value:@"interface.hcgjzs.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/GetProductList"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    return request;
}
#pragma mark - 审核订单
+(ASIHTTPRequest *)CheckOrderByOrderId:(int)aOrderId andTableId:(int)aTableId waiteId:(int)aWaiterId
{
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl:CHECK_ORDER];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <AuditOrderInfo xmlns=\"http://tempuri.org/\">\
                       <OrderId>%d</OrderId>\
                       <TableId>%d</TableId>\
                        <WaiterId>%d</WaiterId>\
                       </AuditOrderInfo>\
                       </soap:Body>\
                       </soap:Envelope>",aOrderId,aTableId,aWaiterId];
    [request addRequestHeader:@"Host" value:@"interface.hcgjzs.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/AuditOrderInfo"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    return request;
}
#pragma mark - 获取餐桌列表
+(ASIHTTPRequest *)GetTableList:(int)aRestId
{
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl:GET_TABLE_LIST];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <GetTableList xmlns=\"http://tempuri.org/\">\
                      <RestId>%d</RestId>\
                       </GetTableList>\
                       </soap:Body>\
                       </soap:Envelope>",aRestId];
    [request addRequestHeader:@"Host" value:@"interface.hcgjzs.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/GetTableList"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    return request;
}

#pragma mark - 添加订单
+(ASIHTTPRequest *)AddOrderRestId:(int)aRestId tel:(NSString *)aTel tableId:(int)aTableId mark:(NSString *)aMark proid:(NSString *)aProId copies:(NSString *)aCopies userID:(int)aUserID statue:(NSString *)aStatue eatNumber:(int)aNumber
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [NSDate date];
    NSString * dateStr = [formatter stringFromDate:date];
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl:ADD_ORDER];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <SubmitOrder xmlns=\"http://tempuri.org/\">\
                       <UserId>%d</UserId>\
                       <RestId>%d</RestId>\
                       <TableId>%d</TableId>\
                       <Time>%@</Time>\
                       <PeopleNum>%d</PeopleNum>\
                       <IdStr>%@</IdStr>\
                       <CopiesSt>%@</CopiesSt>\
                       <DishesMark>%@</DishesMark>\
                       <Statue>%@</Statue>\
                       </SubmitOrder>\
                       </soap:Body>\
                       </soap:Envelope>",aUserID,aRestId,aTableId,dateStr,aNumber,aProId,aCopies,aMark,aStatue];
    [request addRequestHeader:@"Host" value:@"interface.hcgjzs.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/SubmitOrder"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    return request;
}

#pragma mark - 添加订单
+(ASIHTTPRequest *)EditOrderId:(int)aOrderId idStr:(NSString *)aIdStr copies:(NSString *)aCopies
{
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl:ADD_ORDER];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <EditOrderInfo xmlns=\"http://tempuri.org/\">\
                       <orderid>%d</orderid>\
                       <idlist>%@</idlist>\
                       <copies>%@</copies>\
                       </EditOrderInfo>\
                       </soap:Body>\
                       </soap:Envelope>",aOrderId,aIdStr,aCopies];
    [request addRequestHeader:@"Host" value:@"interface.hcgjzs.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/EditOrderInfo"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    return request;
}

#pragma mark - 换桌
+(ASIHTTPRequest *)EditTableOrderId:(int)aOrderId tableId:(int)aTableId oldTableID:(int)aOldTableId
{
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl:ADD_ORDER];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <EditTableNum xmlns=\"http://tempuri.org/\">\
                       <OrderId>%d</OrderId>\
                       <TableId>%d</TableId>\
                       <OldTableiId>%d</OldTableiId>\
                       </EditTableNum>\
                       </soap:Body>\
                       </soap:Envelope>",aOrderId,aTableId,aOldTableId];
    [request addRequestHeader:@"Host" value:@"interface.hcgjzs.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/EditTableNum"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    return request;
}

+(ASIHTTPRequest *)AddishesRestID:(int)aRestID OrderID:(int)aOrderId proid:(NSString *)aProid mark:(NSString *)aMark copies:(NSString *)aCopies
{
    ASIHTTPRequest *request=[TKHttpRequest RequestTKUrl:ADD_DISHES];
    NSString *postStr=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                       <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\
                       <soap:Body>\
                       <addOrderinfo xmlns=\"http://tempuri.org/\">\
                       <RestId>%d</RestId>\
                       <OrderId>%d</OrderId>\
                       <ProId>%@</ProId>\
                       <Mark>%@</Mark>\
                       <Copies>%@</Copies>\
                       </addOrderinfo>\
                       </soap:Body>\
                       </soap:Envelope>",aRestID,aOrderId,aProid,aMark,aCopies];
    [request addRequestHeader:@"Host" value:@"interface.hcgjzs.com"];
    [request addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",postStr.length]];
    [request addRequestHeader:@"SOAPAction" value:@"http://tempuri.org/addOrderinfo"];
    [request setPostBody:(NSMutableData *)[postStr dataUsingEncoding:4]];
    return request;
}

@end
