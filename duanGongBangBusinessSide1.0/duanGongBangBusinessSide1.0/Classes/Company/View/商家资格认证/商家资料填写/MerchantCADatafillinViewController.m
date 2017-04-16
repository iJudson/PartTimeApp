//
//  MerchantCADatafillinViewController.m
//  duanGongBangBusinessSide1.0
//
//  Created by ljx on 16/4/14.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "MerchantCADatafillinViewController.h"
#import "MerchantCATitleview.h"
#import "STPickerSingle.h"
#import "wtButton.h"
#import "MACUpDataViewController.h"

@interface MerchantCADatafillinViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,STPickerSingleDelegate>
{
    UIScrollView * ScrollView;
    MerchantCATitleview * MerchantCAV;
    NSArray * titleText;
    NSMutableArray * hinttitleText;
    
    
    
    
    UITextField * TextField1;
    UITextField * TextField2;
    UITextField * TextField3;
    UITextField * TextField4;

    
    
    NSString * Text1;
    NSString * Text2;
    NSString * Text3;
    NSString * Text4;


}
@property (nonatomic, weak) UIView *navBackView;
@property (nonatomic, strong) UITableView * DataWriteTabview;

@end

@implementation MerchantCADatafillinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  backv  UIImageView
    if ([self.Type isEqualToString:@"1"]) {
        titleText = @[@"机构名称",@"机构代码",@"所属行业",@"负责人号码",@""];
        hinttitleText = [NSMutableArray arrayWithObjects:@"请选择",@"",@"", nil];
    }
    else if ([self.Type isEqualToString:@"2"])
    {
        titleText = @[@"姓名",@"身份证号",@"所属行业",@"",@""];
        hinttitleText = [NSMutableArray arrayWithObjects:@"请选择",@"",@"", nil];

    }
    else if ([self.Type isEqualToString:@"3"])
    {
        titleText = @[@"机构名称",@"执照编号",@"所属行业",@"机构性质",@"机构规模"];
        hinttitleText = [NSMutableArray arrayWithObjects:@"请选择",@"请选择",@"请选择", nil];
    }
    else
    {
        titleText = @[@"机构名称",@"身份证号",@"所属行业",@"负责人号码",@""];
        hinttitleText = [NSMutableArray arrayWithObjects:@"请选择",@"",@"", nil];
    }
   Text1 = @"";
   Text2 = @"";
   Text3 = @"";
   Text4 = @"";

    
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
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
//    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
//    self.navigationController.navigationBar.alpha = .9;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    //设置返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"顶部_关闭"] style:UIBarButtonItemStylePlain target:self action:@selector(backPop)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
//    CGFloat alaph = (ScrollView.contentOffset.y + 84) / 64;
//    alaph = alaph < 0 ? 0 : alaph;
//    if (alaph > 0.9) {
//        alaph = 0.9;
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
//    PublishMCViewController * PublishMC = [[PublishMCViewController alloc] init];
//    [self.navigationController pushViewController:PublishMC animated:YES];
}


