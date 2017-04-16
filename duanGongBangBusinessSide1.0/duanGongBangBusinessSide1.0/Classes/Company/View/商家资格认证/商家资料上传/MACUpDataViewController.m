//
//  MACUpDataViewController.m
//  duangongbang
//
//  Created by ljx on 16/4/6.
//  Copyright © 2016年 duangongbang. All rights reserved.
//

#import "MACUpDataViewController.h"
#import "MerchantCATitleview.h"
#import "PublishMCViewController.h"
#import "MerchantCATitleview.h"
#import "PublishMCViewController.h"

@interface MACUpDataViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UIScrollView * ScrollView;
    MerchantCATitleview * MerchantCAV;
    NSArray * array ;

}


@property (nonatomic, weak) UIView *navBackView;

@property (nonatomic, strong) UITableView * UpDataTabview;

@end

@implementation MACUpDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  backv  UIImageView
    
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
    
    //  Nav  text

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"商家资质认证";
    self.navigationItem.titleView = label;
    
    

    if ([self.Type isEqualToString:@"1"]) {
        array = @[@"请拍照上传组织机构代码证(正面)"];
    }
    else if ([self.Type isEqualToString:@"2"])
    {
        array = @[@"请拍照上传您的手持身份证半身照",@"请拍照上传您的手持身份证(正面)",@"请拍照上传您的手持身份证(背面)"];
    }
    else if ([self.Type isEqualToString:@"3"])
    {
        array = @[@"请拍照拍照上传公司营业执照(正面)"];
    }
    else if ([self.Type isEqualToString:@"4"])
    {
        array = @[@"请拍照拍照上传团队负责人手持身份证半身照",@"请拍照上传团队负责人身份证(正面)",@"请拍照上传团队负责人手持身份证(背面)"];
    }
    
    
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

- (void)GONext
{
    PublishMCViewController * PublishMC = [[PublishMCViewController alloc] init];
    [self.navigationController pushViewController:PublishMC animated:YES];
}
#pragma -mark Tabview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count + 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Datawrite_one"];
        
        [MerchantCAV removeFromSuperview];
        MerchantCAV = [[MerchantCATitleview alloc] initWithFrame:CGRectMake(0, 6, Width, 37) andTYpe:@"2"];
        [cell.contentView addSubview:MerchantCAV];
        
    }
    else if (indexPath.row == array.count + 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Datawrite_four"];
        
        UIButton * btn = (UIButton *)[cell viewWithTag:1063];
        [btn addTarget:self action:@selector(Gobtn) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"UpDataCell"];
        
        UILabel * text = (UILabel *)[cell viewWithTag:1070];
        UIImageView * img = (UIImageView *)[cell viewWithTag:1072];
        UIImageView * imgcentre = (UIImageView *)[cell viewWithTag:1073];
        
        
        text.text = [array objectAtIndex:indexPath.row - 1];
        
        
        
    }

    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 56;
    }
    else if (indexPath.row == array.count + 1)
    {
        return 90;
    }
    else
    {
        return 250;
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat alaph = (scrollView.contentOffset.y + 64) / 64;
    alaph = alaph < 0 ? 0 : alaph;
    if (alaph > 0.85) {
        alaph = 0.85;
    }
    _navBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alaph];
}

#pragma mark - setUI

