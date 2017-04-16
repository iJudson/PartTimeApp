//
//  MerchantmessageViewController.m
//  duanGongBangBusinessSide1.0
//
//  Created by ljx on 16/4/15.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "ThefirstUpdataToMessageViewController.h"
#import "wtButton.h"
#import "PlaceholderTextView.h"
#import "STPickerSingle.h"
#import "SVProgressHUD.h"
#import <BmobSDK/Bmob.h>
#import "ShareDataSource.h"
#import "CommonServers.h"
//照片捕捉相关类
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "VPImageCropperViewController.h"


#import "CityLocationViewController.h"


#define UIColor204 [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
#define UIColor229 [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];

@interface ThefirstUpdataToMessageViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,PlaceholderTextH,STPickerSingleDelegate,VPImageCropperDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    //数据源
    NSMutableArray * array_one;
    UIBarButtonItem *rightItem;
    NSMutableArray * array_tow;
    
    
    NSString * array_three;
    
    float SendJob_threeHeight;
    float SendJob_towHeight;
    
    
    NSDictionary *inputData;
    NSMutableDictionary *inputDataDic;

    BmobUser *bUser;
    
    NSData * StrImgDate;
    
    NSIndexPath *  RowIndexPath;
    NSIndexPath *  RowIndexPathArea;

    
    NSString * CityObjectId;
    NSString * AreaObjectId;


}


@property (nonatomic, weak) UIView *navBackView;
@property (nonatomic, strong) UITableView * MessageTabview;

@end

@implementation ThefirstUpdataToMessageViewController

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
    [self getBackView:self.navigationController.navigationBar];
    
    bUser = [ShareDataSource sharedDataSource].myData;
    rightItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(editToUser)];
    rightItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(leftback)];
    self.navigationItem.leftBarButtonItem = left;
    
    //  Nav  text
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"商家信息填写";
    self.navigationItem.titleView = label;
    
    
    SendJob_threeHeight=150;
    SendJob_towHeight = 162;
    array_one = [NSMutableArray arrayWithObjects:@"个人",@"",@"",@"",@"",nil];
    array_three = @"";
    array_tow = [NSMutableArray arrayWithObjects:@"",@"", nil];
    UIImage *addPic = [UIImage imageNamed:@"bulb"];
    StrImgDate = UIImagePNGRepresentation(addPic);

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
- (void)leftback
{
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
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

    _navBackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(SetCity_Area:)
                                                 name:@"City_Area" object:nil];
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat alaph = (scrollView.contentOffset.y + 64) / 64;
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
        RowIndexPath = indexPath;
        [self addCellview1:cell andindexPath:indexPath];
    }
    else if (indexPath.row == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"SendJob_tow"];
        cell.layer.cornerRadius = 4;
        
        RowIndexPathArea = indexPath;
        
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
        
        
//        if ([rightItem.title isEqualToString:@"编辑"]) {
            line5.backgroundColor = UIColor229;
            line6.backgroundColor = UIColor229;
            line7.backgroundColor = UIColor229;
//            
//        }
//        else
//        {
//            address.editable = YES;
//            line5.backgroundColor = UIColor204;
//            line6.backgroundColor = UIColor204;
//            line7.backgroundColor = UIColor204;
//        }
//        
        
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
/***************************************************************************
 * 方法名称：editToUser
 * 功能描述：点击提交商家信息判断
 ***************************************************************************/
- (void)editToUser
{
    for (NSString * str in array_one) {
        if (str.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"信息填写不完整!"];
            return;
        }
    }
    if (array_three.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"信息填写不完整!"];
        return;
    }
    for (NSString * str in array_tow) {
        if (str.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"信息填写不完整!"];
            return;
        }
    }
    [self UpDate];
}
- (void)worklocatorTap
{
    
}
- (void)workRegionalTap
{
    
    CityLocationViewController * CityLocation = [[CityLocationViewController alloc] initWithNibName:@"CityLocationViewController" bundle:nil];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:CityLocation];
    [self presentViewController:nav animated:YES completion:nil];
