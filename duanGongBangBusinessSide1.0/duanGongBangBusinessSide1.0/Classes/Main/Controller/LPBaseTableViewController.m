//
//  LPBaseTableViewController.m
//  duanGongBangBusinessSide1.0
//
//  Created by Judson on 16/3/15.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPBaseTableViewController.h"
#import "LPNavController.h"

@interface LPBaseTableViewController ()

@end

@implementation LPBaseTableViewController

static NSString *reuseIdentifier = @"LPBaseTableViewCell";

 - (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareTableViewCell];
}

- (void)prepareTableViewCell{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.estimatedRowHeight = 100;
}


- (void)baseViewControllerWithTitle:(NSString *)title Image:(NSString *)imageName SelectedImage:(NSString *)selectedImageName superController:(UIViewController *)superViewController{
    
    LPNavController *nav = [[LPNavController alloc] initWithRootViewController:self];
   
    self.title = title;
    
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(2, 0, -2, 0);
    self.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    [self.tabBarItem setImage:[UIImage imageNamed:imageName]];
    [self.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImageName]];
    [superViewController addChildViewController:nav];
}




@end
