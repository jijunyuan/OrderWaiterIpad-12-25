//
//  BottomView.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-17.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "BottomView.h"

@interface BottomView()
@property (nonatomic,strong) NSMutableArray * buttonArr;
-(void)buttonClick:(UIButton *)aButton;
@end

@implementation BottomView
@synthesize arry_class;
@synthesize delegate;
@synthesize buttonArr;


- (id)initWithFrame:(CGRect)frame andDataArr:(NSMutableArray *)aArr
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 10);
        
        self.buttonArr = [NSMutableArray arrayWithCapacity:0];
        self.arry_class = aArr;
        
        UIScrollView * scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 570+40, 49)];
        float contentWeight = 0.0;
        
        if (self.arry_class.count>6)
        {
            for (int i = 0; i<self.arry_class.count; i++)
            {
                UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
                 [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                if (i == 0)
                {
                     button1.backgroundColor = [UIColor redColor];
                    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
                button1.tag = 100+i;
                [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                [button1 setTitle:[[self.arry_class objectAtIndex:i] valueForKey:@"ClassName"] forState:UIControlStateNormal];
                [button1.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
                button1.layer.cornerRadius = 4;
                float pointX = 17.0+i*(72+21);
                button1.frame = CGRectMake(pointX, 5, 88, 39);
                
                [self.buttonArr addObject:button1];
                
                [scrollV addSubview:button1];
            }
            contentWeight = 87*self.arry_class.count+60+37;
        }
        else
        {
            float temp = (570.0/self.arry_class.count-88)/2.0;
            for (int i = 0; i<self.arry_class.count; i++)
            {
                UIButton * button1 = [UIButton buttonWithType:UIButtonTypeCustom];
                [button1.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
                if (i == 0)
                {
                    button1.backgroundColor = [UIColor redColor];
                }
                button1.tag = 100+i;
                [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                button1.layer.cornerRadius = 4;
                float pointX = temp+i*(88+temp*2);
                button1.frame = CGRectMake(pointX, 5, 88, 39);
                [self.buttonArr addObject:button1];
                [scrollV addSubview:button1];
            }
            contentWeight = 570;
        }
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = CGRectMake(0, 0, contentWeight, 49);
        gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor,
                           (id)[UIColor colorWithRed:222.0/225.0 green:222.0/225.0 blue:222.0/225.0 alpha:1.0].CGColor,
                           (id)[UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1.0].CGColor,nil];
        [scrollV.layer insertSublayer:gradient atIndex:0];
        
        scrollV.contentSize = CGSizeMake(contentWeight, 49);
        [self addSubview:scrollV];
    }
    return self;
}
-(void)buttonClick:(UIButton *)aButton
{
    NSLog(@"%s",__FUNCTION__);
     int tempInt = aButton.tag;
    for (int i = 0; i<self.buttonArr.count; i++)
    {
         UIButton * tempButton = (UIButton *)[self viewWithTag:i+100];
        if (i+100 == tempInt)
        {
            tempButton.backgroundColor = [UIColor redColor];
            [tempButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else
        {
            tempButton.backgroundColor = [UIColor clearColor];
            [tempButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            UIFont * font = [UIFont fontWithName:@"Helvetica-Bold" size:tempButton.titleLabel.font.pointSize];
            [tempButton.titleLabel setFont:font];
        }
    }
    
    NSString * classId = [NSString stringWithFormat:@"%@",[[self.arry_class objectAtIndex:aButton.tag-100] valueForKey:@"classID"]];
    [self.delegate BottomView:self andClassId:classId];
}


@end
