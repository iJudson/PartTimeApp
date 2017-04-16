//
//  NewregisterViewController.m
//  duangongbang
//
//  Created by ljx on 16/4/12.
//  Copyright © 2016年 duangongbang. All rights reserved.
//

#import "NewregisterViewController.h"
#import <BmobSDK/Bmob.h>
#import "SVProgressHUD.h"
#import "RegX.h"
#import "AFNetworking/AFNetworking.h"
#import "ThefirstUpdataToMessageViewController.h"
#import "ShareDataSource.h"
#define VerWrong @"验证失败，请检查验证码是否正确再次填写或重新获取"
#define kDataErrorWarning @"数据异常"
#define kNetworkWarning @"请求超时,请检查网络连接"
#define NewkCloudInit   @"V4_Account"
#define PleaceInputARightPhoneNum @"请输入正确的手机号码"

@interface NewregisterViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    UITextField * UserNameTextField;
    UITextField * UserCodeTextField;
    UITextField * SecurityCode;
    UIButton * sendv;
    
    NSDictionary *inputData;
    NSMutableDictionary *inputDataDic;
    
}
@property (nonatomic, weak) UIView *navBackView;

@end

@implementation NewregisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //  view background  img
    UIImageView * backv = [[UIImageView alloc] initWithFrame:self.view.frame];
    backv.image = [[UIImage imageNamed:@"登录bg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

    //  Nav  text
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"注册";
    self.navigationItem.titleView = label;
    
    [self setUI];
}

#pragma mark - UIButton Tap

/***************************************************************************
 * 方法名称：Goregister
 * 功能描述：点击注册
 * 输入参数：UserNameTextField.text   UserCodeTextField.text
 * 输出参数：user
 * 返回值：
 * 其它说明：注册成功立即登录
 ***************************************************************************/
- (void)Goregister
{
    
    [SVProgressHUD showWithStatus:@"注册中..."];

    [self RegisterTo];
    
    
    return;
    
    
    
    
    if ([UserNameTextField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"手机号码不能为空"];
        return;
    }
    else if ([UserCodeTextField.text isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入您的密码"];
        return;
    }
    if ([self checkTheNetWorking]) {
        return;
    }
    //验证
    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:UserNameTextField.text andSMSCode:UserCodeTextField.text resultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            [self RegisterTo];
        } else {
            [SVProgressHUD showErrorWithStatus:VerWrong];
        }
    }];

}
//验证成功注册
- (void)RegisterTo
{
    inputDataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    M_CompanySignUp,M_Type,
                    M_ios,M_DeviceType,
                    @"",M_DeviceId,
                    UserNameTextField.text,@"username",
                    UserCodeTextField.text,@"password",
                    nil];
    [self getMainDataWithDict:inputDataDic success:^(NSDictionary *obj){
        if (obj) {
            if ([[obj objectForKey:M_Static] isEqualToString:@"success"]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self Login];
                });
            }
            [SVProgressHUD showSuccessWithStatus:[obj objectForKey:@"Value"]];
        }
    }fail:^(NSString *err){
        [SVProgressHUD showErrorWithStatus:err];
    }];
}
//
- (void)expository_writing
{
    
}
//返回
- (void)backPop
{
    [self.navigationController popViewControllerAnimated:YES];
}
//点击发送验证码
- (void)startsend
{
    [self startCountWhenClickVerRequest];
}

#pragma mark - Set UI

/***************************************************************************
 * 方法名称：setUI
 * 功能描述：
 * 输入参数：
 * 输出参数：
 * 返回值：
 * 其它说明：
 ***************************************************************************/
