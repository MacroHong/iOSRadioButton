//
//  MHRadioButton.h
//  
//
//  Created by Macro on 14-11-9.
//  Copyright (c) 2014年 Macro. All rights reserved.
//

#import <UIKit/UIKit.h>

// 按钮点击宽度 可根据实际更改
static const NSUInteger kRadioButtonWidth = 22;
// 按钮点击高度 可根据实际更改
static const NSUInteger kRadioButtonHeight = 22;

/*!
 *  @author Macro, 14-11-09
 *
 *  @brief  协议, RadioButton的选中项改变时, 触发此方法
 */
@protocol MHRadioButtonDelegate <NSObject>


/*!
 *  @author Macro, 14-11-09
 *
 *  @brief  选项改变
 *
 *  @param index   NSUInteger: 按钮下标
 *  @param groupID NSString *:单个按钮所在的"组号"
 */
- (void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupID;

@end



@interface MHRadioButton : UIView


/*!
 *  @author Macro, 14-11-09
 *
 *  @brief  初始化一个RadioButton
 *
 *  @param groupId NSString *:按钮的组号
 *  @param index   NSUInteger:按钮在组中的下标, 建议从0开始编号
 *
 *  @return RadioButton
 */
- (instancetype)initWithGroupId:(NSString *)groupId
                        atIndex:(NSUInteger)index;


/*!
 *  @author Macro, 14-11-10
 *
 *  @brief  设置RadioButton为选中状态
 */
- (void)selected;

/*!
 *  @author Macro, 14-11-10
 *
 *  @brief  添加观察者
 *
 *  @param observer 观察者
 *  @param groupId  组号
 */
+ (void)addObserver:(id <MHRadioButtonDelegate>)observer
         forFroupId:(NSString *)groupId;


/*!
 *  @author Macro, 14-11-10
 *
 *  @brief  获取特定组号的那组RadioButton的选中下标
 *
 *  @param groupId 组号
 *
 *  @return 下标 -1表示组号不存在
 */
+ (NSUInteger)getIndexWithGroupId:(NSString *)groupId;
@end
