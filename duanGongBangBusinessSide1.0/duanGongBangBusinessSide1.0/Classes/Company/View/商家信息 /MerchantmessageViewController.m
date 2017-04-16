//
//  MerchantmessageViewController.m
//  duanGongBangBusinessSide1.0
//
//  Created by ljx on 16/4/15.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "MerchantmessageViewController.h"
#import "wtButton.h"
#import "PlaceholderTextView.h"
#import "STPickerSingle.h"



#define UIColor204 [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
#define UIColor229 [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];

@interface MerchantmessageViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,PlaceholderTextH,STPickerSingleDelegate>
{

    //数据源
    NSMutableArray * array_one;
    UIBarButtonItem *rightItem;
    NSMutableArray * array_tow;

    
    NSString * array_three;
    
    float SendJob_threeHeight;
    float SendJob_towHeight;

}


@property (nonatomic, weak) UIView *navBackView;
@property (nonatomic, strong) UITableView * MessageTabview;

@end

@implementation MerchantmessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * backv = [[UIImageView alloc] initWithFrame:self.view.frame];
    backv.image = [[UIImage imageNamed:@"bgmessage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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
    
    
    //设置返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(backPop)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    rightItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editToUser)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    [self getBackView:self.navigationController.navigationBar];

    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

    //  Nav  text
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"商家信息";
    self.navigationItem.titleView = label;

    
    SendJob_threeHeight=150;
    SendJob_towHeight = 162;
    array_one = [NSMutableArray arrayWithObjects:@"个人",@"",@"",@"",@"",nil];
    array_three = @"";
    array_tow = [NSMutableArray arrayWithObjects:@"",@"", nil];

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
    self.tabBarController.tabBar.hidden = YES;

//    CGFloat alaph = (self.MessageTabview.contentOffset.y + 64) / 64;
//    alaph = alaph < 0 ? 0 : alaph;
//    if (alaph > 0.85) {
//        alaph = 0.85;
//    }
//    _navBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alaph];
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

#pragma mark - UIButton Tap

- (void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma -mark Tabview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"McmessageCell"];
        
        [self addCellview1:cell andindexPath:indexPath];
    }
    else if (indexPath.row == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SendJob_tow"];
        
        cell.layer.cornerRadius = 4;
        
        
        
        UIButton * worklocatorTap = (UIButton *)[cell viewWithTag:1010];
        worklocatorTap.layer.borderWidth = 0.8;
        worklocatorTap.layer.cornerRadius = 4;
        worklocatorTap.layer.borderColor = [UIColor colorWithRed:2/255.0 green:168/255.0 blue:243/255.0 alpha:1].CGColor;
        [worklocatorTap addTarget:self action:@selector(worklocatorTap) forControlEvents:UIControlEventTouchUpInside];
        UIButton * workRegionalTap = (UIButton *)[cell viewWithTag:1013];
        [workRegionalTap addTarget:self action:@selector(workRegionalTap) forControlEvents:UIControlEventTouchUpInside];
        UILabel * workRegional = (UILabel *)[cell viewWithTag:1011];
        workRegional.text = [array_tow objectAtIndex:0];
       
        
        PlaceholderTextView * address = (PlaceholderTextView *)[cell viewWithTag:1022];
        address.text = [array_tow objectAtIndex:1];
        address.Type = @"Mc";
        address.placeholder=@"请输入地址详情";
        address.font=[UIFont systemFontOfSize:15];
        address.placeholderColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        address.placeholderFont=[UIFont boldSystemFontOfSize:15];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:address.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:7];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, address.text.length)];
        address.attributedText = attributedString;
        address.textAlignment = NSTextAlignmentRight;
        address.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        address.returnKeyType = UIReturnKeyDone;
        address.font=[UIFont systemFontOfSize:15];
        address.delegate_TextH = self;
        address.btnIndexPath = indexPath;

        
        
        UIView * line5 = (UIView *)[cell viewWithTag:1124];
        UIView * line6 = (UIView *)[cell viewWithTag:1125];
        UIView * line7 = (UIView *)[cell viewWithTag:1126];

        
        if ([rightItem.title isEqualToString:@"编辑"]) {
            address.editable = NO;
            line5.backgroundColor = UIColor229;
            line6.backgroundColor = UIColor229;
            line7.backgroundColor = UIColor229;

        }
        else
        {
            address.editable = YES;
            line5.backgroundColor = UIColor204;
            line6.backgroundColor = UIColor204;
            line7.backgroundColor = UIColor204;
        }


    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SendJob_three"];
        
        
        UIView * backview = (UIView *)[cell viewWithTag:1123];
        backview.layer.cornerRadius = 4;
        
        PlaceholderTextView * PlaceholderText = (PlaceholderTextView *)[cell viewWithTag:1012];
        PlaceholderText.Type = @"Mc";
        PlaceholderText.text = array_three;
        PlaceholderText.placeholder=@"请输入工作详情";
        PlaceholderText.font=[UIFont systemFontOfSize:15];
        PlaceholderText.placeholderFont=[UIFont boldSystemFontOfSize:15];
        PlaceholderText.placeholderColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:PlaceholderText.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:7];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, PlaceholderText.text.length)];
        PlaceholderText.attributedText = attributedString;
        PlaceholderText.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        PlaceholderText.layer.borderWidth=1;
        PlaceholderText.layer.cornerRadius = 4;
        PlaceholderText.layer.borderColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1].CGColor;
        PlaceholderText.font=[UIFont systemFontOfSize:15];
        PlaceholderText.returnKeyType = UIReturnKeyDone;
        PlaceholderText.delegate_TextH = self;
        PlaceholderText.btnIndexPath = indexPath;
        if ([rightItem.title isEqualToString:@"编辑"]) {
            PlaceholderText.editable = NO;
        }
        else
        {
            PlaceholderText.editable = YES;

        }
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 409;
    }
    else if(indexPath.row == 1)
    {
        return SendJob_towHeight;
    }
    else
    {
        return SendJob_threeHeight;
    }
}
#pragma mark - setUI

