//
//  PublishMCViewController.m
//  duangongbang
//
//  Created by ljx on 16/4/7.
//  Copyright © 2016年 duangongbang. All rights reserved.
//

#import "PublishMCViewController.h"
#import "MerchantCATitleview.h"
@interface PublishMCViewController ()<UIScrollViewDelegate>
{
    UIScrollView * ScrollView;
}
@property (nonatomic, weak) UIView *navBackView;

@end

@implementation PublishMCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * backv = [[UIImageView alloc] initWithFrame:self.view.frame];
    backv.image = [[UIImage imageNamed:@"背景图.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.view addSubview:backv];
    //     setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    
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
    label.text = @"商家发布认证";
    self.navigationItem.titleView = label;
    
    
    [self setUI];
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
    
    //设置返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"顶部_关闭"] style:UIBarButtonItemStylePlain target:self action:@selector(backPop)];
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
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)GOok
{
    
}
#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat alaph = (scrollView.contentOffset.y) / 64;
    alaph = alaph < 0 ? 0 : alaph;
    if (alaph > 0.85) {
        alaph = 0.85;
    }
    _navBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alaph];
}
#pragma mark - setUI

- (void)setUI
{
    ScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    ScrollView.delegate = self;
    [self.view addSubview:ScrollView];
    ScrollView.contentSize = CGSizeMake(Width, Height + 1 );
//    ScrollView.contentInset = UIEdgeInsetsMake(64, 0, tabBarheight, 0);
//    self.automaticallyAdjustsScrollViewInsets = NO;

    
    MerchantCATitleview * MerchantCAV = [[MerchantCATitleview alloc] initWithFrame:CGRectMake(0, 70, Width, 37) andTYpe:@"3"];
    [ScrollView addSubview:MerchantCAV];
    
    
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(Width/2 - 70, MerchantCAV.frame.origin.y + MerchantCAV.frame.size.height + 43, 140, 140)];
    img.image = [[UIImage imageNamed:@"大图标"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [ScrollView addSubview:img];
    
    
    UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(Width/2 - 130, img.frame.origin.y + img.frame.size.height + 43, 260, 60)];
    lab.text = @"请您耐心等待，一般24小时内能完成审\n核。认证审核期间不影响工作的发布与\n审核";
    lab.font = [UIFont systemFontOfSize:15];
    lab.numberOfLines = 0;
    lab.textColor = [UIColor whiteColor];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:lab.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:7];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, lab.text.length)];
    lab.attributedText = attributedString;
    lab.textAlignment = NSTextAlignmentCenter;
    [lab sizeToFit];
    [ScrollView addSubview:lab];
    
    UIButton * Next = [UIButton buttonWithType:UIButtonTypeSystem];
    Next.frame = CGRectMake(Width/2 - 128, lab.frame.origin.y + lab.frame.size.height, 256, 90);
    [Next setTitle:@"完成" forState:UIControlStateNormal];
    [Next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    Next.layer.cornerRadius = 22.5;
    [Next setImage:[[UIImage imageNamed:@"蓝色L按钮_"]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [Next addTarget:self action:@selector(GOok) forControlEvents:UIControlEventTouchUpInside];
    [ScrollView addSubview:Next];
    Next.titleEdgeInsets = UIEdgeInsetsMake(- 13, -Next.bounds.size.width + 12, 0, 0);
    //设置title在button上的位置（上top，左left，下bottom，右right）
    Next.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);

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
