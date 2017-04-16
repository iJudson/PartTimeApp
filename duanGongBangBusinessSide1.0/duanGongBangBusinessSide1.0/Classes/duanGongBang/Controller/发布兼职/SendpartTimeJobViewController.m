//
//  SendpartTimeJobViewController.m
//  duanGongBangBusinessSide1.0
//
//  Created by ljx on 16/4/8.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "SendpartTimeJobViewController.h"
#import "wtButton.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "STPickerSingle.h"
#import "PlaceholderTextView.h"
#import "MySendJobModelViewController.h"

@interface SendpartTimeJobViewController ()<UITableViewDataSource,UITableViewDelegate,STPickerSingleDelegate,UITextViewDelegate,PlaceholderTextH,UIGestureRecognizerDelegate>
{

    //数据源
    NSMutableArray * array_one;
    NSMutableArray * array_tow;
    NSString * array_three;
    NSMutableArray * array_four;
//    NSString * array_five;
    NSString * array_six;

    
    
    UITextField * worktitle;
    UITextField * workmoney;
    UITextField * workpeople;
    
    
    UITextField * worklinkman;
    UITextField * worklinkphone;
    UITextField * worklinkemail;


    float SendJob_threeHeight;
    float SendJob_towHeight;

}
@property (nonatomic, strong) IQKeyboardReturnKeyHandler  *returnKeyHandler;

@property (nonatomic, strong) UITableView * SendJobTabview;
@end

