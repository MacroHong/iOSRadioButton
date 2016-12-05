//
//  UIButton+MHExtra.h
//  MHDemo
//
//  Created by MacroHong on 3/25/15.
//  Copyright © 2015 Macro. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MHButtonActionCallBack)(UIButton *button);

@interface UIButton (MHExtra)


/**
 *  @brief replace the method 'addTarget:forControlEvents:'
 *  @warning executed this method, the property 'enabled' is 'NO'
 */
- (void)addMHCallBackAction:(MHButtonActionCallBack)callBack forControlEvents:(UIControlEvents)controlEvents;

@end