- (void)setUI
{
    self.MessageTabview = [[UITableView alloc] initWithFrame:CGRectMake(12, 0, Width - 24, self.view.frame.size.height)];
    self.MessageTabview.backgroundColor = [UIColor clearColor];
    self.MessageTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.MessageTabview.delegate = self;
    self.MessageTabview.dataSource = self;
    self.MessageTabview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.MessageTabview];
    [self.MessageTabview registerNib:[UINib nibWithNibName:@"SendJob_three" bundle:nil] forCellReuseIdentifier:@"SendJob_three"];
    [self.MessageTabview registerNib:[UINib nibWithNibName:@"SendJob_tow" bundle:nil] forCellReuseIdentifier:@"SendJob_tow"];
    [self.MessageTabview registerNib:[UINib nibWithNibName:@"McmessageCell" bundle:nil] forCellReuseIdentifier:@"McmessageCell"];
    self.MessageTabview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}
- (void)editToUser
{
    if ([rightItem.title isEqualToString:@"编辑"]) {
        rightItem.title  = @"完成";
    }
    else
    {
        rightItem.title  = @"编辑";
    }
    
    [self.MessageTabview reloadData];
}
- (void)GoAc
{

}
- (void)worklocatorTap
{

}
- (void)workRegionalTap
{

}
- (void)btn1:(wtButton *)sender
{
    NSMutableArray * arr;
    arr = [NSMutableArray arrayWithObjects:@"个人",@"组织",@"公司",nil];
    [self showPickerTitle:@"请选择账号主体" andArrayData:arr andTitleUnit:@"" andbtntag:sender];
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
    [self.MessageTabview reloadRowsAtIndexPaths:@[btn.btnIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    
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
    [array_one removeObjectAtIndex:0];
    [array_one insertObject:selectedTitle atIndex:0];
    [self.MessageTabview reloadRowsAtIndexPaths:@[pickerSingle.btnIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)textfieldChangeTotext:(UITextField *)textfield
{
    [array_one removeObjectAtIndex:textfield.tag - 1113];
    [array_one insertObject:textfield.text atIndex:textfield.tag - 1113];
}
/***************************************************************************
 * 方法名称：refreshlaceholderTextH
 * 功能描述：输入文字增长cell
 * 输入参数：
 * 输出参数：
 * 返回值：
 * 其它说明：
 ***************************************************************************/
- (void)refreshlaceholderTextH:(float)TextH andIndexPath:(NSIndexPath *)IndexPath andtext:(NSString *)text andtag:(NSInteger)tag
{
    if (tag == 1012) {
        array_three = text;
        if (TextH > 50) {
            SendJob_threeHeight = 150 + TextH - 35;
        }
        else
        {
            SendJob_threeHeight = 150;
        }
    }
    else if(tag == 1022){
        [array_tow removeObjectAtIndex:1];
        [array_tow insertObject:text atIndex:1];
        if (TextH > 30) {
            SendJob_towHeight = 162 + TextH - 25;
        }
        else
        {
            SendJob_towHeight = 162;
        }
    }
    [self.MessageTabview reloadRowsAtIndexPaths:@[IndexPath] withRowAnimation:UITableViewRowAnimationNone];
}
/***************************************************************************
 * 方法名称：addCellview1
 * 功能描述：cell 配置
 * 输入参数：
 * 输出参数：
 * 返回值：
 * 其它说明：
 ***************************************************************************/

- (void)addCellview1:(UITableViewCell *)cell andindexPath:(NSIndexPath *)indexPath
{
    
    UIButton * GoAc = (UIButton *)[cell viewWithTag:1110];
    UIImageView * headimg = (UIImageView *)[cell viewWithTag:1111];
    
    UILabel * lable1 = (UILabel *)[cell viewWithTag:1112];
    wtButton * btn1 = (wtButton *)[cell viewWithTag:1113];
    btn1.btnIndexPath = indexPath;
    UITextField * textfield1 = (UITextField *)[cell viewWithTag:1114];
    UITextField * textfield2 = (UITextField *)[cell viewWithTag:1115];
    UITextField * textfield3 = (UITextField *)[cell viewWithTag:1116];
    UITextField * textfield4 = (UITextField *)[cell viewWithTag:1117];
    
    
    
    UIView * line1 = (UIView *)[cell viewWithTag:1118];
    UIView * line2 = (UIView *)[cell viewWithTag:1119];
    UIView * line3 = (UIView *)[cell viewWithTag:1120];
    UIView * line4 = (UIView *)[cell viewWithTag:1121];
    UIView * line5 = (UIView *)[cell viewWithTag:1122];
    if ([rightItem.title isEqualToString:@"编辑"]) {
        line1.backgroundColor = UIColor229;
        line2.backgroundColor = UIColor229;
        line3.backgroundColor = UIColor229;
        line4.backgroundColor = UIColor229;
        line5.backgroundColor = UIColor229;
        textfield1.enabled = NO;
        textfield1.enabled = NO;
        textfield1.enabled = NO;
        textfield1.enabled = NO;
    }else
    {
        line1.backgroundColor = UIColor204;
        line2.backgroundColor = UIColor204;
        line3.backgroundColor = UIColor204;
        line4.backgroundColor = UIColor204;
        line5.backgroundColor = UIColor204;
        textfield1.enabled = YES;
        textfield1.enabled = YES;
        textfield1.enabled = YES;
        textfield1.enabled = YES;
    }

    
    [GoAc addTarget:self action:@selector(GoAc) forControlEvents:UIControlEventTouchUpInside];
    [btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    [textfield1 addTarget:self action:@selector(textfieldChangeTotext:) forControlEvents:UIControlEventEditingChanged];
    [textfield2 addTarget:self action:@selector(textfieldChangeTotext:) forControlEvents:UIControlEventEditingChanged];
    [textfield3 addTarget:self action:@selector(textfieldChangeTotext:) forControlEvents:UIControlEventEditingChanged];
    [textfield4 addTarget:self action:@selector(textfieldChangeTotext:) forControlEvents:UIControlEventEditingChanged];
    
    
    
    lable1.text = [array_one objectAtIndex:0];
    textfield1.text = [array_one objectAtIndex:1];
    textfield2.text = [array_one objectAtIndex:2];
    textfield3.text = [array_one objectAtIndex:3];
    textfield4.text = [array_one objectAtIndex:4];

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
