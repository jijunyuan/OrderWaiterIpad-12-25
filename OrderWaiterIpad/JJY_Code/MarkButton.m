//
//  MarkButton.m
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-12-18.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import "MarkButton.h"

@implementation MarkButton
@synthesize isMark;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isMark = NO;
    }
    return self;
}


@end
