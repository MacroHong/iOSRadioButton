//
//  UIButton+Extra.m
//  MHDemo
//
//  Created by MacroHong on 3/25/15.
//  Copyright © 2015 Macro. All rights reserved.
//

#import "UIButton+MHExtra.h"
#import <objc/runtime.h>


/**
 *  @brief add action callback to uibutton
 */
@interface UIButton (MHAddCallBackBlock)

- (void)setMHCallBack:(MHButtonActionCallBack)callBack;
- (MHButtonActionCallBack)getMHCallBack;

@end

@implementation UIButton (MHAddCallBackBlock)

static MHButtonActionCallBack _callBack;

- (void)setMHCallBack:(MHButtonActionCallBack)callBack {
    objc_setAssociatedObject(self, &_callBack, callBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MHButtonActionCallBack)getMHCallBack {
     return (MHButtonActionCallBack)objc_getAssociatedObject(self, &_callBack);
}

@end;


@implementation UIButton (MHExtra)

/**
 *  @brief replace the method 'addTarget:forControlEvents:'
 *  @warning executed this method, the property 'enabled' is 'NO'
 */
- (void)addMHCallBackAction:(MHButtonActionCallBack)callBack forControlEvents:(UIControlEvents)controlEvents{
    [self setMHCallBack:callBack];
    [self addTarget:self action:@selector(mhButtonAction:) forControlEvents:controlEvents];
}

- (void)mhButtonAction:(UIButton *)btn {
//    btn.enabled = NO;
    self.getMHCallBack(btn);
}

@end
