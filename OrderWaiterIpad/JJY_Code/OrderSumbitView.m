//
//  OrderSumbitView.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-18.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "OrderSumbitView.h"
#import "RADataObject.h"
#import "FirstModeCell.h"
#import "SecondModeCell.h"
#import "ThirdModeCell.h"

#define CUEE_CLICK @"curr_click"

@interface OrderSumbitView()<RATreeViewDataSource,RATreeViewDelegate,ThirdModelCellDelegate,FirstModeCellDelegate>
{
    NSUserDefaults * userRecodCurr;
    NSMutableArray * arrayItems;
}
@end

static  NSString * tempName;

@implementation OrderSumbitView
@synthesize extendArr,dataArr;
@synthesize raTreeView;

- (id)initWithFrame:(CGRect)frame andDataArr:(NSMutableArray *)aArr
{
    self = [super initWithFrame:frame];
    if (self)
    {
        arrayItems = [NSMutableArray arrayWithCapacity:0];
        userRecodCurr = [NSUserDefaults standardUserDefaults];
        self.dataArr = aArr;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(20, 0);
        
        RATreeView *treeView = [[RATreeView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:RATreeViewStylePlain];
       
        self.raTreeView = treeView;
        treeView.treeFooterView = [[UIView alloc] init];
        treeView.delegate = self;
        treeView.dataSource = self;
        treeView.separatorStyle = RATreeViewCellSeparatorStyleSingleLine;
        [treeView reloadData];
        if (self.extendArr.count>0)
        {
            [treeView expandRowForItem:self.extendArr withRowAnimation:RATreeViewRowAnimationLeft]; //expands Row
        }
        [treeView setBackgroundColor:UIColorFromRGB(0xF7F7F7)];
        [self addSubview:treeView];
    }
    return self;
}
- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    if (item == nil)
    {
        return [self.dataArr count];
    }
    RADataObject *data = item;
    return [data.children count];
}

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    
    if (treeNodeInfo.treeDepthLevel == 0)
    {
        NSArray * arr = [DataBase ConverDictionaryFromString:((RADataObject *)item).name];
        NSString * strTemp1 = [arr lastObject];
        BOOL isOn = NO;
        if ([strTemp1 isEqualToString:@"1"])
        {
            isOn = YES;
        }
        else
        {
            isOn = NO;
        }
        FirstModeCell * cell = [[FirstModeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil andISOn:isOn];
        cell.delegate = self;
        cell.L_title.text = [arr objectAtIndex:0];
        return cell;
    }
    
    if (treeNodeInfo.treeDepthLevel == 1)
    {
        [arrayItems addObject:item];
        //id  name  price  number  typeid typename  mark
        SecondModeCell *cell = [[SecondModeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        NSArray * arr = [DataBase ConverDictionaryFromString:((RADataObject *)item).name];
        cell.L_name.text = [arr objectAtIndex:1];
        cell.L_price.text = [NSString stringWithFormat:@"￥%@",[arr objectAtIndex:2]];
        cell.L_number.text = [NSString stringWithFormat:@"%@份",[arr objectAtIndex:3]];
        return cell;
    }
    if (treeNodeInfo.treeDepthLevel == 2)
    {
        NSArray * arr = [DataBase ConverDictionaryFromString:((RADataObject *)item).name];
        ThirdModeCell * cell = [[ThirdModeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil andDotNumber:[[arr objectAtIndex:3] doubleValue] andMarkvalue:[arr lastObject]];
        cell.delegate = self;
        cell.proId = [NSString stringWithFormat:@"%@",[arr objectAtIndex:0]];
        
        RADataObject * object1 = (RADataObject *)item;
        [userRecodCurr setValue:object1.name forKey:CUEE_CLICK];
        [userRecodCurr synchronize];
        return cell;
    }
    return nil;
}
- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    RADataObject *data = item;
    if (item == nil)
    {
        return [self.dataArr objectAtIndex:index];
    }
    return [data.children objectAtIndex:index];
}
- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return 44;
}
- (NSInteger)treeView:(RATreeView *)treeView indentationLevelForRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return 2 * treeNodeInfo.treeDepthLevel;
}
- (void)treeView:(RATreeView *)treeView willDisplayCell:(UITableViewCell *)cell forItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    if (treeNodeInfo.treeDepthLevel == 0)
    {
        cell.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];
    }
    else if (treeNodeInfo.treeDepthLevel == 1)
    {
        cell.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    }
    else if (treeNodeInfo.treeDepthLevel == 2)
    {
        cell.backgroundColor = [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0];
    }
}
- (BOOL)treeView:(RATreeView *)treeView shouldCollapaseRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    if (treeNodeInfo.treeDepthLevel == 1)
    {
        RADataObject * object1 = (RADataObject *)item;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:object1.name];
    }
    return YES;
}
- (BOOL)treeView:(RATreeView *)treeView shouldExpandRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    
    if (treeNodeInfo.treeDepthLevel == 1)
    {
        [arrayItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (![item isEqual:obj])
            {
                [treeView collapseRowForItem:obj withRowAnimation:RATreeViewRowAnimationBottom];
            }
        }];
    }
    return YES;
}
- (BOOL)treeView:(RATreeView *)treeView shouldItemBeExpandedAfterDataReload:(id)item treeDepthLevel:(NSInteger)treeDepthLevel
{
    if (treeDepthLevel == 0)
    {
        return YES;
    }
    if (treeDepthLevel == 1)
    {
        RADataObject * object1 = (RADataObject *)item;
        NSString * curr1 = [NSString stringWithFormat:@"%@",[userRecodCurr valueForKey:CUEE_CLICK]];
        NSString * currStr = @"";
        if (curr1.length>1)
        {
            NSRange range = [curr1 rangeOfString:@","];
            if (range.length>0)
            {
                NSString * tempSTr4 = [curr1 substringToIndex:curr1.length-1];
                currStr = [[DataBase ConverDictionaryFromString:tempSTr4] objectAtIndex:0];
            }
            else
            {
                currStr = curr1;
            }
           
            NSLog(@"\n%@\n%@",[[DataBase ConverDictionaryFromString:object1.name] objectAtIndex:0],currStr);
        }
        else
        {
            currStr = @"";
        }
        if ([[[DataBase ConverDictionaryFromString:object1.name] objectAtIndex:0] isEqualToString:currStr])
        {
            NSLog(@"yes");
            return YES;
        }
        else
        {
             NSLog(@"no");
            return NO;
        }
    }
    return NO;
}

- (BOOL)treeView:(RATreeView *)treeView canEditRowForItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return NO;
}

- (BOOL)treeView:(RATreeView *)treeView shouldExpandItem:(id)item treeNodeInfo:(RATreeNodeInfo *)treeNodeInfo
{
    return YES;
}
-(void)ThirdModelCell:(ThirdModeCell *)thirdCell andleftDotNumber:(double)aDotNumber andProid:(NSString *)aProid
{
    [self.delegate OrderSumbitView:self andLeftDotNumber:aDotNumber andProid:aProid andThirdCell:thirdCell];
}
-(void)ThirdModelCell:(ThirdModeCell *)thirdCell andrightDotNumber:(double)aDotNumber andProid:(NSString *)aProid
{
   
    [self.delegate OrderSumbitView:self andRightDotNumber:aDotNumber andProid:aProid andThirdCell:thirdCell];
}
#pragma mark - first cell delegate
-(void)FirstModelCell:(FirstModeCell *)aFirstCell andTypeName:(NSString *)aName andIsOn:(BOOL)aIsOn
{
    [self.delegate OrderSumbitView:self andFirstCell:aFirstCell andTypeName:aName andIson:aIsOn];
}
@end