@implementation SendpartTimeJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发布兼职";
    
    UIImageView * backv = [[UIImageView alloc] initWithFrame:self.view.frame];
    backv.image = [[UIImage imageNamed:@"bg2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.view addSubview:backv];

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(backPop)];
    backItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

//
    SendJob_threeHeight=150;
    SendJob_towHeight = 162;
    array_one = [NSMutableArray arrayWithObjects:@"",@"客服",@"",@"每天",@"",@"不限",@"日结",@"", nil];
    array_tow = [NSMutableArray arrayWithObjects:@"",@"", nil];
    array_three = @"";
    array_four = [NSMutableArray arrayWithObjects:@"",@"",@"",@"0",@"0",@"0",@"0", nil];
//    array_five = @"";
    array_six = @"0";
    
    
    self.SendJobTabview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Width, Height - 64)];
    self.SendJobTabview.backgroundColor = [UIColor clearColor];
    self.SendJobTabview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.SendJobTabview.delegate = self;
    self.SendJobTabview.dataSource = self;
    [self.view addSubview:self.SendJobTabview];
    [self.SendJobTabview registerNib:[UINib nibWithNibName:@"SendJob_one" bundle:nil] forCellReuseIdentifier:@"SendJob_one"];
    [self.SendJobTabview registerNib:[UINib nibWithNibName:@"SendJob_tow" bundle:nil] forCellReuseIdentifier:@"SendJob_tow"];
    [self.SendJobTabview registerNib:[UINib nibWithNibName:@"SendJob_three" bundle:nil] forCellReuseIdentifier:@"SendJob_three"];
    [self.SendJobTabview registerNib:[UINib nibWithNibName:@"SendJob_ four" bundle:nil] forCellReuseIdentifier:@"SendJob_ four"];
    [self.SendJobTabview registerNib:[UINib nibWithNibName:@"SendJob_five" bundle:nil] forCellReuseIdentifier:@"SendJob_five"];
    [self.SendJobTabview registerNib:[UINib nibWithNibName:@"SendJob_six" bundle:nil] forCellReuseIdentifier:@"SendJob_six"];
    [self.SendJobTabview registerNib:[UINib nibWithNibName:@"SendJob_seven" bundle:nil] forCellReuseIdentifier:@"SendJob_seven"];

    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    self.returnKeyHandler.toolbarManageBehaviour = IQAutoToolbarBySubviews;

}
#pragma -mark Tabview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView* myView = [[UIView alloc] init];
//    myView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
//    return myView;
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return  10;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SendJob_one"];
        
        [self addCellview1:cell andindexPath:indexPath];

    }
    else if(indexPath.row == 1)
    {
    
        cell = [tableView dequeueReusableCellWithIdentifier:@"SendJob_tow"];
        
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
        address.delegate = self;
        address.font=[UIFont systemFontOfSize:15];
        address.delegate_TextH = self;
        address.btnIndexPath = indexPath;

        
    }
    else if (indexPath.row == 2)
    {
    
        cell = [tableView dequeueReusableCellWithIdentifier:@"SendJob_three"];
        
        PlaceholderTextView * PlaceholderText = (PlaceholderTextView *)[cell viewWithTag:1012];
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
        PlaceholderText.delegate = self;
        PlaceholderText.delegate_TextH = self;
        PlaceholderText.btnIndexPath = indexPath;

    }
    else if (indexPath.row ==3 || indexPath.row ==4 ||indexPath.row ==5)
    {
//        UITextField * worklinkman;
//        UITextField * worklinkphone;
//        UITextField * worklinkemail;
        cell = [tableView dequeueReusableCellWithIdentifier:@"SendJob_ four"];
        UILabel * texthead = (UILabel *)[cell viewWithTag:1020];
        if (indexPath.row ==3) {
            texthead.text = @"联系人";
            
            
            [worklinkman removeFromSuperview];
            worklinkman = [[UITextField alloc] initWithFrame:CGRectMake(Width - 224, 10 , 200, 38)];
            worklinkman.placeholder = @"请输入联系人姓名";
            worklinkman.font = [UIFont systemFontOfSize:14];
            worklinkman.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
            worklinkman.borderStyle = UITextBorderStyleNone;
            //        worktitle.clearButtonMode = UITextFieldViewModeAlways;
            worklinkman.returnKeyType = UIReturnKeyDone;
            worklinkman.textAlignment = NSTextAlignmentRight;
            [worklinkman setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
//            worklinkemail.text = [array_four objectAtIndex:0];
            [cell.contentView addSubview:worklinkman];
            
        }
        else if (indexPath.row ==4)
        {
            texthead.text = @"联系电话";
            
            [worklinkphone removeFromSuperview];
            worklinkphone = [[UITextField alloc] initWithFrame:CGRectMake(Width - 224, 10 , 200, 38)];
            worklinkphone.placeholder = @"请输入联系电话";
            worklinkphone.font = [UIFont systemFontOfSize:14];
            worklinkphone.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
            worklinkphone.borderStyle = UITextBorderStyleNone;
            worklinkphone.keyboardType = UIKeyboardTypeNumberPad;
            //        worktitle.clearButtonMode = UITextFieldViewModeAlways;
            worklinkphone.returnKeyType = UIReturnKeyDone;
            worklinkphone.textAlignment = NSTextAlignmentRight;
            [worklinkphone setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
                        worklinkemail.text = [array_four objectAtIndex:1];
            [cell.contentView addSubview:worklinkphone];
            

        }
        else if (indexPath.row ==5)
        {
            texthead.text = @"联系邮箱";
            
            
            [worklinkemail removeFromSuperview];
            worklinkemail = [[UITextField alloc] initWithFrame:CGRectMake(Width - 224, 10 , 200, 38)];
            worklinkemail.placeholder = @"请输入联系邮箱";
            worklinkemail.font = [UIFont systemFontOfSize:14];
            worklinkemail.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
            worklinkemail.borderStyle = UITextBorderStyleNone;
            worklinkemail.keyboardType = UIKeyboardTypeEmailAddress;

            //        worktitle.clearButtonMode = UITextFieldViewModeAlways;
            worklinkemail.returnKeyType = UIReturnKeyDone;
            worklinkemail.textAlignment = NSTextAlignmentRight;
            [worklinkemail setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
                        worklinkemail.text = [array_four objectAtIndex:2];
            [cell.contentView addSubview:worklinkemail];

        }

        
    }
    else if (indexPath.row == 6)
    {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"SendJob_five"];
        
        UIView * blockline1 = (UIView *)[cell viewWithTag:1014];
        blockline1.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1].CGColor;
        
        wtButton * btn1 = (wtButton *)[cell viewWithTag:1015];
        btn1.btnIndexPath = indexPath;
        [btn1 addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        [btn1 setImage:[[array_four objectAtIndex:3] integerValue]?[[UIImage imageNamed:@"选中"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]:[[UIImage imageNamed:@"未选中"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        wtButton * btn2 = (wtButton *)[cell viewWithTag:1016];
        btn2.btnIndexPath = indexPath;
        [btn2 addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 setImage:[[array_four objectAtIndex:4] integerValue]?[[UIImage imageNamed:@"选中"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]:[[UIImage imageNamed:@"未选中"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        wtButton * btn3 = (wtButton *)[cell viewWithTag:1017];
        btn3.btnIndexPath = indexPath;
        [btn3 addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 setImage:[[array_four objectAtIndex:5] integerValue]?[[UIImage imageNamed:@"选中"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]:[[UIImage imageNamed:@"未选中"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        wtButton * btn4 = (wtButton *)[cell viewWithTag:1018];
        btn4.btnIndexPath = indexPath;
        [btn4 addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
        [btn4 setImage:[[array_four objectAtIndex:6] integerValue]?[[UIImage imageNamed:@"选中"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]:[[UIImage imageNamed:@"未选中"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        
    }
    else if (indexPath.row == 7)
    {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"SendJob_six"];
        
    }
    else if (indexPath.row == 8)
    {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"SendJob_seven"];
        
        
        wtButton * btn5 = (wtButton *)[cell viewWithTag:1019];
        btn5.btnIndexPath = indexPath;
        [btn5 addTarget:self action:@selector(btn5Tap:) forControlEvents:UIControlEventTouchUpInside];
        [btn5 setImage:[array_six integerValue]?[[UIImage imageNamed:@"选中"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]:[[UIImage imageNamed:@"未选中"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];

        
    }


    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 426;
    }
    else if(indexPath.row == 1)
    {
        return SendJob_towHeight;
    }
    else if(indexPath.row == 2)
    {
        return SendJob_threeHeight;
    }
    else if (indexPath.row ==3 || indexPath.row ==4 ||indexPath.row ==5)
    {
        return 50;
    }
    else if (indexPath.row == 6)
    {
        return 322;
    }
    else if(indexPath.row == 7)
    {
        return 100;

    }
    else
    {
        return 144;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
}
//- (void)tapTotabview
//{
//    [worktitle resignFirstResponder];
//    [workmoney resignFirstResponder];
//    [workpeople resignFirstResponder];
//}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

//点击兼职类型
- (void)workTypeTap
{

}
//点击工资待遇
- (void)workDayTap:(wtButton *)sender
{
    [self showPickerType:sender];
}
//点击性别要求
- (void)workSexTap:(wtButton *)sender
{
    [self showPickerType:sender];
}
//点击结算周期
- (void)workCycleTap:(wtButton *)sender
{
    [self showPickerType:sender];
}
- (void)showPickerType:(wtButton *)sender
{
    NSMutableArray * arr;
    switch (sender.tag) {
        case 1006:
            arr = [NSMutableArray arrayWithObjects:@"每天",@"每周",@"每月",nil];
            [self showPickerTitle:@"请选择工资待遇" andArrayData:arr andTitleUnit:@"" andbtntag:sender];
            break;
        case 1007:
            arr = [NSMutableArray arrayWithObjects:@"不限",@"男",@"女",nil];
            [self showPickerTitle:@"请选择性别" andArrayData:arr andTitleUnit:@"" andbtntag:sender];
            break;
        case 1008:
            arr = [NSMutableArray arrayWithObjects:@"日结",@"周结",@"月结",nil];
            [self showPickerTitle:@"请选择结算周期" andArrayData:arr andTitleUnit:@"" andbtntag:sender];
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
    
    if ([worktitle isFirstResponder]) {
        [worktitle resignFirstResponder];
    }
    else if ([workmoney isFirstResponder])
    {
        [workmoney resignFirstResponder];
    }
    else if ([workpeople isFirstResponder])
    {
        [workpeople isFirstResponder];
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
//点击工作日期
- (void)workFinalCycleTap
{
    
}
//点击当前位置
-(void)worklocatorTap
{

}
//点击选择地区
-(void)workRegionalTap
{
    
}
//点击发布模板
- (void)workModel
{
    MySendJobModelViewController * MySendJobModel = [[MySendJobModelViewController alloc] init];
    UINavigationController * nav =[[UINavigationController alloc] initWithRootViewController:MySendJobModel];
//    [self.navigationController pushViewController:MySendJobModel animated:YES];
    [self presentViewController:nav animated:YES completion:nil];
}
/***************************************************************************
 * 方法名称：btnTap
 * 功能描述：_SendJobTabview 刷新数据源
 * 输入参数：
 * 输出参数：
 * 返回值：
 * 其它说明：
 ***************************************************************************/
- (void)btnTap:(wtButton *)sender
{
    if ([[array_four objectAtIndex:sender.tag - 1015 + 3] isEqualToString:@"0"]) {
        [array_four removeObjectAtIndex:sender.tag - 1015 + 3];
        [array_four insertObject:@"1" atIndex:sender.tag - 1015 + 3];
    }
    else
    {
        [array_four removeObjectAtIndex:sender.tag - 1015 + 3];
        [array_four insertObject:@"0" atIndex:sender.tag - 1015 + 3];
    }
    [_SendJobTabview reloadRowsAtIndexPaths:@[sender.btnIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}
/***************************************************************************
 * 方法名称：btn5Tap
 * 功能描述：_SendJobTabview 刷新数据源
 * 输入参数：
 * 输出参数：
 * 返回值：
 * 其它说明：
 ***************************************************************************/
- (void)btn5Tap:(wtButton *)sender
{
    if ([array_six  isEqualToString:@"0"]) {
    array_six = @"1";
    }
    else
    {
    array_six = @"0";
    }
    [_SendJobTabview reloadRowsAtIndexPaths:@[sender.btnIndexPath] withRowAnimation:UITableViewRowAnimationNone];
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
        case 1006:
            [array_one removeObjectAtIndex:3];
            [array_one insertObject:selectedTitle atIndex:3];
            break;
        case 1007:
            [array_one removeObjectAtIndex:5];
            [array_one insertObject:selectedTitle atIndex:5];
            break;
        case 1008:
            [array_one removeObjectAtIndex:6];
            [array_one insertObject:selectedTitle atIndex:6];
            break;
        default:
            break;
    }
    [_SendJobTabview reloadRowsAtIndexPaths:@[pickerSingle.btnIndexPath] withRowAnimation:UITableViewRowAnimationNone];
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
    [worktitle removeFromSuperview];
    worktitle = [[UITextField alloc] initWithFrame:CGRectMake(Width - 224, 60 , 200, 38)];
    worktitle.placeholder = @"请输入工作标题";
    worktitle.font = [UIFont systemFontOfSize:14];
    worktitle.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    worktitle.borderStyle = UITextBorderStyleNone;
    //        worktitle.clearButtonMode = UITextFieldViewModeAlways;
    worktitle.returnKeyType = UIReturnKeyDone;
    worktitle.textAlignment = NSTextAlignmentRight;
    [worktitle setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [cell.contentView addSubview:worktitle];
    
    
    [workmoney removeFromSuperview];
    workmoney = [[UITextField alloc] initWithFrame:CGRectMake(Width - 220, 164 , 100, 38)];
    workmoney.placeholder = @"请输入金额";
    workmoney.font = [UIFont systemFontOfSize:14];
    workmoney.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    workmoney.borderStyle = UITextBorderStyleNone;
    //        workmoney.clearButtonMode = UITextFieldViewModeAlways;
    workmoney.returnKeyType = UIReturnKeyDone;
    workmoney.textAlignment = NSTextAlignmentRight;
    workmoney.keyboardType = UIKeyboardTypeNumberPad;
    [workmoney setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [cell.contentView addSubview:workmoney];
    
    
    [workpeople removeFromSuperview];
    workpeople = [[UITextField alloc] initWithFrame:CGRectMake(Width - 148, 215 , 100, 38)];
    workpeople.placeholder = @"请输入人数";
    workpeople.font = [UIFont systemFontOfSize:14];
    workpeople.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    workpeople.borderStyle = UITextBorderStyleNone;
    //        workmoney.clearButtonMode = UITextFieldViewModeAlways;
    workpeople.returnKeyType = UIReturnKeyDone;
    workpeople.textAlignment = NSTextAlignmentRight;
    workpeople.keyboardType = UIKeyboardTypeNumberPad;
    [workpeople setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [cell.contentView addSubview:workpeople];
    
    
    UILabel * workType = (UILabel *)[cell viewWithTag:1000];
    workType.text = [array_one objectAtIndex:1];
    UILabel * workDay = (UILabel *)[cell viewWithTag:1001];
    workDay.text = [array_one objectAtIndex:3];
    UILabel * workSex = (UILabel *)[cell viewWithTag:1002];
    workSex.text = [array_one objectAtIndex:5];
    UILabel * workCycle = (UILabel *)[cell viewWithTag:1003];
    workCycle.text = [array_one objectAtIndex:6];
    UILabel * workFinalCycle = (UILabel *)[cell viewWithTag:1004];
    workFinalCycle.text = [array_one objectAtIndex:7];
    
    
    
    UIButton * workTypeTap = (UIButton *)[cell viewWithTag:1005];
    [workTypeTap addTarget:self action:@selector(workTypeTap) forControlEvents:UIControlEventTouchUpInside];
    wtButton * workDayTap = (wtButton *)[cell viewWithTag:1006];
    [workDayTap addTarget:self action:@selector(workDayTap:) forControlEvents:UIControlEventTouchUpInside];
    workDayTap.btnIndexPath = indexPath;
    wtButton *workSexTap = (wtButton *)[cell viewWithTag:1007];
    [workSexTap addTarget:self action:@selector(workSexTap:) forControlEvents:UIControlEventTouchUpInside];
    workSexTap.btnIndexPath = indexPath;
    wtButton * workCycleTap = (wtButton *)[cell viewWithTag:1008];
    [workCycleTap addTarget:self action:@selector(workCycleTap:) forControlEvents:UIControlEventTouchUpInside];
    workCycleTap.btnIndexPath = indexPath;
    UIButton *workFinalCycleTap = (UIButton *)[cell viewWithTag:1009];
    [workFinalCycleTap addTarget:self action:@selector(workFinalCycleTap) forControlEvents:UIControlEventTouchUpInside];
    UIButton *workModel = (UIButton *)[cell viewWithTag:1021];
    [workModel addTarget:self action:@selector(workModel) forControlEvents:UIControlEventTouchUpInside];


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
        SendJob_threeHeight = 150 + TextH - 10;
        if (text.length > 100) {
            SendJob_threeHeight = 150 + TextH + 5;
        }
        else if (text.length > 160)
        {
            SendJob_threeHeight = 150 + TextH + 30;

        }

//        NSLog(@"%d",text.length);

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
            SendJob_towHeight = 162 + TextH - 15;
            
            
//            NSLog(@"%d",text.length);
        }
        else
        {
            SendJob_towHeight = 162;
        }
    }
    [_SendJobTabview reloadRowsAtIndexPaths:@[IndexPath] withRowAnimation:UITableViewRowAnimationNone];
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