//    [self.navigationController pushViewController:CityLocation animated:YES];
}
- (void)btn1:(wtButton *)sender
{
    // 个人认证  //   团队认证  //  公司认证 //  非营利性组织认证
    NSMutableArray * arr;
    arr = [NSMutableArray arrayWithObjects:@"个人",@"团队",@"公司",@"非营利性组织",nil];
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

- (void)UpDate
{
    [SVProgressHUD showWithStatus:@"正在为您提交..."];
   // PersonalCertification/TeamCertification/CompanyCertification/CompanyCertification
   // 个人认证  //   团队认证  //  公司认证 //  非营利性组织认证
    
//    CompanyUserObjectId
//    Name
//    Phone
//    CertificationType
//    Email
//    Address
//    AreaObjetId
//    FromCityObjetId
//    Intro
    
    NSString * M_CertificationTypeStr;
    if ([[array_one objectAtIndex:0] isEqualToString:@"个人"]) {
        M_CertificationTypeStr = @"PersonalCertification";
    }
    else if ([[array_one objectAtIndex:0] isEqualToString:@"团队"])
    {
        M_CertificationTypeStr = @"TeamCertification";
    }
    else if ([[array_one objectAtIndex:0] isEqualToString:@"公司"])
    {
        M_CertificationTypeStr = @"CompanyCertification";
    }
    else if ([[array_one objectAtIndex:0] isEqualToString:@"非营利性组织"])
    {
        M_CertificationTypeStr = @"CompanyCertification";
    }
    inputDataDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                    M_UpdateCompanyInfo,M_Type,
                    bUser.objectId,M_CompanyUserObjectId,
                    M_CertificationTypeStr,M_CertificationType,
                    [array_one objectAtIndex:1],M_Name,
                    [array_one objectAtIndex:2],M_Nickname,
                    [array_one objectAtIndex:3],M_Phone,
                    [array_one objectAtIndex:4],M_Email,
                    [array_tow objectAtIndex:1],M_Address,
                    array_three,M_Intro,
                    AreaObjectId,M_AreaObjetId,
                    CityObjectId,M_FromCityObjetId,
                    nil];
    [self getMainDataWithDict:inputDataDic success:^(NSDictionary *obj){
        if (obj) {
            
            if ([[obj objectForKey:@"Static"] isEqualToString:@"success"]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }
            [SVProgressHUD showSuccessWithStatus:[obj objectForKey:@"Value"]];
        }
    }fail:^(NSString *err){
        [SVProgressHUD showErrorWithStatus:err];
    }];
}
- (void)Tapheadimg
{
    UIAlertController * al = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"相机权限受限" message:@"请前往设置将相机权限打开" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]){
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]){
                controller.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                controller.showsCameraControls = YES;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                             }];
        }
    }];
    UIAlertAction *otherActiontow = [UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if ([self isPhotoLibraryAvailable]){
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                             }];
        }
    }];
    [al addAction:cancelAction];
    [al addAction:otherAction];
    [al addAction:otherActiontow];
    [self presentViewController:al animated:YES completion:nil];
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
    
    UIButton * GoAc = (UIButton *)[cell viewWithTag:1100];
    GoAc.hidden = YES;
    UIImageView * headimg = (UIImageView *)[cell viewWithTag:1101];
    headimg.userInteractionEnabled = YES;
    headimg.image = [UIImage imageWithData:StrImgDate];
    UITapGestureRecognizer * Tapheadimg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tapheadimg)];
    [headimg addGestureRecognizer:Tapheadimg];
    
    
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
//    if ([rightItem.title isEqualToString:@"编辑"]) {
        line1.backgroundColor = UIColor229;
        line2.backgroundColor = UIColor229;
        line3.backgroundColor = UIColor229;
        line4.backgroundColor = UIColor229;
        line5.backgroundColor = UIColor229;
//        textfield1.enabled = NO;
//        textfield1.enabled = NO;
//        textfield1.enabled = NO;
//        textfield1.enabled = NO;
//    }else
//    {
//        line1.backgroundColor = UIColor204;
//        line2.backgroundColor = UIColor204;
//        line3.backgroundColor = UIColor204;
//        line4.backgroundColor = UIColor204;
//        line5.backgroundColor = UIColor204;
//        textfield1.enabled = YES;
//        textfield1.enabled = YES;
//        textfield1.enabled = YES;
//        textfield1.enabled = YES;
//    }
    
    
//    [GoAc addTarget:self action:@selector(GoAc) forControlEvents:UIControlEventTouchUpInside];
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
#pragma mark - 更新商家信息

