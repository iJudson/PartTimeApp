//
//  NewLoginViewController.m
//  duangongbang
//
//  Created by ljx on 16/4/11.
//  Copyright © 2016年 duangongbang. All rights reserved.
//

#import "NewLoginViewController.h"
#import "NewforgetCodeViewController.h"
#import "NewregisterViewController.h"
#import "SVProgressHUD.h"
#import "RegX.h"
#import <BmobSDK/Bmob.h>
#import "ShareDataSource.h"
#import "ThefirstUpdataToMessageViewController.h"
#define PleaceInputARightPhoneNum @"请输入正确的手机号码"
#import "AFNetworking/AFNetworking.h"
#import "LPMainController.h"
#define refreshMaxTime 10

@interface NewLoginViewController ()<UITextFieldDelegate>
{
    UITextField * UserNameTextField;
    UITextField * UserCodeTextField;
    BOOL flag;
    BmobUser *bUser;

}

@end

@implementation NewLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * backv = [[UIImageView alloc] initWithFrame:self.view.frame];
    backv.image = [[UIImage imageNamed:@"登录bg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.view addSubview:backv];
    bUser = [ShareDataSource sharedDataSource].myData;
    [self setUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

#pragma mark - UIButton Tap

/***************************************************************************
 * 方法名称：GOLoginbtn
 * 功能描述：点击登录
 * 输入参数：UserNameTextField.text   UserCodeTextField.text
 * 输出参数：user
 * 返回值：
 * 其它说明：
 ***************************************************************************/
- (void)GOLoginbtn
{
    if ([UserNameTextField.text isEqualToString:@""] && [UserCodeTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入用户名或密码"];
        return;
    }
    if ([RegX validateMobile:UserNameTextField.text]) {
        if ([self checkTheNetWorking]) {
            return;
        }
        NSTimer *timer = [NSTimer timerWithTimeInterval:refreshMaxTime target:self selector:@selector(stopLogin) userInfo:nil repeats:NO];
        [SVProgressHUD showWithStatus:@"登录中"];
        [BmobUser loginWithUsernameInBackground:UserNameTextField.text password:UserCodeTextField.text block:^(BmobUser *user, NSError *err){
            [timer invalidate];
            if (user) {
                [SVProgressHUD showSuccessWithStatus:@"成功登录"];
                [ShareDataSource sharedDataSource].myData = user;
                if ([(NSArray *)[user objectForKey:M_Static] count]!=0) {
                    for (int i = 0; i < [(NSArray *)[user objectForKey:M_Static] count]; i++) {
                        if ([[[user objectForKey:M_Static] objectAtIndex:i] isEqualToString:M_PersonalCertification] || [[[user objectForKey:M_Static] objectAtIndex:i] isEqualToString:M_TeamCertification] || [[[user objectForKey:M_Static] objectAtIndex:i] isEqualToString:M_CompanyCertification] ||[[[user objectForKey:M_Static] objectAtIndex:i] isEqualToString:M_NonprofitCertification]) {
                            [self dismissViewControllerAnimated:YES completion:nil];
                            return ;
                        }
                    }
                }
                    ThefirstUpdataToMessageViewController * UpdataToMessage = [[ThefirstUpdataToMessageViewController alloc] init];
                    [self.navigationController pushViewController:UpdataToMessage animated:YES];
   
            }else{
                [SVProgressHUD showErrorWithStatus:@"用户名或密码不正确"];
            }
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:PleaceInputARightPhoneNum];
    }
}
//注册
- (void)GORegisterbtn
{
    NewregisterViewController * NewregisterV = [[NewregisterViewController alloc] init];
    [self.navigationController pushViewController:NewregisterV animated:YES];
}
//修改密码
- (void)GOforgetCode
{
    NewforgetCodeViewController * NewforgetCodeV = [[NewforgetCodeViewController alloc] init];
    [self.navigationController pushViewController:NewforgetCodeV animated:YES];
}
//随便看看
- (void)GOCasuallook
{
    LPMainController *mainVC = [[LPMainController alloc] init];

    [self dismissViewControllerAnimated:true completion:nil];
}
#pragma mark - setUI

- (void)setUI
{
    UIImageView * logimg = [[UIImageView alloc] initWithFrame:CGRectMake(Width/2 - 124, 64, 248, 121)];
    logimg.image = [[UIImage imageNamed:@"logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.view addSubview:logimg];
    
    UIButton * GoMerchant = [UIButton buttonWithType:UIButtonTypeSystem];
    GoMerchant.frame = CGRectMake(Width - 160, 20, 148, 44);
    [GoMerchant setTitle:@"我要招人" forState:UIControlStateNormal];
    [GoMerchant setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    GoMerchant.titleLabel.textAlignment = NSTextAlignmentRight;
    [GoMerchant setImage:[[UIImage imageNamed:@"进入无阴影"]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    //    [GoMerchant addTarget:self action:@selector(GoMerchant) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:GoMerchant];
    GoMerchant.titleEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
    //设置title在button上的位置（上top，左left，下bottom，右right）
    GoMerchant.imageEdgeInsets = UIEdgeInsetsMake(0, GoMerchant.bounds.size.width - 24, 0, 0);
    
    
    // text UILabel
    
    UILabel * UserName = [[UILabel alloc] initWithFrame:CGRectMake(logimg.frame.origin.x, logimg.frame.size.height + logimg.frame.origin.y + 12, 58, 37)];
    UserName.text = @"手机号:";
    UserName.textColor = [UIColor whiteColor];
    UserName.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:UserName];
    
    UILabel * UserCode = [[UILabel alloc] initWithFrame:CGRectMake(logimg.frame.origin.x, UserName.frame.size.height + UserName.frame.origin.y + 12, 58, 37)];
    UserCode.text = @"密\t 码:";
    UserCode.textColor = [UIColor whiteColor];
    UserCode.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:UserCode];
    
    
    // line UIView
    
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(logimg.frame.origin.x, UserName.frame.size.height + UserName.frame.origin.y, 248, 0.5)];
    line1.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.view addSubview:line1];
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(logimg.frame.origin.x, UserCode.frame.size.height + UserCode.frame.origin.y, 248, 0.5)];
    line2.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.view addSubview:line2];
    
    // 请输入手机号码  UITextField
    
    UserNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(UserName.frame.origin.x + UserName.frame.size.width + 5, logimg.frame.size.height + logimg.frame.origin.y + 12, 185, 37)];
    UserNameTextField.placeholder = @"请输入手机号码";
    UserNameTextField.font = [UIFont systemFontOfSize:15];
    UserNameTextField.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    UserNameTextField.borderStyle = UITextBorderStyleNone;
    UserNameTextField.returnKeyType = UIReturnKeyNext;
    UserNameTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    [UserNameTextField setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    UserNameTextField.delegate =self;
    [self.view addSubview:UserNameTextField];
    
    // 请输入密码  UITextField
    
    UserCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(UserCode.frame.origin.x + UserCode.frame.size.width + 5, UserNameTextField.frame.size.height + UserNameTextField.frame.origin.y + 12, 185, 37)];
    UserCodeTextField.placeholder = @"请输入密码";
    UserCodeTextField.font = [UIFont systemFontOfSize:15];
    UserCodeTextField.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    UserCodeTextField.borderStyle = UITextBorderStyleNone;
    UserCodeTextField.returnKeyType = UIReturnKeyNext;
    UserCodeTextField.secureTextEntry = YES;
    UserCodeTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    [UserCodeTextField setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    UserCodeTextField.delegate =self;
    [self.view addSubview:UserCodeTextField];
    
    // 登录  UIButton
    
    UIButton * Loginbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    Loginbtn.frame = CGRectMake(Width/2 - 124, UserCodeTextField.frame.size.height + UserCodeTextField.frame.origin.y + 12, 248, 90);
    [Loginbtn setTitle:@"登录" forState:UIControlStateNormal];
    [Loginbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Loginbtn setImage:[[UIImage imageNamed:@"蓝色L按钮"]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [Loginbtn addTarget:self action:@selector(GOLoginbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Loginbtn];
    Loginbtn.titleEdgeInsets = UIEdgeInsetsMake(0, -Loginbtn.bounds.size.width - 3, 0, 0);
    Loginbtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [Loginbtn setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    // 用户注册  UIButton
    
    UIButton * Registerbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    Registerbtn.frame = CGRectMake(Width/2 - 124, Loginbtn.frame.size.height + Loginbtn.frame.origin.y, 248, 90);
    [Registerbtn setTitle:@"用户注册" forState:UIControlStateNormal];
    [Registerbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Registerbtn setImage:[[UIImage imageNamed:@"黑色按钮"]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [Registerbtn addTarget:self action:@selector(GORegisterbtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Registerbtn];
    Registerbtn.titleEdgeInsets = UIEdgeInsetsMake(0, - Registerbtn.bounds.size.width - 3, 0, 0);
    [Registerbtn setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    //  忘记密码?  UIButton
    
    UIButton * forgetCode = [UIButton buttonWithType:UIButtonTypeSystem];
    forgetCode.frame = CGRectMake(Registerbtn.frame.origin.x + 12, Registerbtn.frame.size.height + Registerbtn.frame.origin.y + 28 , 75, 32);
    [forgetCode setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetCode setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
    [forgetCode addTarget:self action:@selector(GOforgetCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetCode];
    
    //  随便逛逛  UIButton
    
    UIButton * Casuallook = [UIButton buttonWithType:UIButtonTypeSystem];
    Casuallook.frame = CGRectMake(Registerbtn.frame.origin.x + Registerbtn.frame.size.width - 72, Registerbtn.frame.size.height + Registerbtn.frame.origin.y + 28 , 60, 32);
    [Casuallook setTitle:@"随便逛逛" forState:UIControlStateNormal];
    [Casuallook setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
    [Casuallook addTarget:self action:@selector(GOCasuallook) forControlEvents:UIControlEventTouchUpInside];
    Casuallook.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:Casuallook];
}

- (BOOL)checkTheNetWorking {
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"当前网络不可用"];
        return YES;
    }else {
        return NO;
    }
}
- (void)stopLogin{
    [SVProgressHUD showErrorWithStatus:@"登录超时"];
    
}
- (void)repeatLogin
{
    if (flag) {
        [self dismissViewControllerAnimated:YES completion:nil];
//        DGBTabBarViewController *main = [[DGBTabBarViewController alloc] init];
//        [self presentViewController:main animated:YES completion:^{
//            [[NSNotificationCenter defaultCenter] postNotificationName:KEY_KVO_GETMAINDATA object:nil];
//            [[NSNotificationCenter defaultCenter] postNotificationName:KEY_KVO_LOGIN_LOAD_USER_INFO object:nil];
//        }];
    }
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
