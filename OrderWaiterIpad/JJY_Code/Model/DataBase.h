//
//  DataBase.h
//  OrderMenu
//
//  Created by tiankong360 on 13-7-13.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface DataBase : NSObject
+(FMDatabase *)ShareDataBase;
+(NSMutableArray *)selectAllProduct;
+(NSMutableArray *)selectAllArrayProId;
+(NSString *)selectAllProId;
+(NSMutableArray *)selectNumberFromProId:(int)aProid;
+(void)deleteProID:(int)aProID;
+(void)UpdateDotNumber:(int)aProid currDotNumber:(double)aDotNumber;
+(void)insertProID:(int)aProID menuid:(int)aMenuId proName:(NSString *)aName price:(double)aPrice image:(NSString *)aImage andNumber:(double)aNumber typeID:(int)aTypeID typeName:(NSString *)aTypeName;
+(void)clearOrderMenu;
+(NSString *)selectNumber;
+(NSMutableArray *)SelectAllTypeNameAndTypeID;
+(NSMutableArray *)SelectProductByTypeID:(NSString *)aTypeID;
+(NSString *)SelectNumberByTypeName:(NSString *)aTypeName;
+(NSString *)SelectTypeIDByTypeName:(NSString *)aTypeName;


//将字符串转化成字典
+(NSArray *)ConverDictionaryFromString:(NSString *)aStr;
+(NSString *)ConverStringFromDictionary:(NSDictionary *)aDic;

@end
