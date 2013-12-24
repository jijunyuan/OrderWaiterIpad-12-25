//
//  PersonList.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-13.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PersonList : UITableViewController
{
    NSArray *PersonArray;
    NSArray *tableNumAry;
    int     aryID;
    
}
@property(nonatomic,retain)NSArray *PersonArray,*tableNumAry;
@property(nonatomic,assign)int     aryID;
@end