- (void)setUI
{
    //  log  UIImageView
    UIImageView * logimg = [[UIImageView alloc] initWithFrame:CGRectMake(Width/2 - 124, 64, 248, 121)];
    logimg.image = [[UIImage imageNamed:@"logo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.view addSubview:logimg];
    
    //  text  UILabel
    
    UILabel * UserName = [[UILabel alloc] initWithFrame:CGRectMake(logimg.frame.origin.x, logimg.frame.size.height + logimg.frame.origin.y + 12, 58, 37)];
    UserName.text = @"手机号:";
    UserName.textColor = [UIColor whiteColor];
    UserName.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:UserName];
    
    UILabel * UserCode = [[UILabel alloc] initWithFrame:CGRectMake(logimg.frame.origin.x, UserName.frame.size.height + UserName.frame.origin.y + 12, 58, 37)];
    UserCode.text = @"密  码:";
    UserCode.textColor = [UIColor whiteColor];
    UserCode.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:UserCode];
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(logimg.frame.origin.x, UserCode.frame.size.height + UserCode.frame.origin.y + 12, 58, 37)];
    text.text = @"验证码:";
    text.textColor = [UIColor whiteColor];
    text.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:text];
    
    //  line  UIView
    
    UIView * line1 = [[UIView alloc] initWithFrame:CGRectMake(logimg.frame.origin.x, UserName.frame.size.height + UserName.frame.origin.y, 248, 0.5)];
    line1.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.view addSubview:line1];
    UIView * line2 = [[UIView alloc] initWithFrame:CGRectMake(logimg.frame.origin.x, UserCode.frame.size.height + UserCode.frame.origin.y, 248, 0.5)];
    line2.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.view addSubview:line2];
    UIView * line3 = [[UIView alloc] initWithFrame:CGRectMake(logimg.frame.origin.x, text.frame.size.height + text.frame.origin.y, 248, 0.5)];
    line3.backgroundColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.view addSubview:line3];
    
    //  请输入手机号码  UITextField
    
    
    UserNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(UserName.frame.origin.x + UserName.frame.size.width + 5, logimg.frame.size.height + logimg.frame.origin.y + 12, 185, 37)];
    UserNameTextField.placeholder = @"请输入手机号码";
    UserNameTextField.font = [UIFont systemFontOfSize:15];
    UserNameTextField.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    UserNameTextField.borderStyle = UITextBorderStyleNone;
    //    UserNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    UserNameTextField.returnKeyType = UIReturnKeyNext;
    UserNameTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    [UserNameTextField setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    UserNameTextField.delegate =self;
    [self.view addSubview:UserNameTextField];
    
    //  请输入密码  UITextField
    
    UserCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(UserCode.frame.origin.x + UserCode.frame.size.width + 5, UserNameTextField.frame.size.height + UserNameTextField.frame.origin.y + 12, 185, 37)];
    UserCodeTextField.placeholder = @"请输入密码";
    UserCodeTextField.secureTextEntry = YES;
    UserCodeTextField.font = [UIFont systemFontOfSize:15];
    UserCodeTextField.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    UserCodeTextField.borderStyle = UITextBorderStyleNone;
    //    UserCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
    UserCodeTextField.returnKeyType = UIReturnKeyNext;
    UserCodeTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    [UserCodeTextField setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    UserCodeTextField.delegate =self;
    [self.view addSubview:UserCodeTextField];
    
    //  发送验证码  UIButton
    
    sendv = [UIButton buttonWithType:UIButtonTypeSystem];
    sendv.frame = CGRectMake(UserCodeTextField.frame.size.width + UserCodeTextField.frame.origin.x - 84, line3.frame.origin.y - 34, 80, 28);
    [sendv setTitle:@"发送验证码" forState:UIControlStateNormal];
    sendv.titleLabel.font = [UIFont systemFontOfSize:12];
    [sendv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendv.layer.cornerRadius  = 4;
    sendv.layer.borderColor = [UIColor whiteColor].CGColor;
    sendv.layer.borderWidth = 0.5;
    [self.view addSubview:sendv];
    [sendv addTarget:self action:@selector(startsend) forControlEvents:UIControlEventTouchUpInside];
    
    //  请输入验证码  UITextField
    
    SecurityCode = [[UITextField alloc] initWithFrame:CGRectMake(UserCode.frame.origin.x + UserCode.frame.size.width + 5, UserCodeTextField.frame.size.height + UserCodeTextField.frame.origin.y + 12, sendv.frame.origin.x - (UserCode.frame.origin.x + UserCode.frame.size.width) - 5, 37)];
    SecurityCode.placeholder = @"请输入验证码";
    SecurityCode.font = [UIFont systemFontOfSize:15];
    SecurityCode.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    SecurityCode.borderStyle = UITextBorderStyleNone;
    //    UserCodeTextField.clearButtonMode = UITextFieldViewModeAlways;
    SecurityCode.returnKeyType = UIReturnKeyNext;
    SecurityCode.keyboardType = UIKeyboardTypeNumberPad;
    [SecurityCode setValue:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    SecurityCode.delegate =self;
    [self.view addSubview:SecurityCode];
    
    //  立即注册  UIButton
    
    UIButton * Goregister = [UIButton buttonWithType:UIButtonTypeSystem];
    Goregister.frame = CGRectMake(Width/2 - 124, SecurityCode.frame.size.height + SecurityCode.frame.origin.y + 12, 248, 90);
    [Goregister setTitle:@"立即注册" forState:UIControlStateNormal];
    [Goregister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [Goregister setImage:[[UIImage imageNamed:@"蓝色L按钮"]imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]forState:UIControlStateNormal];
    [Goregister addTarget:self action:@selector(Goregister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Goregister];
    Goregister.titleEdgeInsets = UIEdgeInsetsMake(0, -Goregister.bounds.size.width - 3, 0, 0);
    [Goregister setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    //  注册前请阅读  UILabel
    
    UILabel * textspecification = [[UILabel alloc] initWithFrame:CGRectMake(Width/2 - 85, Goregister.frame.origin.y  + Goregister.frame.size.height, 73, 30)];
    textspecification.text = @"注册前请阅读";
    textspecification.textColor = [UIColor whiteColor];
    textspecification.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:textspecification];
    
    //阅读协议 UIButton
    
    UIButton * expository_writing = [UIButton buttonWithType:UIButtonTypeSystem];
    expository_writing.frame = CGRectMake(textspecification.frame.size.width + textspecification.frame.origin.x, Goregister.frame.origin.y  + Goregister.frame.size.height, 115, 30);
    expository_writing.titleLabel.font = [UIFont systemFontOfSize:12];
    [expository_writing setTitle:@"《短工邦用户协议》" forState:UIControlStateNormal];
    [expository_writing setTitleColor:[UIColor colorWithRed:14/255.0 green:172/255.0 blue:234/255.0 alpha:1] forState:UIControlStateNormal];
    [expository_writing addTarget:self action:@selector(expository_writing) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:expository_writing];
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

#pragma mark - viewWillAppear

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //返回
    UIButton * leftbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftbtn setTitle:@"登录" forState:UIControlStateNormal];
    [leftbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftbtn setImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    leftbtn.frame = CGRectMake(0, 0, 70, 40);
    [leftbtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [leftbtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
    [leftbtn addTarget:self action:@selector(backPop) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backItem= [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = backItem;
}


- (void)startCountWhenClickVerRequest{
    [self countDownWithTime:60 countDownBlock:^(int timeLeft) {
        int seconds = timeLeft % 60;
        NSString *strTime = [[NSString stringWithFormat:@"%.2ds",seconds] copy];
        [sendv setTitle:strTime forState:UIControlStateNormal];
        sendv.enabled = NO;
    } endBlock:^(void){
        [sendv setTitle:@"获取验证码" forState:UIControlStateNormal];
        sendv.enabled = YES;
    }];
}
- (void)countDownWithTime:(int)time
           countDownBlock:(void (^)(int timeLeft))countDownBlock
                 endBlock:(void (^)())endBlock{
    __block int timeout = time; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (endBlock) {
                    endBlock();
                }
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                timeout--;
                if (countDownBlock) {
                    countDownBlock(timeout);
                }
            });
        }
    });
    dispatch_resume(_timer);
}
- (BOOL)checkTheNetWorking {
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [SVProgressHUD showErrorWithStatus:@"当前网络不可用"];
        return YES;
    }else {
        return NO;
    }
}

#pragma mark - servers

- (void)getMainDataWithDict:(NSDictionary *)dict success:(void (^)(NSDictionary *object))success fail:(void (^)(NSString *reason))fail{
    inputData = [NSDictionary dictionaryWithObject:dict forKey:@"inputData"];
    
    [BmobCloud callFunctionInBackground:NewkCloudInit withParameters:inputData block:^(id object, NSError *err){
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


- (void)stopLogin{
}




- (void)Login
{
    [SVProgressHUD showWithStatus:@"正在为您登录..."];
        [BmobUser loginWithUsernameInBackground:UserNameTextField.text password:UserCodeTextField.text block:^(BmobUser *user, NSError *err){
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
                [SVProgressHUD showErrorWithStatus:@"登录失败,请返回登录页面重新登录"];
            }
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
