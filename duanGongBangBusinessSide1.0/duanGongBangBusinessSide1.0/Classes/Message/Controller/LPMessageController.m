//
//  LPMessageController.m
//  duanGongBangBusinessSide1.0
//
//  Created by Judson on 16/3/15.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPMessageController.h"
#import "LPMessageCell.h"

@interface LPMessageController ()

@end

@implementation LPMessageController

static NSString *reuseIdentifier = @"LPMessageCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareForNavigationItem];
    
    
    
}

#pragma mark - 准备navigationItem上的所有UI的内容
- (void)prepareForNavigationItem{
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"建群" style:UIBarButtonItemStylePlain target:self action:@selector(createGroup)];
    
    self.navigationItem.rightBarButtonItem = right;
}
/**
 *  建群的方法
 */
- (void)createGroup{
    NSLog(@"createGroup");
}


#pragma mark - 准备UITableViewCell的相关内容

- (void)prepareTableViewCell{
    
    [self.tableView registerClass:[LPMessageCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.rowHeight = 100;
    self.tableView.separatorColor = [UIColor clearColor];

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LPMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[LPMessageCell alloc] init];
    }
    cell.groupImage = [UIImage imageNamed:@"headerView"];
    cell.groupName = @"这是一个群名，萌萌哒";
    cell.chatMessage = @"发布工作的群，进来请备注具体求职信息";
    cell.timeMessage = @"2分钟前";
    
    
    return cell;
}



@end
