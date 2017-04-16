//
//  LPMainController.m
//  duanGongBangBusinessSide1.0
//  Created by Judson on 16/3/14.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPMainController.h"
#import "LPDuanGongBangController.h"
#import "LPResumeController.h"
#import "LPCompanyController.h"
#import "LPMessageController.h"
#import "LPNavController.h"
#import "LPTabBar.h"

@interface LPMainController ()

@end

@implementation LPMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildController];

}

#pragma mark - 设置tabbar控制器的子控制器
- (void)setupChildController{
    
    //设置tabbar的背景以及tabBarItem的总体颜色
    self.tabBar.translucent = YES;
    self.tabBar.barTintColor = [UIColor blackColor];
    self.tabBar.tintColor = [UIColor whiteColor];
    
    //短工邦控制器
    LPDuanGongBangController *duangongbangVC = [[LPDuanGongBangController alloc] init];
    LPNavController *duangongbangNav = [[LPNavController alloc] initWithRootViewController:duangongbangVC];
    duangongbangNav.title = @"短工邦" ;
    duangongbangNav.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
    duangongbangNav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    [duangongbangNav.tabBarItem setImage:[UIImage imageNamed:@"duangongbang"]];
    [duangongbangNav.tabBarItem setSelectedImage:[UIImage imageNamed:@"duangongbang_selected"]];
    [self addChildViewController:duangongbangNav];
  
    //消息控制器
    LPMessageController *messageVC = [[LPMessageController alloc] init];
    [messageVC baseViewControllerWithTitle:@"消息" Image:@"message" SelectedImage:@"message_selected" superController:self];
  
    //简历控制器
    LPResumeController *resumeVC = [[LPResumeController alloc] init];
    [resumeVC baseViewControllerWithTitle:@"简历" Image:@"company" SelectedImage:@"company_selected" superController:self];
  
    //公司控制器
    LPCompanyController *companyVC = [[LPCompanyController alloc] init];
    UINavigationController * navcompanyVC = [[UINavigationController alloc] initWithRootViewController:companyVC];
    companyVC.title = @"企业" ;
    companyVC.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
    companyVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    [companyVC.tabBarItem setImage:[UIImage imageNamed:@"resume"]];
    [companyVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"resume_selected"]];
    [self addChildViewController:navcompanyVC];
    
}





@end
