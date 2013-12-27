//
//  ChangeDishView.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-17.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "ChangeDishView.h"

@interface ChangeDishView()
{
    double preDotNumber;
}

-(void)leftButton:(UIButton *)aButton;
-(void)rightButton:(UIButton *)aButton;
@end

@implementation ChangeDishView
@synthesize leftButton,rightButton,middleLab,dotNumber;
@synthesize delegate;
@synthesize isOrderButton;

- (id)initWithFrame:(CGRect)frame andIsRedButton:(BOOL)isRed
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (self.dotNumber>0)
        {
            ;
        }
        else
        {
            self.dotNumber = 0;
        }
        
        self.isOrderButton = isRed;
        
        //添加左边button
        UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton = leftBtn;
        if (self.isOrderButton)
        {
            [leftBtn setImage:[UIImage imageNamed:@"redM.png"] forState:UIControlStateNormal];
        }
        else
        {
          [leftBtn setImage:[UIImage imageNamed:@"greyM.png"] forState:UIControlStateNormal];
        }
       
        leftBtn.frame = CGRectMake(0, 0, 40, 40);
        [leftBtn addTarget:self action:@selector(leftButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        
        //添加右边button
        UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton = rightBtn;
        if (self.isOrderButton)
        {
            [rightBtn setImage:[UIImage imageNamed:@"redA.png"] forState:UIControlStateNormal];
        }
        else
        {
            [rightBtn setImage:[UIImage imageNamed:@"grayA"] forState:UIControlStateNormal];
        }
        
        rightBtn.frame = CGRectMake(96, 0, 40, 40);
        [rightBtn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        
        //添加lab
        UILabel * middleLab1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 3, 56, 34)];
      //  middleLab1.font = [UIFont systemFontOfSize:15];
        middleLab1.adjustsFontSizeToFitWidth = YES;
        middleLab1.backgroundColor = [UIColor clearColor];
        middleLab1.textColor = [UIColor blackColor];
        middleLab1.textAlignment = NSTextAlignmentCenter;
        if (self.dotNumber == 0)
        {
          middleLab1.text = [NSString stringWithFormat:@"共0份"];
        }
        else
        {
          middleLab1.text = [NSString stringWithFormat:@"共%.1f份",self.dotNumber];
        }
        
        self.middleLab = middleLab1;
        [self addSubview:middleLab1];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andIsRedButton:(BOOL)isRed andDotNumber:(double)aDotNumber
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dotNumber = aDotNumber;
        if (self.dotNumber>0)
        {
            ;
        }
        else
        {
            self.dotNumber = 0;
        }
        
        self.isOrderButton = isRed;
        
        //添加左边button
        UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton = leftBtn;
        if (self.isOrderButton)
        {
            [leftBtn setImage:[UIImage imageNamed:@"redM.png"] forState:UIControlStateNormal];
        }
        else
        {
            [leftBtn setImage:[UIImage imageNamed:@"greyM.png"] forState:UIControlStateNormal];
        }
        
        leftBtn.frame = CGRectMake(0, 0, 40, 40);
        [leftBtn addTarget:self action:@selector(leftButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:leftBtn];
        
        //添加右边button
        UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton = rightBtn;
        if (self.isOrderButton)
        {
            [rightBtn setImage:[UIImage imageNamed:@"redA.png"] forState:UIControlStateNormal];
        }
        else
        {
            [rightBtn setImage:[UIImage imageNamed:@"grayA.png"] forState:UIControlStateNormal];
        }
        
        rightBtn.frame = CGRectMake(96, 0, 40, 40);
        [rightBtn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        
        //添加lab
        UILabel * middleLab1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 3, 56, 34)];
       // middleLab1.font = [UIFont systemFontOfSize:15];
        middleLab1.adjustsFontSizeToFitWidth = YES;
        middleLab1.backgroundColor = [UIColor clearColor];
        middleLab1.textColor = [UIColor blackColor];
        middleLab1.textAlignment = NSTextAlignmentCenter;
        if (self.dotNumber == 0)
        {
            middleLab1.text = [NSString stringWithFormat:@"共0份"];
        }
        else
        {
            middleLab1.text = [NSString stringWithFormat:@"共%.1f份",self.dotNumber];
        }
        
        self.middleLab = middleLab1;
        [self addSubview:middleLab1];
    }
    return self;

}

-(void)leftButton:(UIButton *)aButton
{
    preDotNumber = self.dotNumber;
    
    if (self.dotNumber>0)
    {
        self.dotNumber = self.dotNumber-0.5;
    }
    else
    {
        self.dotNumber = 0;
    }
    if (self.dotNumber == 0)
    {
        self.middleLab.text = [NSString stringWithFormat:@"共0份"];
    }
    else
    {
        self.middleLab.text = [NSString stringWithFormat:@"共%.1f份",self.dotNumber];
    }
    [self.delegate ChangeDishView:self andLeftDotNumber:self.dotNumber andPreDotNumber:preDotNumber];
}
-(void)rightButton:(UIButton *)aButton
{
    preDotNumber = self.dotNumber;
    
    if (self.dotNumber == 0)
    {
        self.dotNumber = 1;
    }
    else
    {
        self.dotNumber = self.dotNumber+0.5;
    }
    if (self.dotNumber == 0)
    {
        self.middleLab.text = [NSString stringWithFormat:@"共0份"];
    }
    else
    {
        self.middleLab.text = [NSString stringWithFormat:@"共%.1f份",self.dotNumber];
    }
    [self.delegate ChangeDishView:self andRightDotNumber:self.dotNumber andPreDotNumber:preDotNumber];
}
@end
