//
//  LPMessageExamingController.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/13.
//  Copyright © 2016年 lingpin. All rights reserved.

#import "LPMessageExamingController.h"
#import "LPWholeHeaderView.h"

#import "LPTabBar.h"
//全部的cell
#import "LPContentDetailCell.h"
#import "LPContentCell.h"
#import "LPMesssageClickCell.h"
#import "LPOutLineCell.h"

@interface LPMessageExamingController ()<UITableViewDataSource,UITableViewDelegate>

// 定义tableview属性
@property(nonatomic,strong)UITableView *tableView;

// 定义背景图片属性
@property(nonatomic,strong)UIImageView *bgImageView;

// 定义titlesView属性
@property(nonatomic,strong)UIView *titlesView;

// 定义tababr属性
@property(nonatomic,strong)LPTabBar *myTabBar;

@end

@implementation LPMessageExamingController


static NSString * ContentDetailID = @"LPContentDetailCell";
static NSString *const ContentID = @"LPContentCell";
static NSString *const MesssageClickID = @"LPMesssageClickCell";
static NSString *const OutLineID = @"LPOutLineCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //设置顶部的标签栏
    [self setupTitlesView];
    // 设置导航栏
    [self setupNav];
    
    //设置底部的tabBar
    [self setupTabBar];
    
    //tableView上面的相关设置
    [self prepareForTableView];
    
    
    //阴影设置
    UIImageView *shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 130, LPScreenSize.width, 4)];
    shadowImageView.image = [UIImage imageNamed:@"bottomShawow-1"];
    
    [self.view addSubview:shadowImageView];

}

- (void)prepareForTableView{
    
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.titlesView];
    [self.view addSubview:self.myTabBar];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.titlesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(66);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.top.equalTo(self.view).offset(12);
        make.bottom.equalTo(self.view);
    }];
    
    [self.myTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(49);
    }];
    
    self.tableView.contentInset = UIEdgeInsetsMake(64+66, 0, tabBarheight+12, 0);
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPOutLineCell class]) bundle:nil] forCellReuseIdentifier:OutLineID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPMesssageClickCell class]) bundle:nil] forCellReuseIdentifier:MesssageClickID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPContentCell class]) bundle:nil] forCellReuseIdentifier:ContentID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPContentDetailCell class]) bundle:nil] forCellReuseIdentifier:ContentDetailID];
    
}

- (void)setupNav{
    self.navigationItem.title = @"教育路地铁站旁派单";

}


- (void)setupTabBar{
    
    LPTabBar *tabbar = [LPTabBar returnATabBar];
    self.myTabBar = tabbar;
    
}


- (void)setupTitlesView{
    // 头标签整体
    LPWholeHeaderView *titlesView = [LPWholeHeaderView returnWholeHeaderView];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    self.titlesView = titlesView;
    
}

#pragma mark -delegate和datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 8;
    }else{
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        LPOutLineCell *cell = [tableView dequeueReusableCellWithIdentifier:OutLineID forIndexPath:indexPath];
        cell.isNormalBgView = NO;
        cell.image = [UIImage imageNamed:@"orangeCorner"];
        cell.title = @"工作简介";
        return cell;
        
    }else if(indexPath.section == 1 && indexPath.row == 0){
        LPOutLineCell *cell = [tableView dequeueReusableCellWithIdentifier:OutLineID forIndexPath:indexPath];
        cell.image = [UIImage imageNamed:@"blueCorner"];
        cell.isNormalBgView = YES;
        cell.title = @"工作详情";
        return cell;
    }else if(indexPath.section == 0 && indexPath.row <= 5){
        LPContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ContentID forIndexPath:indexPath];
        return cell;
    }else if(indexPath.section == 0 && indexPath.row <= 7){
        LPMesssageClickCell *cell = [tableView dequeueReusableCellWithIdentifier:MesssageClickID forIndexPath:indexPath];
        return cell;
    }else{//详细内容的工作描述
        LPContentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ContentDetailID forIndexPath:indexPath];
        return cell;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0 && indexPath.row == 0) {
        return 54;
    }else if(indexPath.section == 1 && indexPath.row == 0){
        return 54;
    }else if(indexPath.section == 1 && indexPath.row == 1){
        return 100;
    }
    else{
        return 30;
    }
}



#pragma mark - 懒加载
-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _bgImageView.image = [UIImage imageNamed:@"bg2x"];
    
    }
    return _bgImageView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

-(LPTabBar *)myTabBar{
    if (!_myTabBar) {
        _myTabBar = [[LPTabBar alloc] init];
        
    }
    return _myTabBar;
}



@end
