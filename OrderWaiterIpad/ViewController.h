//
//  ViewController.h
//  OrderWaiterIpad
//
//  Created by tiankong360 on 13-9-11.
//  Copyright (c) 2013年 tiankong360. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ViewController : BaseViewController<UITextFieldDelegate>
{
    UITextField *nameTF;
    UITextField *keyTF;
    UIButton    *remindBtn;
    int         i;
}
@end
