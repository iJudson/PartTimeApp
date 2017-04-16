//
//  LPNavController.m
//  duanGongBangBusinessSide1.0
//
//  Created by Judson on 16/3/14.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPNavController.h"

@interface LPNavController ()<UIGestureRecognizerDelegate>

@end

@implementation LPNavController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //设置导航栏相关内容
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Arial-Bold" size:40],NSFontAttributeName,nil]];
    self.navigationBar.barTintColor = [UIColor colorWithWhite:0 alpha:0.9];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.translucent = YES;
//    self.navigationBar.alpha = 0.9;
    self.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;

}


/**
 *  在这个方法中拦截所有push进来的控制器,故可以在这里自定义返回的barItem
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {//这里可以保证不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
        button.IJ_size = CGSizeMake(24, 24);
        //添加一张leftbaritem底层点击的view，防止点击范围过大
//        UIView *leftBarItemView = [[UIView alloc] initWithFrame:button.bounds];
//        leftBarItemView.bounds = CGRectOffset(button.bounds, 0, 0);
//        [leftBarItemView addSubview:button];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 修改导航栏左边的item
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        if (self.viewControllers.count > 1) {
            // 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = YES;
        }
        
    }
    
    [super pushViewController:viewController animated:animated];
}


- (void)back
{
    [self popViewControllerAnimated:YES];
}



@end
