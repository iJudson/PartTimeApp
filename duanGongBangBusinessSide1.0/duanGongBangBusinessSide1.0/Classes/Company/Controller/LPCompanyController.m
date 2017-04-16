//
//  LPCompanyController.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/3/31.
//  Copyright © 2016年 lingpin. All rights reserved.

#import "LPCompanyController.h"
#import "LPCompanyHeaderView.h"
//三种类型的cell
#import "LPShowMessgeCell.h"
#import "LPDetailMessageCell.h"
#import "LPOriginalMessageCell.h"
#import "LPLastCell.h"


#import "MerchantmessageViewController.h"
#import "MerchantACMianViewController.h"

#define IComHeaderViewHeight 180
@interface LPCompanyController ()<UITableViewDelegate,UITableViewDataSource,TapCompanyHeaderV>

// 定义背景图片属性
@property(nonatomic,strong)UIImageView *backgroundImageView;
// 定义UITableView属性
@property(nonatomic,strong)UITableView *tableView;

// 定义headerView属性
@property(nonatomic,strong)UIView *headerView;

@end

static  NSString * FReuseIdentifier = @"LPShowMessgeCell";
static  NSString * SReuseIdentifier = @"LPDetailMessageCell";
static  NSString * TReuseIdentifier = @"LPOriginalMessageCell";
static  NSString * LastReuseIdentifier = @"LPLastCell";

@implementation LPCompanyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareForUI];
    [self prepareForTableView];
}


#pragma mark - 准备UI
- (void)prepareForUI{
    
    //添加所有的子控件
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.tableView];
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.top.equalTo(self.view).offset(20);
        make.bottom.equalTo(self.view).offset(-20);
    }];
    
    //添加毛玻璃效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self.backgroundImageView addSubview:effectView];
    
    
    //给effectView添加约束
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backgroundImageView);
    }];
}

/**
 *  tableViewcell的相关设置
 */
- (void)prepareForTableView{
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;

    LPCompanyHeaderView *headerView = [LPCompanyHeaderView companyHeaderView];
    headerView.frame = CGRectMake(0, 0, LPScreenSize.width, 204);
    headerView.backgroundColor = [UIColor clearColor];
    headerView.delegate = self;
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPShowMessgeCell class]) bundle:nil] forCellReuseIdentifier:FReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPDetailMessageCell class]) bundle:nil] forCellReuseIdentifier:SReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPOriginalMessageCell class]) bundle:nil] forCellReuseIdentifier:TReuseIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPLastCell class]) bundle:nil] forCellReuseIdentifier:LastReuseIdentifier];
    
    self.tableView.sectionFooterHeight = 12;
    self.tableView.sectionHeaderHeight = 0;

}


#pragma mark - UITableViewDatasource && UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *baseCell;
    [self.tableView bringSubviewToFront:baseCell];
    if (indexPath.section == 0 && indexPath.row==0) {
        LPShowMessgeCell *cell = [tableView dequeueReusableCellWithIdentifier:FReuseIdentifier forIndexPath:indexPath];
        baseCell = cell;
    }else if(indexPath.section == 0 && indexPath.row > 0){
        LPDetailMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:SReuseIdentifier forIndexPath:indexPath];
        baseCell = cell;
    }else if(indexPath.section == 2 && indexPath.row == 2){//最后一个section，最后一个row时候存在的情况
        LPLastCell *cell = [tableView dequeueReusableCellWithIdentifier:LastReuseIdentifier forIndexPath:indexPath];
        baseCell = cell;
        
    }else{
        LPOriginalMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:TReuseIdentifier forIndexPath:indexPath];
      baseCell = cell;
    }
    return baseCell;
}


//返回不同的cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row==0) {
        return 69;
    }else{
        return 53;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row >0) {
        
        MerchantmessageViewController * MerchantACMianV = [[MerchantmessageViewController alloc] init];
        [self.navigationController pushViewController:MerchantACMianV animated:YES];
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return nil;
    }
    CGRect frame = self.tableView.frame;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 2)];
    view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    
    return view;
}


#pragma mark - getter
-(UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.image = [UIImage imageNamed:@"headerView"];
    }
    return _backgroundImageView;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


-(UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LPScreenSize.width, 204)];
        
    }
    return _headerView;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - tabheaderView的delegate

- (void)didTapimgview_longyellow
{
        MerchantACMianViewController * MerchantACMianV = [[MerchantACMianViewController alloc] init];
        [self.navigationController pushViewController:MerchantACMianV animated:YES];
    
//    MerchantmessageViewController * MerchantACMianV = [[MerchantmessageViewController alloc] init];
//    [self.navigationController pushViewController:MerchantACMianV animated:YES];
    
}


@end
