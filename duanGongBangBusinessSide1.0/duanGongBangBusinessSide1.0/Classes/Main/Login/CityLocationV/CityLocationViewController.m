//
//  CityLocationViewController.m
//  duangongbangUser
//
//  Created by ljx on 15/3/27.
//  Copyright (c) 2015年 duangongbang. All rights reserved.
//

#import "CityLocationViewController.h"
#import <BmobSDK/Bmob.h>
#import "SVProgressHUD.h"
#import "AreaListViewController.h"

@interface CityLocationViewController ()<UIGestureRecognizerDelegate>{
//
    NSArray *hotCity;
//
    BOOL isLoadCity;
    
    BOOL includedThisCity;
    
    NSString *myCity;
    
    NSMutableArray *cityArray;
}

//- (IBAction)btnLocation:(id)sender;
//
//- (IBAction)btnChooseCity:(id)sender;

@property (weak, nonatomic) IBOutlet __block UIButton *btnChooseCityPro;

@property (weak, nonatomic) IBOutlet UITableView *cityTableView;

@property (nonatomic, weak) UIView *navBackView;

@end

@implementation CityLocationViewController
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
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

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
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"城市选择";
    self.navigationItem.titleView = label;

//    self.btnChooseCityPro.userInteractionEnabled = NO;
    self.cityTableView.contentInset = UIEdgeInsetsMake(87, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    UIButton * leftbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftbtn setImage:[[UIImage imageNamed:@"顶部_关闭"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    leftbtn.frame = CGRectMake(0, 0, 70, 40);
    [leftbtn setImageEdgeInsets:UIEdgeInsetsMake(0, -45, 0, 0)];
    [leftbtn addTarget:self action:@selector(backPop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backItem= [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = backItem;

    [SVProgressHUD showWithStatus:@"正在加载..."];
    [self getHotCity:^(NSArray *arr){
        hotCity = arr;
        [self.cityTableView reloadData];
        [SVProgressHUD dismiss];
    }fail:^(NSString *str){
        [SVProgressHUD dismiss];
    }];
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

-(void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    cell.textLabel.text = [[hotCity objectAtIndex:indexPath.row] objectForKey:@"CityName"];
    
    return cell;
}

#pragma mark - tableDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BmobObject *obj = [hotCity objectAtIndex:indexPath.row];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         obj.objectId,@"objectId",
                         [obj objectForKey:@"CityName"],@"CityName",nil];
    [self selectedCity:dic];
}

- (void)getHotCity:(void(^)(NSArray *city))allCity fail:(void(^)(NSString *reason))fail{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"City"];
    if (!isLoadCity) {
        [bquery setCachePolicy:kBmobCachePolicyCacheThenNetwork];
        isLoadCity = YES;
    }else{
        [bquery setCachePolicy:kBmobCachePolicyNetworkOnly];
    }
    [bquery orderByAscending:@"createdAt"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *arr, NSError *err){
        if (arr) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (BmobObject *bmobObject in arr) {
                [array addObject:bmobObject];
            }
            allCity(array);
        }
    }];
}

//- (IBAction)btnLocation:(id)sender{
//    [SVProgressHUD showWithStatus:@"定位中"];
//    [locMgr startUpdatingLocation];
//}

- (IBAction)btnChooseCity:(id)sender{
//    BmobQuery *getquery = [BmobQuery queryWithClassName:@"City"];
//    [getquery whereKey:@"CityName" equalTo:myCity];
//    [getquery findObjectsInBackgroundWithBlock:^(NSArray *arr, NSError *err){
//        if (arr) {
//            BmobObject *obj = [arr firstObject];
//            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 obj.objectId,@"objectId",
//                                 myCity,@"CityName",nil];
//            [self selectedCity];
//            includedThisCity = YES;
//        }else{
//            [SVProgressHUD showErrorWithStatus:@"当前城市未开通"];
//            includedThisCity = NO;
//        }
//    }];
}
#pragma mark - methods
- (void)selectedCity:(NSDictionary *)dic{
//    NSLog(@"%@--%@",[dic objectForKey:@"objectId"],[dic objectForKey:@"CityName"]);
    AreaListViewController * AreaListV = [[AreaListViewController alloc] init];
    AreaListV.diaDate = dic;
    [self.navigationController pushViewController:AreaListV animated:YES];
}


@end