- (void)setUI
{
    
    self.UpDataTabview = [[UITableView alloc] initWithFrame:self.view.frame];
    self.UpDataTabview.backgroundColor = [UIColor clearColor];
    self.UpDataTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.UpDataTabview.delegate = self;
    self.UpDataTabview.dataSource = self;
    [self.view addSubview:self.UpDataTabview];
    [self.UpDataTabview registerNib:[UINib nibWithNibName:@"Datawrite_one" bundle:nil] forCellReuseIdentifier:@"Datawrite_one"];
    [self.UpDataTabview registerNib:[UINib nibWithNibName:@"UpDataCell" bundle:nil] forCellReuseIdentifier:@"UpDataCell"];
    [self.UpDataTabview registerNib:[UINib nibWithNibName:@"Datawrite_four" bundle:nil] forCellReuseIdentifier:@"Datawrite_four"];
    self.UpDataTabview.contentInset = UIEdgeInsetsMake(64, 0, tabBarheight, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;

    
//    ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, Width, Height)];
//    ScrollView.delegate = self;
//    [self.view addSubview:ScrollView];
//    ScrollView.contentSize = CGSizeMake(Width, Height + 1);
//    
//    
//    MerchantCATitleview * MerchantCAV = [[MerchantCATitleview alloc] initWithFrame:CGRectMake(0, 6, Width, 37) andTYpe:@"2"];
//    [ScrollView addSubview:MerchantCAV];
//    
//    UILabel *labeltext = [[UILabel alloc] initWithFrame:CGRectMake(0, MerchantCAV.frame.size.height + MerchantCAV.frame.origin.y + 12, Width, 40)];
//    labeltext.backgroundColor = [UIColor clearColor];
//    labeltext.font = [UIFont systemFontOfSize:15];
//    labeltext.textAlignment = NSTextAlignmentCenter;
//    labeltext.textColor = [UIColor whiteColor];
//    if([self.Type isEqualToString:@"1"])
//    {
//        labeltext.text = @"请拍照上传组织机构代码证(正面)";
//    }
//    else if([self.Type isEqualToString:@"2"])
//    {
//        labeltext.text = @"请拍照上传您的手持身份证半身照";
//    }
//    else if([self.Type isEqualToString:@"3"])
//    {
//        labeltext.text = @"请拍照拍照上传公司营业执照(正面)";
//    }
//    else if([self.Type isEqualToString:@"4"])
//    {
//        labeltext.text = @"请拍照拍照上传团队负责人手持身份证半身照";
//    }
//    [ScrollView addSubview:labeltext];
//    
//    
//    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(24, labeltext.frame.size.height + labeltext.frame.origin.y, Width - 48, 202)];
//    CAShapeLayer *borderLayer = [CAShapeLayer layer];
//    borderLayer.bounds = CGRectMake(0, 0, img.frame.size.width, img.frame.size.height);
//    borderLayer.position = CGPointMake(CGRectGetMidX(img.bounds), CGRectGetMidY(img.bounds));
//    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:4].CGPath;
//    borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale];
//    //虚线边框
//    borderLayer.lineDashPattern = @[@8, @8];
//    //实线边框
//    borderLayer.fillColor = [UIColor clearColor].CGColor;
//    borderLayer.strokeColor = [UIColor whiteColor].CGColor;
//    [img.layer addSublayer:borderLayer];
//    
//    [ScrollView addSubview:img];
//    
//    
//    UIImageView * centreimg = [[UIImageView alloc] initWithFrame:CGRectMake(img.frame.size.width/2 - 10, img.frame.size.height/2 - 10, 20, 20)];
//    centreimg.image = [UIImage imageNamed:@"中心加号"];
//    [img addSubview:centreimg];
//    
//    
//    if([self.Type isEqualToString:@"2"] || [self.Type isEqualToString:@"4"])
//    {
//    
//    
//    }
//    
//    
//    
//    UIButton * Next = [UIButton buttonWithType:UIButtonTypeSystem];
//    Next.frame = CGRectMake(Width/2 - 128, img.frame.origin.y + img.frame.size.height, 256, 90);
//    [Next setTitle:@"下一步" forState:UIControlStateNormal];
//    [Next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [Next setImage:[[UIImage imageNamed:@"蓝色L按钮_"]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
//    [Next addTarget:self action:@selector(GONext) forControlEvents:UIControlEventTouchUpInside];
//    [ScrollView addSubview:Next];
//    Next.titleEdgeInsets = UIEdgeInsetsMake(- 13, -Next.bounds.size.width + 12, 0, 0);
//    Next.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);

}
- (void)Gobtn
{
    PublishMCViewController * PublishMCVC = [[PublishMCViewController alloc] init];
    [self.navigationController pushViewController:PublishMCVC animated:YES];
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
