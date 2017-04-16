//
//  LPBaseTableViewController.h
//  duanGongBangBusinessSide1.0
//
//  Created by Judson on 16/3/15.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPBaseTableViewController : UITableViewController

/**
 *  子类控制器的相关设置
 *
 *  @param title               标题
 *  @param imageName           普通状态下的图片名称
 *  @param selectedImageName   选择状态下图片名称
 *  @param superViewController 控制器
 */
- (void)baseViewControllerWithTitle:(NSString *)title Image:(NSString *)imageName SelectedImage:(NSString *)selectedImageName superController:(UIViewController *)superViewController;


@end
