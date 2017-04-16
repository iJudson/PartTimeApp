//
//  LPPartTimeManagementController.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/6.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPPartTimeManagementController.h"
#import "LPExamingController.h"
#import "LPEmployingController.h"
#import "LPOffshelfController.h"


@interface LPPartTimeManagementController ()<UIScrollViewDelegate>

/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;


@end

@implementation LPPartTimeManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
    
    // 初始化子控制器
    [self setupChildVCs];
    
    // 设置顶部的标签栏
    [self setupTitlesView];
    
    // 底部的scrollView
    [self setupContentView];
}

- (void)setupNav{
    // 设置导航栏标题
//    self.title = @"兼职管理";
    self.navigationItem.title = @"兼职管理";
    self.view.backgroundColor = [UIColor colorWithRed:(233)/255.0 green:(233)/255.0 blue:(233)/255.0 alpha:1.0];
}

- (void)setupChildVCs{
    LPExamingController * examingVC = [[LPExamingController alloc] init];
    [self addChildViewController:examingVC];
    
    LPEmployingController *employVC = [[LPEmployingController alloc] init];
    [self addChildViewController:employVC];
    
    LPOffshelfController *offSelfVC =[[LPOffshelfController alloc] init];
    [self addChildViewController:offSelfVC];
}

- (void)setupTitlesView{
    
}

- (void)setupContentView{
    
}



@end