#pragma -mark Tabview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Datawrite_one"];
        
        [MerchantCAV removeFromSuperview];
        MerchantCAV = [[MerchantCATitleview alloc] initWithFrame:CGRectMake(0, 6, Width, 37) andTYpe:@"1"];
        [cell.contentView addSubview:MerchantCAV];

    }
    else if (indexPath.row == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Datawrite_tow"];
        
        UILabel * lab1 = (UILabel *)[cell viewWithTag:1050];
        UILabel * lab2 = (UILabel *)[cell viewWithTag:1051];
        UILabel * lab3 = (UILabel *)[cell viewWithTag:1052];
        UILabel * lab4 = (UILabel *)[cell viewWithTag:1055];
        UILabel * lab5 = (UILabel *)[cell viewWithTag:1058];
        
        UILabel * hintlab1 = (UILabel *)[cell viewWithTag:1053];
        UILabel * hintlab2 = (UILabel *)[cell viewWithTag:1056];
        UILabel * hintlab3 = (UILabel *)[cell viewWithTag:1059];

        wtButton * btn1 = (wtButton *)[cell viewWithTag:1054];
        btn1.btnIndexPath = indexPath;
        wtButton * btn2 = (wtButton *)[cell viewWithTag:1057];
        btn2.btnIndexPath = indexPath;
        wtButton * btn3 = (wtButton *)[cell viewWithTag:1060];
        btn3.btnIndexPath = indexPath;

        if (![self.Type isEqualToString:@"3"]) {
            UIImageView * img1 = (UIImageView *)[cell viewWithTag:1061];
            UIImageView * img2 = (UIImageView *)[cell viewWithTag:1062];
            img1.hidden = YES;
            img2.hidden = YES;
        }

        
        lab1.text = [titleText objectAtIndex:0];
        lab2.text = [titleText objectAtIndex:1];
        lab3.text = [titleText objectAtIndex:2];
        lab4.text = [titleText objectAtIndex:3];
        lab5.text = [titleText objectAtIndex:4];
        hintlab1.text = [hinttitleText objectAtIndex:0];
        hintlab2.text = [hinttitleText objectAtIndex:1];
        hintlab3.text = [hinttitleText objectAtIndex:2];

        
        [btn1 addTarget:self action:@selector(BtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 addTarget:self action:@selector(BtnTap:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 addTarget:self action:@selector(BtnTap:) forControlEvents:UIControlEventTouchUpInside];

        [self addCellviewUI:cell andindexPath:indexPath];

    }
    else if (indexPath.row == 2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Datawrite_three"];

    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Datawrite_four"];
        
        UIButton * btn = (UIButton *)[cell viewWithTag:1063];
        [btn addTarget:self action:@selector(Gobtn) forControlEvents:UIControlEventTouchUpInside];
    }

    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 56;
    }
    else if(indexPath.row == 1)
    {
        if ([self.Type isEqualToString:@"1"] || [self.Type isEqualToString:@"4"]) {
            return 212;
        }
        else if ([self.Type isEqualToString:@"2"])
        {
            return 162;
        }
        else
        {
            return 262;
        }
    }
    else if(indexPath.row == 2)
    {
        return 206;
    }
    else
    {
        return 90;
    }
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat alaph = (scrollView.contentOffset.y + 64) / 64;
    alaph = alaph < 0 ? 0 : alaph;
    if (alaph > 0.9) {
        alaph = 0.9;
    }
    _navBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alaph];

}

#pragma mark - setUI

