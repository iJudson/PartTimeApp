//
//  AreaListViewController.m
//  duanGongBangBusinessSide1.0
//
//  Created by ljx on 16/4/20.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "AreaListViewController.h"
#import <BmobSDK/Bmob.h>
#import "SVProgressHUD.h"

@interface AreaListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * TableView;
    NSMutableArray *hotCity;
    
    
    NSDictionary *inputData;
    NSMutableDictionary *inputDataDic;


}
@property (nonatomic, weak) UIView *navBackView;

@end

@implementation AreaListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage: forBarPosition: barMetrics:)]){
        UIImage *backgroundImage = [UIImage new];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsCompactPrompt];
    } else if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        UIImage *backgroundImage = [UIImage new];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsCompactPrompt];
    }
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setTintColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self getBackView:self.navigationController.navigationBar];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"地区选择";
    self.navigationItem.titleView = label;
    
    hotCity = [NSMutableArray array];
    
    UIButton * leftbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftbtn setImage:[[UIImage imageNamed:@"顶部_关闭"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    leftbtn.frame = CGRectMake(0, 0, 70, 40);
    [leftbtn setImageEdgeInsets:UIEdgeInsetsMake(0, -45, 0, 0)];
    [leftbtn addTarget:self action:@selector(backPop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backItem= [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = backItem;

    TableView = [[UITableView alloc] initWithFrame:self.view.frame];
    TableView.dataSource = self;
    TableView.delegate = self;
    [self.view addSubview:TableView];
    TableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self SetWeb];
}

-(void)backPop
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return hotCity.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    
    cell.textLabel.text = [[hotCity objectAtIndex:indexPath.row] objectForKey:@"AreaName"];
    
    return cell;
}
#pragma mark - tableDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * dic = @{@"City":self.diaDate,@"Area":[hotCity objectAtIndex:indexPath.row]};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"City_Area" object:nil userInfo:dic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - methods
-(void)getBackView:(UIView*)superView
{
    if ([superView isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
        _navBackView = superView;
        //在这里可设置背景色
        //                _navBackView.backgroundColor = UIColorFromRGB(xMainBlueColor);
    }else if ([superView isKindOfClass:NSClassFromString(@"_UIBackdropView")]) {
        //_UIBackdropEffectView是_UIBackdropView的子视图，这是只需隐藏父视图即可
        [superView removeFromSuperview];
    }
    for (UIView *view in superView.subviews) {
        [self getBackView:view];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.tabBarController.tabBar.hidden = YES;
    _navBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85];
}
#pragma mark - servers
- (void)getMainDataWithDict:(NSDictionary *)dict success:(void (^)(NSDictionary *object))success fail:(void (^)(NSString *reason))fail{
    inputData = [NSDictionary dictionaryWithObject:dict forKey:@"inputData"];
    
    [BmobCloud callFunctionInBackground:M_V4_MainPage_C withParameters:inputData block:^(id object, NSError *err){
        if (!err) {
            if ([object isKindOfClass:[NSDictionary class]]) {
                success(object);
            }else if ([object isKindOfClass:[NSString class]]){
                [SVProgressHUD showErrorWithStatus:@"数据异常，未知错误"];
                return;
            }else{
                fail(kDataErrorWarning);
            }
            
        }else{
            fail(kNetworkWarning);
            //            LOG(@"getmaindataerror%@",err);
        }
    }];
    
}
- (void)SetWeb
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    inputDataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    M_GetResources,M_Type,
                    [self.diaDate objectForKey:@"objectId"],M_CityObjectId,
                    nil];
    [self getMainDataWithDict:inputDataDic success:^(NSDictionary *obj){
        if (obj) {
            [SVProgressHUD dismiss];
            hotCity = [NSMutableArray arrayWithArray:[obj objectForKey:@"Area"]];
            [hotCity removeObject:hotCity.firstObject];
            [TableView reloadData];
//            [SVProgressHUD showSuccessWithStatus:[obj objectForKey:@"Value"]];
        }
    }fail:^(NSString *err){
        [SVProgressHUD showErrorWithStatus:err];
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
