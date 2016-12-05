//
//  MHRadioButton.m
//  
//
//  Created by Macro on 14-11-9.
//  Copyright (c) 2014年 Macro. All rights reserved.
//

#import "MHRadioButton.h"


@interface MHRadioButton ()
{
    // 每一个实例的
    UIButton *_button;
}

// 要用实例来访问这两个属性
@property (nonatomic, strong) NSString *groupId;
@property (nonatomic, assign) NSUInteger index;

@end

// RadioButton实例队列, 用于同组选中时, 取消同种中的其他实例
static NSMutableArray<MHRadioButton *> *kInstances = nil;

// 观察者映射, 通过观察者对RadioButtonDelegate方法的实现,对RadioButton选中状态的监控
static NSMutableDictionary<NSString *, id> *kObservers = nil;

// RadioButton选中状态的组号和选中下标的映射, 用于获取组号的选中下标
static NSMutableDictionary<NSString *, NSNumber *> *kIndexDic;

// RadioButton组号的记录队列, 用于默认情况下, 每组的默认选中下标, 即每组中第一个创建的下标
static NSMutableArray<NSString *> *groupIdsRecord;


@implementation MHRadioButton

/*!
 *  @author Macro, 14-11-10
 *
 *  @brief  添加观察者 和 组号的映射关系
 *
 *  @param observer 观察者
 *  @param groupId  组号
 */
+ (void)addObserver:(id)observer
         forFroupId:(NSString *)groupId {
    if (!kObservers) {
        kObservers = [[NSMutableDictionary alloc] init];
    }
    if (observer && groupId.length > 0) {
        [kObservers setObject:observer forKey:groupId];
    }
}

/*!
 *  @author Macro, 14-11-10
 *
 *  @brief  注册实例, 将当前RadioButton加入实例队列
 *
 *  @param rb 当前RadioButton
 */
+ (void)registerInstance:(MHRadioButton *)rb {
    if (!kInstances) {
        kInstances = [[NSMutableArray alloc] init];
        
    }
    if (![groupIdsRecord containsObject: rb.groupId]) {
        [groupIdsRecord addObject:rb.groupId];
        [rb selected];
    }
    [kInstances addObject:rb];
}

/*!
 *  @author Macro, 14-11-10
 *
 *  @brief  设置当前选中状态
 *
 *  @param rb 选中的RadioButton
 */
+ (void)buttonSelected:(MHRadioButton *)rb {
    // 响应观察者的协议方法
    if (kObservers) {
        id observer = [kObservers objectForKey:rb.groupId];
        if (observer &&
            [observer respondsToSelector:
             @selector(radioButtonSelectedAtIndex:inGroup:)]){
                [observer radioButtonSelectedAtIndex:rb.index
                                             inGroup:rb.groupId];
            }
    }
    
    // 把实例队列中的其他RadioButton取消选中
    if (kInstances) {
        for (int i = 0; i < kInstances.count; i++) {
            MHRadioButton *button = [kInstances objectAtIndex:i];
            if (![rb isEqual:button] && [button.groupId isEqualToString:rb.groupId]) {
                [button otherButtonSelected:rb];
            }
        }
    }
}

/*!
 *  @author Macro, 14-11-10
 *
 *  @brief  获取特定组号的那组RadioButton的选中下标
 *
 *  @param groupId 组号
 *
 *  @return 下标 -1表示组号不存在
 */
+ (NSUInteger)getIndexWithGroupId:(NSString *)groupId {
    NSNumber *indexNumber = [kIndexDic objectForKey:groupId];
    if (!indexNumber) {
        return -1;
    }
    return [indexNumber unsignedLongValue];
}



/*!
 *  @author Macro, 14-11-09
 *
 *  @brief  初始化一个RadioButton
 *
 *  @param groupId 按钮的组号
 *  @param index   按钮在组中的下标
 *
 *  @return RadioButton
 */
- (instancetype)initWithGroupId:(NSString *)groupId
                        atIndex:(NSUInteger)index {
    self = [super init];
    if (self) {
        _groupId = groupId;
        _index = index;
        
        if (!groupIdsRecord) {
            groupIdsRecord = [[NSMutableArray alloc] init];
        }
        
        [self defaultInit];
    }
    return self;
}


/*!
 *  @author Macro, 14-11-09
 *
 *  @brief  设置一些默认属性
 */
- (void)defaultInit {
    CGRect frame = CGRectMake(0, 0, kRadioButtonWidth, kRadioButtonHeight);
    self.frame = frame;

    _button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _button.frame = frame;
    _button.adjustsImageWhenHighlighted = NO;
//    [_button setBackgroundColor:[UIColor lightGrayColor]]; // test
    [_button setImage:[UIImage imageNamed:@"RadioButton-Unselected"]
             forState:(UIControlStateNormal)];
    [_button setImage:[UIImage imageNamed:@"RadioButton-Selected"]
             forState:(UIControlStateSelected)];

    [_button addTarget:self
                action:@selector(selected)
      forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_button];
    [MHRadioButton registerInstance:self];
}

- (void)selected {
    if (!kIndexDic) {
        kIndexDic = [[NSMutableDictionary alloc] init];
    }
    [kIndexDic setObject:@(_index) forKey:_groupId];
    _button.selected = YES;
    [MHRadioButton buttonSelected:self];
}



- (void)otherButtonSelected:(MHRadioButton *)rb {
    if (_button.selected) {
        _button.selected = NO;
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
