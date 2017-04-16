//
//  MySendJobModelViewController.m
//  duanGongBangBusinessSide1.0
//
//  Created by ljx on 16/4/11.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "MySendJobModelViewController.h"

@interface MySendJobModelViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView * JobModelTabview;

@end

@implementation MySendJobModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"历史发布";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blackImg"]];
    self.navigationController.navigationBar.alpha = 0.999;
    self.navigationItem.titleView.tintColor = [UIColor whiteColor];
    
    
    //设置导航栏相关内容
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"Arial-Bold" size:40],NSFontAttributeName,nil]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithWhite:0.2 alpha:0.7];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.alpha = 0.1;

    
    UIImageView * backv = [[UIImageView alloc] initWithFrame:self.view.frame];
    backv.image = [[UIImage imageNamed:@"bg2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.view addSubview:backv];

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"顶部_关闭"] style:UIBarButtonItemStylePlain target:self action:@selector(backPop)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.JobModelTabview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Width, Height - 64)];
    self.JobModelTabview.backgroundColor = [UIColor clearColor];
    self.JobModelTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.JobModelTabview.delegate = self;
    self.JobModelTabview.dataSource = self;
    [self.view addSubview:self.JobModelTabview];
    [self.JobModelTabview registerNib:[UINib nibWithNibName:@"JobModel" bundle:nil] forCellReuseIdentifier:@"JobModel"];
//63
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma -mark Tabview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor clearColor];
    
//    if (section != 0) {
//        UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Width, 4)];
//        img.image = [UIImage imageNamed:@"bottomShawow"];
//        [myView addSubview:img];
//
//    }
    
//    CGRect sectionRect = [tableView rectForSection:self.section];
//    CGRect newFrame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(sectionRect), CGRectGetWidth(frame), CGRectGetHeight(frame)); [super setFrame:newFrame];

    
    return myView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  12;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    
        cell = [tableView dequeueReusableCellWithIdentifier:@"JobModel"];
        
        
        return cell;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)backPop
{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
