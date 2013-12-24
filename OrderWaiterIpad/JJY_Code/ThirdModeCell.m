//
//  ThirdModeCell.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-18.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "ThirdModeCell.h"
#import "MarkButton.h"

#define MARK_NOTIFICATION @"mark_notification"
#define CUEE_CLICK @"curr_click"

@interface ThirdModeCell()<UIAlertViewDelegate>
{
    MarkButton * tempMarkButton;
}
-(void)buttonClick:(MarkButton *)aButton;
@end

@implementation ThirdModeCell
@synthesize markBtn;
@synthesize dishView;
@synthesize dotNumber;
@synthesize proId;
@synthesize markValue;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDotNumber:(double)aDotNum andMarkvalue:(NSString *)aValue
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.markValue = aValue;
        self.dotNumber = aDotNum;
        self.backgroundColor = [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0];
        //添加加减菜按钮
        ChangeDishView * dishview1 = [[ChangeDishView alloc] initWithFrame:CGRectMake(10, 2, 136, 40) andIsRedButton:YES andDotNumber:self.dotNumber];
        dishview1.delegate = self;
        self.dishView = dishview1;
        [self addSubview:dishview1];
        
        //添加备注按钮
        MarkButton * button1 = [MarkButton buttonWithType:UIButtonTypeCustom];
        [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button1.clipsToBounds = YES;
        if (aValue.length>0)
        {
         [button1 setImage:[UIImage imageNamed:@"marked.png"] forState:UIControlStateNormal];   
        }
        else
        {
         [button1 setImage:[UIImage imageNamed:@"mark.png"] forState:UIControlStateNormal];
        }
        
        button1.frame = CGRectMake(250, 7, 100, 30);
        [self addSubview:button1];
    }
    return self;
}

-(void)buttonClick:(MarkButton *)aButton
{
    tempMarkButton = aButton;
    
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"请输入备注" message:Nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    if (self.markValue.length>0)
    {
        UITextField * textfield = (UITextField *)[alert textFieldAtIndex:0];
        textfield.text = self.markValue;
    }
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField * textfield = (UITextField *)[alertView textFieldAtIndex:0];
    textfield.clearsOnBeginEditing = YES;
    if (buttonIndex == 0)
    {
        tempMarkButton.isMark = NO;
        textfield.text = @"";
        [tempMarkButton setImage:[UIImage imageNamed:@"mark.png"] forState:UIControlStateNormal];
        NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:0];
        [dict setValue:textfield.text forKey:@"mark1"];
        [dict setValue:self.proId forKey:@"proid1"];
        [[NSNotificationCenter defaultCenter] postNotificationName:MARK_NOTIFICATION object:self userInfo:dict];
    }
    else
    {
        if (textfield.text.length>0)
        {
            tempMarkButton.isMark = YES;
            [tempMarkButton setImage:[UIImage imageNamed:@"marked.png"] forState:UIControlStateNormal];
            NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithCapacity:0];
            [dict setValue:textfield.text forKey:@"mark1"];
            [dict setValue:self.proId forKey:@"proid1"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:MARK_NOTIFICATION object:self userInfo:dict];
        }
        else
        {
           UIAlertView * alert1 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入备注内容!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert1 show];
        }
       
    }
}
-(void)ChangeDishView:(ChangeDishView *)aChangeDishView andLeftDotNumber:(double)aDotNumber andPreDotNumber:(double)aPreDotNumber
{
    NSUserDefaults * user1 = [NSUserDefaults standardUserDefaults];
    [user1 setValue:self.proId forKey:CUEE_CLICK];
    [user1 synchronize];
    [self.delegate ThirdModelCell:self andleftDotNumber:aDotNumber andProid:self.proId];
}
-(void)ChangeDishView:(ChangeDishView *)aChangeDishView andRightDotNumber:(double)aDotNumber andPreDotNumber:(double)aPreDotNumber
{
    NSUserDefaults * user1 = [NSUserDefaults standardUserDefaults];
    [user1 setValue:self.proId forKey:CUEE_CLICK];
    [user1 synchronize];
    [self.delegate ThirdModelCell:self andrightDotNumber:aDotNumber andProid:self.proId];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