- (void)setUI
{
    self.DataWriteTabview = [[UITableView alloc] initWithFrame:self.view.frame];
    self.DataWriteTabview.backgroundColor = [UIColor clearColor];
    self.DataWriteTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.DataWriteTabview.delegate = self;
    self.DataWriteTabview.dataSource = self;
    [self.view addSubview:self.DataWriteTabview];
    [self.DataWriteTabview registerNib:[UINib nibWithNibName:@"Datawrite_one" bundle:nil] forCellReuseIdentifier:@"Datawrite_one"];
    [self.DataWriteTabview registerNib:[UINib nibWithNibName:@"Datawrite_tow" bundle:nil] forCellReuseIdentifier:@"Datawrite_tow"];
    [self.DataWriteTabview registerNib:[UINib nibWithNibName:@"Datawrite_three" bundle:nil] forCellReuseIdentifier:@"Datawrite_three"];
    [self.DataWriteTabview registerNib:[UINib nibWithNibName:@"Datawrite_four" bundle:nil] forCellReuseIdentifier:@"Datawrite_four"];
    self.DataWriteTabview.contentInset = UIEdgeInsetsMake(64, 0, tabBarheight, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;

}

/***************************************************************************
 * 方法名称：addCellview1
 * 功能描述：cell 配置
 * 输入参数：
 * 输出参数：
 * 返回值：
 * 其它说明：
 ***************************************************************************/

- (void)addCellviewUI:(UITableViewCell *)cell andindexPath:(NSIndexPath *)indexPath
{
    [TextField1 removeFromSuperview];
    TextField1 = [[UITextField alloc] initWithFrame:CGRectMake(Width - 236, 10 , 200, 38)];
    if ([self.Type isEqualToString:@"1"] || [self.Type isEqualToString:@"3"] || [self.Type isEqualToString:@"4"]) {
        TextField1.placeholder = @"请输入机构名称";
    }
    else if ([self.Type isEqualToString:@"2"])
    {
        TextField1.placeholder = @"请输入你的姓名";
    }
    TextField1.font = [UIFont systemFontOfSize:14];
    TextField1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    TextField1.borderStyle = UITextBorderStyleNone;
    TextField1.returnKeyType = UIReturnKeyDone;
    TextField1.textAlignment = NSTextAlignmentRight;
    [TextField1 setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [TextField1 addTarget:self action:@selector(TextChangeTO:) forControlEvents:UIControlEventEditingChanged];
    TextField1.text = Text1;
    [cell.contentView addSubview:TextField1];
    
    
    [TextField2 removeFromSuperview];
    TextField2 = [[UITextField alloc] initWithFrame:CGRectMake(Width - 236, 62 , 200, 38)];
    if ([self.Type isEqualToString:@"1"]) {
        TextField2.placeholder = @"请输入机构代码";
    }
    else if ([self.Type isEqualToString:@"2"])
    {
        TextField2.placeholder = @"请输入你的身份证号";
    }
    else if ([self.Type isEqualToString:@"3"])
    {
        TextField2.placeholder = @"请输入执照编号";
    }
    else if ([self.Type isEqualToString:@"4"])
    {
        TextField2.placeholder = @"请输入负责人身份证号";
    }


    TextField2.font = [UIFont systemFontOfSize:14];
    TextField2.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    TextField2.borderStyle = UITextBorderStyleNone;
    TextField2.returnKeyType = UIReturnKeyDone;
    TextField2.textAlignment = NSTextAlignmentRight;
    [TextField2 setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [TextField2 addTarget:self action:@selector(TextChangeTO:) forControlEvents:UIControlEventEditingChanged];
    TextField2.text = Text2;
    [cell.contentView addSubview:TextField2];
    
    
    if (![self.Type isEqualToString:@"3"]) {
        
    [TextField3 removeFromSuperview];
    TextField3 = [[UITextField alloc] initWithFrame:CGRectMake(Width - 236, 162 , 200, 38)];
    TextField3.placeholder = @"请输入联系人姓名";
    TextField3.font = [UIFont systemFontOfSize:14];
    TextField3.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    TextField3.borderStyle = UITextBorderStyleNone;
    TextField3.returnKeyType = UIReturnKeyDone;
    TextField3.textAlignment = NSTextAlignmentRight;
    [TextField3 setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [TextField3 addTarget:self action:@selector(TextChangeTO:) forControlEvents:UIControlEventEditingChanged];
    TextField3.text = Text3;
    [cell.contentView addSubview:TextField3];
    
    
    [TextField4 removeFromSuperview];
    TextField4 = [[UITextField alloc] initWithFrame:CGRectMake(Width - 236, 214 , 200, 38)];
    TextField4.placeholder = @"请输入联系人姓名";
    TextField4.font = [UIFont systemFontOfSize:14];
    TextField4.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    TextField4.borderStyle = UITextBorderStyleNone;
    TextField4.returnKeyType = UIReturnKeyDone;
    TextField4.textAlignment = NSTextAlignmentRight;
    [TextField4 setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [TextField4 addTarget:self action:@selector(TextChangeTO:) forControlEvents:UIControlEventEditingChanged];
    TextField4.text = Text4;
    [cell.contentView addSubview:TextField4];
        
        
    }

}
- (void)TextChangeTO:(UITextField *)TextField
{
    if ([TextField isEqual:TextField1]) {
        Text1 = TextField.text;
    }
    else if ([TextField isEqual:TextField2])
    {
        Text2 = TextField.text;
    }
    else if ([TextField isEqual:TextField3])
    {
        Text3 = TextField.text;
    }
    else if ([TextField isEqual:TextField4])
    {
        Text4 = TextField.text;
    }
}
- (void)BtnTap:(wtButton *)sender
{
    
//    UIButton * btn1 = (UIButton *)[cell viewWithTag:1054];
//    UIButton * btn2 = (UIButton *)[cell viewWithTag:1057];
//    UIButton * btn3 = (UIButton *)[cell viewWithTag:1060];
    
    NSMutableArray * arr;

    switch (sender.tag) {
        case 1054:
            arr = [NSMutableArray arrayWithObjects:@"每天",@"每周",@"每月",nil];
            [self showPickerTitle:@"请选择工资待遇" andArrayData:arr andTitleUnit:@"" andbtntag:sender];

            break;
        case 1057:
            if ([self.Type isEqualToString:@"3"]) {
                arr = [NSMutableArray arrayWithObjects:@"大企业",@"中企业",@"小企业",nil];
                [self showPickerTitle:@"请选择工资待遇" andArrayData:arr andTitleUnit:@"" andbtntag:sender];
            }
            break;
        case 1060:
            if ([self.Type isEqualToString:@"3"]) {
                arr = [NSMutableArray arrayWithObjects:@"50 <",@"50 - 100",@"> 100",nil];
                [self showPickerTitle:@"请选择工资待遇" andArrayData:arr andTitleUnit:@"" andbtntag:sender];
            }
            break;
        default:
            break;
    }
}

/***************************************************************************
 * 方法名称：showPickerTitle
 * 功能描述：弹出 选择列表
 * 输入参数：Title >>> 选择列表标题  ArrayData >>> 选择列表数据源  btn >>> 点击响应的btn  TitleUnit >>>
 * 输出参数：
 * 返回值：
 * 其它说明：
 ***************************************************************************/
- (void)showPickerTitle:(NSString *)Title andArrayData:(NSMutableArray *)ArrayData andTitleUnit:(NSString *)TitleUnit andbtntag:(wtButton *)btn
{
    
    if ([TextField1 isFirstResponder]) {
        [TextField1 resignFirstResponder];
    }
    else if ([TextField2 isFirstResponder])
    {
        [TextField2 resignFirstResponder];
    }
    else if ([TextField3 isFirstResponder])
    {
        [TextField3 isFirstResponder];
    }
    else if ([TextField4 isFirstResponder])
    {
        [TextField4 isFirstResponder];
    }

    STPickerSingle *single = [[STPickerSingle alloc]init];
    [single setArrayData:ArrayData];
    [single setTitle:Title];
    [single setTitleUnit:TitleUnit];
    [single setBtntag:btn.tag];
    [single setBtnIndexPath:btn.btnIndexPath];
    [single setDelegate:self];
    [single show];
}
/***************************************************************************
 * 方法名称：pickerSingle
 * 功能描述：_SendJobTabview 刷新数据源
 * 输入参数：
 * 输出参数：
 * 返回值：
 * 其它说明：
 ***************************************************************************/

- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle
{
    switch (pickerSingle.btntag) {
        case 1054:
            [hinttitleText removeObjectAtIndex:0];
            [hinttitleText insertObject:selectedTitle atIndex:0];
            break;
        case 1057:
            [hinttitleText removeObjectAtIndex:1];
            [hinttitleText insertObject:selectedTitle atIndex:1];
            break;
        case 1060:
            [hinttitleText removeObjectAtIndex:2];
            [hinttitleText insertObject:selectedTitle atIndex:2];
            break;
        default:
            break;
    }
    [_DataWriteTabview reloadRowsAtIndexPaths:@[pickerSingle.btnIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)Gobtn
{
    MACUpDataViewController * MACUpDataView = [[MACUpDataViewController alloc] init];
    MACUpDataView.Type = self.Type;
    [self.navigationController pushViewController:MACUpDataView animated:YES];
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
