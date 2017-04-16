//
//  MerchantACMianViewController.m
//  duangongbang
//
//  Created by ljx on 16/4/6.
//  Copyright © 2016年 duangongbang. All rights reserved.
//

#import "MerchantACMianViewController.h"

#import "MerchantCADatafillinViewController.h"


@interface MerchantACMianViewController ()<UIScrollViewDelegate>
{
    UIScrollView * ScrollView;
    
//    UIImageView *navBarHairlineImageView;
}




@property (nonatomic, weak) UIView *navBackView;

@end

@implementation MerchantACMianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * backv = [[UIImageView alloc] initWithFrame:self.view.frame];
    backv.image = [[UIImage imageNamed:@"背景图.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.view addSubview:backv];
    
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
    label.font = [UIFont boldSystemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"发现";//商家资质认证
    self.navigationItem.titleView = label;
    
    
    [self setUI];
}

#pragma mark - methods

-(void)getBackView:(UIView*)superView
{
    if ([superView isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]){
        _navBackView = superView;
        //在这里可设置背景色
        //                _navBackView.backgroundColor = UIColorFromRGB(xMainBlueColor);
    }else if ([superView isKindOfClass:NSClassFromString(@"_UIBackdropView")]){
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

    //设置返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(backPop)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
        
//    CGFloat alaph = (ScrollView.contentOffset.y - 64) / 64;
//    alaph = alaph < 0 ? 0 : alaph;
//    if (alaph > 0.85) {
//        alaph = 0.85;
//    }
//    _navBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alaph];
}

#pragma mark - UIButton Tap

- (void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)GOtoapplyfor
{
    MerchantCADatafillinViewController * Datafillin = [[MerchantCADatafillinViewController alloc] init];
//    Datafillin.Type = @"2";
    Datafillin.Type = [NSString stringWithFormat:@"%d",arc4random()%4 + 1];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:Datafillin];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat alaph = (scrollView.contentOffset.y) / 64;
    alaph = alaph < 0 ? 0 : alaph;
    if (alaph > 0.9) {
        alaph = 0.9;
    }
    _navBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alaph];
}

#pragma mark - setUI

- (void)setUI
{
    ScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    ScrollView.delegate = self;
    [self.view addSubview:ScrollView];
    ScrollView.contentSize = CGSizeMake(Width, Height + 1);
//    ScrollView.contentInset = UIEdgeInsetsMake(64, 0, tabBarheight, 0);
//    ScrollView.contentOffset = CGPointMake(0, 0);
//    self.automaticallyAdjustsScrollViewInsets = NO;

    
    UILabel *labeltext = [[UILabel alloc] initWithFrame:CGRectMake(0, 74, Width, 55)];
    labeltext.backgroundColor = [UIColor clearColor];
    labeltext.font = [UIFont systemFontOfSize:17];
    labeltext.textAlignment = NSTextAlignmentCenter;
    labeltext.textColor = [UIColor whiteColor];
    labeltext.text = @"认证商家拥有的四大特权";
    [ScrollView addSubview:labeltext];
    
    
    UIImageView * one = [[UIImageView  alloc] initWithFrame:CGRectMake(Width/2 - 115, labeltext.frame.origin.y + labeltext.frame.size.height , 100, 100)];
    one.image = [UIImage imageNamed:@"无需审核logo"];
    [ScrollView addSubview:one];
    
    UIImageView * tow = [[UIImageView  alloc] initWithFrame:CGRectMake(Width/2 + 15, labeltext.frame.origin.y + labeltext.frame.size.height, 100, 100)];
    tow.image = [UIImage imageNamed:@"筛选用户"];
    [ScrollView addSubview:tow];
    
    
    
    UILabel * text1 = [[UILabel alloc] initWithFrame:CGRectMake(Width/2 - 128, one.frame.origin.y + one.frame.size.height, 128, 40)];
    text1.font = [UIFont systemFontOfSize:12];
    text1.text = @"发布兼职无需审核";
    text1.textColor = [UIColor whiteColor];
    text1.textAlignment = NSTextAlignmentCenter;
    [ScrollView addSubview:text1];
    
    
    UILabel * text2 = [[UILabel alloc] initWithFrame:CGRectMake(Width/2, tow.frame.origin.y + tow.frame.size.height, 128, 40)];
    text2.font = [UIFont systemFontOfSize:12];
    text2.text = @"筛选用户精准推送";
    text2.textColor = [UIColor whiteColor];
    text2.textAlignment = NSTextAlignmentCenter;
    [ScrollView addSubview:text2];
    
    
    UIImageView * three = [[UIImageView  alloc] initWithFrame:CGRectMake(Width/2 - 115,text1.frame.origin.y + text1.frame.size.height, 100, 100)];
    three.image = [UIImage imageNamed:@"品牌曝光度"];
    [ScrollView addSubview:three];
    
    UIImageView * four = [[UIImageView  alloc] initWithFrame:CGRectMake(Width/2 + 15, text2.frame.origin.y + text2.frame.size.height, 100, 100)];
    four.image = [UIImage imageNamed:@"人才库"];
    [ScrollView addSubview:four];
    
    
    
    UILabel * text3 = [[UILabel alloc] initWithFrame:CGRectMake(Width/2 - 128, three.frame.origin.y + three.frame.size.height, 128, 40)];
    text3.font = [UIFont systemFontOfSize:12];
    text3.text = @"拥有专属人才库";
    text3.textColor = [UIColor whiteColor];
    text3.textAlignment = NSTextAlignmentCenter;
    [ScrollView addSubview:text3];
    
    
    UILabel * text4 = [[UILabel alloc] initWithFrame:CGRectMake(Width/2, four.frame.origin.y + four.frame.size.height, 128, 40)];
    text4.font = [UIFont systemFontOfSize:12];
    text4.text = @"提高品牌曝光度";
    text4.textColor = [UIColor whiteColor];
    text4.textAlignment = NSTextAlignmentCenter;
    [ScrollView addSubview:text4];
    
    
    UIButton * GOapplyfor = [UIButton buttonWithType:UIButtonTypeSystem];
    GOapplyfor.frame = CGRectMake(Width/2 - 128, text4.frame.origin.y + text4.frame.size.height, 256, 90);
    [GOapplyfor setTitle:@"立即申请" forState:UIControlStateNormal];
    [GOapplyfor setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    GOapplyfor.layer.cornerRadius = 22.5;
    [GOapplyfor setImage:[[UIImage imageNamed:@"蓝色L按钮_"]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [GOapplyfor addTarget:self action:@selector(GOtoapplyfor) forControlEvents:UIControlEventTouchUpInside];
    [ScrollView addSubview:GOapplyfor];
    GOapplyfor.titleEdgeInsets = UIEdgeInsetsMake(- 13, -GOapplyfor.bounds.size.width + 12, 0, 0);
    //设置title在button上的位置（上top，左left，下bottom，右right）
    GOapplyfor.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);

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
