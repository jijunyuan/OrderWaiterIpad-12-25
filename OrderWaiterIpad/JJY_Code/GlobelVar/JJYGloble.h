//
//  JJYGloble.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-12.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#ifndef OrderWaiterIpad_JJYGloble_h
#define OrderWaiterIpad_JJYGloble_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define KEY_REMBERPWD @"remberpassword"
#define KEY_NAME @"keyname"
#define KEY_PWD @"keypassword"

#define KEY_CURR_USERID @"userid_curr"
#define KEY_CURR_RESTID @"restid_curr"

//http://192.168.1.100:8082/luban
//http://192.168.1.100:8082/luban

#define ROOT_URL @"http://192.168.1.100:8082/luban/"
#import "MyActivceView.h"
#import "MyAlert.h"
#import "NSString+JsonString.h"
#import "ASIHTTPRequest.h"
#import "WebService.h"
#import "UIColor+ConverHTML.h"
#import "DataBase.h"

#define ALL_URL @"http://interface.hcgjzs.com"
#define CLASS_URL @"http://192.168.1.100:8082/luban/OM_Interface/Cuisines.asmx"
#define CLASS_NAME @"GetList"  //获取某一餐馆的菜系分类列表
#define PRODUCT_URL @"http://192.168.1.100:8082/luban/OM_Interface/Product.asmx"
#define PRODUCT_NAME @"ProductList"  //根据分类id，获取对应id的菜列表
#define ALL_NO_IMAGE @"Icon.png"

#define LOGIN_IN @"http://192.168.1.100:8082/luban/OM_Interface/Waiter.asmx?op=WaiterLogin"
#define GET_ORDER_LIST @"http://192.168.1.100:8082/luban/OM_Interface/Waiter.asmx?op=GetOrderList"
#define SEARCH_ORDER_LIST @"http://192.168.1.100:8082/luban/OM_Interface/Waiter.asmx?op=GetOrderForSearch"
#define GET_DOT_DISHES_LIST @"http://192.168.1.100:8082/luban/OM_Interface/Order.asmx?op=GetProductList"
#define CHECK_ORDER @"http://192.168.1.100:8082/luban/OM_Interface/Waiter.asmx?op=AuditOrderInfo"
#define GET_TABLE_LIST @"http://192.168.1.100:8082/luban/OM_Interface/Waiter.asmx?op=GetTableList"
#define ADD_ORDER @"http://192.168.1.100:8082/luban/OM_Interface/OrderInterface.asmx?op=SubmitOrder"
#define EDIT_ORDER @"http://192.168.1.100:8082/luban/OM_Interface/Waiter.asmx?op=EditOrderInfo"
#define EDIT_TABLE @"http://192.168.1.100:8082/luban/OM_Interface/Waiter.asmx?op=EditTableNum"
#define ADD_DISHES @"http://192.168.1.100:8082/luban/OM_Interface/OrderInterface.asmx?op=addOrderinfo"

#endif
