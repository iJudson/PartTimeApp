//
//  LPExamingController.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/6.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPExamingController.h"
#import "LPPartTimeCell.h"
#import "LPSeperatorCell.h"
#import "LPMessageExamingController.h"

@interface LPExamingController ()<UIGestureRecognizerDelegate>

@end

@implementation LPExamingController


static NSString *const reuseID = @"LPPartTimeCell";
static NSString *const seperatorReuseID = @"LPSeperatorCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareTableView];
    
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;

//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;      // 手势有效设置为YES  无效为NO
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;    // 手势的代理设置为self
//    }
}


- (void)prepareTableView{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2x"]];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPartTimeCell class]) bundle:nil] forCellReuseIdentifier:reuseID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPSeperatorCell class]) bundle:nil] forCellReuseIdentifier:seperatorReuseID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(titleViewheight+44, 0, tabBarheight, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    UIGestureRecognizer * ges = [[UIGestureRecognizer alloc] init];
//    ges.delegate = self;
//    [ self.tableView addGestureRecognizer:ges];

}

////tableView的侧滑是从右往左滑。而抽屉是从左往右滑。 解决方法刚刚找到了，判断滑动的视图。
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    // 输出点击的view的类名
//    NSLog(@"%@", NSStringFromClass([touch.view class]));
//    
//    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableView"]) {
//        return NO;
//    }
//    return  YES;
//}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //奇数
    if (indexPath.item%2 == 0) {
        LPSeperatorCell *seperatorcell = [tableView dequeueReusableCellWithIdentifier:seperatorReuseID forIndexPath:indexPath];
        seperatorcell.backgroundColor = [UIColor clearColor];
        return seperatorcell;
        
    }else {//偶数
        LPPartTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item%2 == 0) {
        return 12;
    }else {//偶数
        return 87;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSLog(@"sdfcfd%ld",section);
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LPScreenSize.width, 10)];
    subView.backgroundColor = [UIColor clearColor];
    return subView;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LPMessageExamingController *MesExamVC = [[LPMessageExamingController alloc] init];
    [self.navigationController pushViewController:MesExamVC animated:YES];
}


#pragma mark - getter

@end