- (void)getMainDataWithDict:(NSDictionary *)dict success:(void (^)(NSDictionary *object))success fail:(void (^)(NSString *reason))fail{
    inputData = [NSDictionary dictionaryWithObject:dict forKey:@"inputData"];
    [BmobCloud callFunctionInBackground:M_V4_Personal_C withParameters:inputData block:^(id object, NSError *err){
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

#pragma mark - 更新商家头像信息

- (void)getMainDataWithDictIMG:(NSDictionary *)dict success:(void (^)(NSDictionary *object))success fail:(void (^)(NSString *reason))fail{
    inputData = [NSDictionary dictionaryWithObject:dict forKey:@"inputData"];
    [BmobCloud callFunctionInBackground:M_V4_Account withParameters:inputData block:^(id object, NSError *err){
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

#pragma mark - camera utility

- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark VPImageCropperDelegate

- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage{
    NSData *imageHead = UIImageJPEGRepresentation(editedImage, 0.1);
    
    BmobFile *headImageFile = [[BmobFile alloc] initWithFileName:@"crop_head_img.jpg" withFileData:imageHead];
    [SVProgressHUD showWithStatus:@"头像上传中"];

    [headImageFile saveInBackground:^(BOOL isSuccessful, NSError *error){
        if (isSuccessful) {
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:M_UpdateUserHeadImg, M_Type,[BmobUser getCurrentUser].objectId, M_UserObjectId, headImageFile.url, M_HeadImgURL, nil];
            [CommonServers callAccountWithDict:dict success:^(NSDictionary *obj){
                if ([[obj objectForKey:@"Static"] isEqualToString:@"success"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [[NSUserDefaults standardUserDefaults] setObject:headImageFile.url forKey:@"HeadImgURL"];
                        [SVProgressHUD showSuccessWithStatus:@"上传成功"];
//                        _userHeadImageView.image = editedImage;
//                        _blurImage.image = [editedImage applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:0.3 alpha:0.7] saturationDeltaFactor:1.8 maskImage:nil];
                                StrImgDate = imageHead;
                                [_MessageTabview reloadRowsAtIndexPaths:@[RowIndexPath] withRowAnimation:UITableViewRowAnimationNone];
                    });
                }else{
                    [SVProgressHUD showErrorWithStatus:kDataErrorWarning];
                }
            }fail:^(NSString *err){
                [SVProgressHUD showErrorWithStatus:err];
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:kDataErrorWarning];
        }
    }withProgressBlock:^(CGFloat progress) {
        [SVProgressHUD showProgress:progress status:[NSString stringWithFormat:@"头像上传中...%d%%",(int)(progress*100.0)]];
    }];
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
}
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController{
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
}
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        VPImageCropperViewController *imgCropperVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgCropperVC.delegate = self;
        [self presentViewController:imgCropperVC animated:YES completion:^{
        }];
    }];
}

#pragma mark image scale utility

- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < 40) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = 40;
        btWidth = sourceImage.size.width * (40 / sourceImage.size.height);
    } else {
        btWidth = 40;
        btHeight = sourceImage.size.height * (40 / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}
- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)// LOG(@"could not scale image");
        
        //pop the context to get back to the default
        UIGraphicsEndImageContext();
    return newImage;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}
-(void)SetCity_Area:(NSNotification *)sender
{
    NSDictionary * dic = sender.userInfo;
//    NSLog(@"%@",[[dic objectForKey:@"City"] objectForKey:@"CityName"]);
//    NSLog(@"%@",[[dic objectForKey:@"Area"] objectForKey:@"AreaName"]);
    [array_tow removeObjectAtIndex:0];
    [array_tow insertObject:[NSString stringWithFormat:@"%@ %@",[[dic objectForKey:@"City"] objectForKey:@"CityName"],[[dic objectForKey:@"Area"] objectForKey:@"AreaName"]] atIndex:0];
    CityObjectId = [[dic objectForKey:@"City"] objectForKey:@"objectId"];
    AreaObjectId = [[dic objectForKey:@"Area"] objectForKey:@"objectId"];
    [_MessageTabview reloadRowsAtIndexPaths:@[RowIndexPathArea] withRowAnimation:UITableViewRowAnimationNone];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SetCity_Area" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SetCity_Area" object:nil];
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
