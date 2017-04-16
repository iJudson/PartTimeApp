//
//  LPEmployingController.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/6.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPEmployingController.h"
#import "LPPartTimeCell.h"
#import "LPSeperatorCell.h"
#import "LPMessageExamingController.h"


@interface LPEmployingController ()


@end


static NSString *const reuseID = @"LPPartTimeCell";
static NSString *const seperatorReuseID = @"LPSeperatorCell";

@implementation LPEmployingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareTableView];
}


- (void)prepareTableView{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2x"]];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPPartTimeCell class]) bundle:nil] forCellReuseIdentifier:reuseID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPSeperatorCell class]) bundle:nil] forCellReuseIdentifier:seperatorReuseID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(titleViewheight+44, 0, tabBarheight, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
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

@end
