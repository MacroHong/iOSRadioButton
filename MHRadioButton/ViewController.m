//
//  ViewController.m
//  MHRadioButton
//
//  Created by Macro on 11/9/15.
//  Copyright © 2015 Macro. All rights reserved.
//

#import "ViewController.h"
#import "MHRadioButton.h"


@interface ViewController ()<MHRadioButtonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i = 0; i < 4; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group" atIndex:i];
        rb.frame = CGRectMake(150, 100 + 60 * i, 40, 40);
        [self.view addSubview:rb];
    }
    [MHRadioButton addObserver:self forFroupId:@"group"];
    NSLog(@"%lu", [MHRadioButton getIndexWithGroupId:@"group"]);
    
    for (int i = 0; i < 5; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group2" atIndex:i];
        rb.frame = CGRectMake(100, 100 + 60 * i, 40, 40);
        [self.view addSubview:rb];
    }
    [MHRadioButton addObserver:self forFroupId:@"group2"];
    NSLog(@"%lu", [MHRadioButton getIndexWithGroupId:@"group2"]);
    
    for (int i = 0; i < 6; i++) {
        MHRadioButton *rb = [[MHRadioButton alloc] initWithGroupId:@"group" atIndex:i];
        rb.frame = CGRectMake(50, 100 + 60 * i, 40, 40);
        [self.view addSubview:rb];
    }
//    [MHRadioButton addObserver:self forFroupId:@"group3"];
    NSLog(@"%lu", [MHRadioButton getIndexWithGroupId:@"group"]);
    

    
    
    
}

// 代理方法 监控按钮选中状态的改变
- (void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupID {
    NSLog(@"%@ %lu", groupID, (unsigned long)index);
    
    NSLog(@"%lu", [MHRadioButton getIndexWithGroupId:@"group"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
