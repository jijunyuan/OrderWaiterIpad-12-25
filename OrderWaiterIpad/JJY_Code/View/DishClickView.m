//
//  DishClickView.m
//  test
//
//  Created by tiankong360 on 13-8-1.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "DishClickView.h"
#import <QuartzCore/QuartzCore.h>

@interface DishClickView()
{
    UIButton * testBtn;
}
-(void)buttonClick:(UIButton *)aButton;
-(void)leftButtonClick:(UIButton *)aButton;
-(void)rightButtonClick:(UIButton *)aButton;
-(void)initView:(int)aNumber;
@end

@implementation DishClickView
@synthesize index;
@synthesize leftButton;
@synthesize rightButton;
@synthesize bigButton;
@synthesize price;

//80, 100, 160, 40
- (DishClickView *)initWithFrame:(CGRect)frame andNumber:(int)aNumber
{
    self = [super initWithFrame:frame];
    if (self)
    {
        testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bigButton = testBtn;
        [testBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [testBtn setBackgroundImage:[UIImage imageNamed:@"点菜.png"] forState:UIControlStateNormal];
        testBtn.frame = CGRectMake(30, 17.5, 113, 36);
        [self addSubview:testBtn];
        
        UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftButton = leftBtn;
        [leftBtn addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.alpha = 0.0;
        leftBtn.frame = CGRectMake(15, 9, 42, 42);
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"减去2.png"] forState:UIControlStateNormal];
        leftBtn.titleLabel.textColor = [UIColor blackColor];
        [self addSubview:leftBtn];
        
        UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightButton = rightBtn;
        [rightBtn addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        rightBtn.alpha = 0.0;
        rightBtn.frame = CGRectMake(115, 9, 42, 42);
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"加上2.png"] forState:UIControlStateNormal];
        rightBtn.titleLabel.textColor = [UIColor blackColor];
        [self addSubview:rightBtn];
        
        UILabel * middleLab = [[UILabel alloc] initWithFrame:CGRectMake(65, 20, 40, 25)];
        self.myLab = middleLab;
        middleLab.font = [UIFont systemFontOfSize:15];
        middleLab.alpha = 0;
        middleLab.textAlignment = NSTextAlignmentCenter;
        middleLab.textColor = [UIColor redColor];
        middleLab.backgroundColor = [UIColor clearColor];
        [self addSubview:middleLab];
        
        if (aNumber >0)
        {
            [self initView:aNumber];
        }
    }
    return self;
}
-(void)leftButtonClick:(UIButton *)aButton
{
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"减去2.png"] forState:UIControlStateNormal];
    self.dotNumber--;
    self.myLab.text = [NSString stringWithFormat:@"点%d份",self.dotNumber];
    if (self.dotNumber == 0)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.1];
        testBtn.alpha = 1.0;
        self.myLab.alpha = 0.0;
        self.leftButton.alpha = 0.0;
        self.rightButton.alpha = 0.0;
        self.leftButton.frame = CGRectMake(15, 9, 42, 42);
        self.rightButton.frame = CGRectMake(115, 9, 42, 42);
        [UIView commitAnimations];
    }
}

-(void)rightButtonClick:(UIButton *)aButton
{
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"加上2.png"] forState:UIControlStateNormal];
    self.dotNumber++;
    self.myLab.text = [NSString stringWithFormat:@"点%d份",self.dotNumber];
}

-(void)buttonClick:(UIButton *)aButton
{
    self.dotNumber = 1;
    self.myLab.text = [NSString stringWithFormat:@"点%d份",self.dotNumber];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    testBtn.alpha = 0.0;
    self.myLab.alpha = 1.0;
    self.leftButton.alpha = 1.0;
    self.rightButton.alpha = 1.0;
    self.leftButton.frame = CGRectMake(15, 9, 42, 42);
    self.rightButton.frame = CGRectMake(115, 9, 42,42);
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"减去2.png"] forState:UIControlStateNormal];
    [self.rightButton setBackgroundImage:[UIImage imageNamed:@"加上2.png"] forState:UIControlStateNormal];
    [UIView commitAnimations];
}
-(void)initView:(int)aNumber
{
    self.dotNumber = aNumber;
    self.myLab.text = [NSString stringWithFormat:@"点%d份",self.dotNumber];
    testBtn.alpha = 0.0;
    self.myLab.alpha = 1.0;
    self.leftButton.alpha = 1.0;
    self.rightButton.alpha = 1.0;
    self.leftButton.frame = CGRectMake(15, 9, 42, 42);
    self.rightButton.frame = CGRectMake(115, 9, 42, 42);
}
-(void)zeroState
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    testBtn.alpha = 1.0;
    self.myLab.alpha = 0.0;
    self.leftButton.alpha = 0.0;
    self.rightButton.alpha = 0.0;
    self.leftButton.frame = CGRectMake(30, 0, 42, 42);
    self.rightButton.frame = CGRectMake(30, 0, 42, 42);
    [UIView commitAnimations];
}

@end
