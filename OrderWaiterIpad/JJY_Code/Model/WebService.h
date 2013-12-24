//
//  WebService.h
//  OrderMenu
//
//  Created by tiankong360 on 13-7-17.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
@interface WebService : NSObject

+(BOOL)ISIOS7;


+(ASIHTTPRequest *)classInterfaceConfig:(int)aResultID;
+(ASIHTTPRequest *)ProductListConfig:(NSString *)aClassId;
+(ASIHTTPRequest *)LoginIn:(NSString *)aUserName andPWD:(NSString *)aPwd;
+(ASIHTTPRequest *)GetOrderListRestId:(int)aRestId WaiterId:(int)aWaiterId Status:(int)aStatus;
+(ASIHTTPRequest *)SearchOrderListRestId:(int)aRestId andKey:(NSString *)aKey;
+(ASIHTTPRequest *)GetDishesListByOrderId:(int)aOrderId;
+(ASIHTTPRequest *)CheckOrderByOrderId:(int)aOrderId andTableId:(int)aTableId waiteId:(int)aWaiterId;
+(ASIHTTPRequest *)GetTableList:(int)aRestId;
+(ASIHTTPRequest *)AddOrderRestId:(int)aRestId tel:(NSString *)aTel tableId:(int)aTableId mark:(NSString *)aMark proid:(NSString *)aProId copies:(NSString *)aCopies userID:(int)aUserID statue:(NSString *)aStatue eatNumber:(int)aNumber;
+(ASIHTTPRequest *)EditOrderId:(int)aOrderId idStr:(NSString *)aIdStr copies:(NSString *)aCopies;
+(ASIHTTPRequest *)EditTableOrderId:(int)aOrderId tableId:(int)aTableId oldTableID:(int)aOldTableId;
+(ASIHTTPRequest *)AddishesRestID:(int)aRestID OrderID:(int)aOrderId proid:(NSString *)aProid mark:(NSString *)aMark copies:(NSString *)aCopies;
@end
