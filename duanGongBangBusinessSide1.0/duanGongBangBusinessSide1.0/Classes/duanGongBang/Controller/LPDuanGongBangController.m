//
//  LPDuanGongBangController.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/1.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPDuanGongBangController.h"
#import "LPCarouselController.h"
#import "LPPageControl.h"
#import "LPDuanGongBangTableView.h"
#import "LPDgbSecondCell.h"
#import "LPDgbFirstCell.h"
#import "LPDgbTableHeaderView.h"
#import "LPPartTimeManagementController.h"
#import "LPExamingController.h"
#import "LPEmployingController.h"
#import "LPOffshelfController.h"
#import "LPDGBLastCell.h"
#import "NewLoginViewController.h"


#import "SendpartTimeJobViewController.h"


@interface LPDuanGongBangController ()<UITableViewDelegate,UITableViewDataSource,LPDgbTableHeaderViewDelegate>
//导入轮播控制器
@property(nonatomic,strong)LPCarouselController *carouselVC;

////item上面显示的pagecontrol
@property (strong,nonatomic) LPPageControl *pageControl;


//控制器上TableView
@property (weak, nonatomic) IBOutlet LPDuanGongBangTableView *LPTableView;


@end


static NSString *const FirstCellIdentifier = @"LPDgbFirstCell";
static NSString *const SecondCellIdentifier = @"LPDgbSecondCell";
static NSString *const ThirdCellIdentifier = @"LPDGBLastCell";



@implementation LPDuanGongBangController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareTableView];
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
         
        NewLoginViewController *logVC = [[NewLoginViewController alloc] init];
        UINavigationController * Nav = [[UINavigationController alloc] initWithRootViewController:logVC];
        [self presentViewController:Nav animated:YES completion:nil];

    });
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
}
- (void)prepareTableView{
    self.title = @"短工邦商家版";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2x"]];

    self.LPTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.LPTableView.showsVerticalScrollIndicator = NO;
    self.LPTableView.backgroundColor = [UIColor clearColor];
//    注册tableviewLPDgbSecondCell
    [self.LPTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPDgbFirstCell class]) bundle:nil] forCellReuseIdentifier:FirstCellIdentifier];
    
    [self.LPTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPDgbSecondCell class]) bundle:nil] forCellReuseIdentifier:SecondCellIdentifier];
    [self.LPTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPDGBLastCell class]) bundle:nil] forCellReuseIdentifier:ThirdCellIdentifier];
    
    
    LPDgbTableHeaderView *dgbTHView = [LPDgbTableHeaderView dgbTableHeaderView];
    dgbTHView.tableHeaderViewDelegate = self;
    self.LPTableView.tableHeaderView = dgbTHView;
    self.LPTableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    self.LPTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    LPDgbFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstCellIdentifier forIndexPath:indexPath];
//    tableView.rowHeight = 100;
//    return cell;
    if (indexPath.row == 0) {
        LPDgbFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:FirstCellIdentifier forIndexPath:indexPath];
        tableView.rowHeight = 100;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else if(indexPath.section == 0 && indexPath.item == 9){
        tableView.rowHeight = 44;
        LPDGBLastCell *cell = [tableView dequeueReusableCellWithIdentifier:ThirdCellIdentifier forIndexPath:indexPath];
    
        return cell;
    }
    else{
        tableView.rowHeight = 44;
        LPDgbSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:SecondCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
        }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark - tableviewheader的代理方法
//点击发布兼职，跳转到wut做的界面
- (void)didSelectedReleaseButton{
    SendpartTimeJobViewController * SendpartTimeJob = [[SendpartTimeJobViewController alloc] init];
    [self.navigationController pushViewController:SendpartTimeJob animated:YES];
    
}


- (void)didSelectedButton:(UIButton *)btn{
    LPPartTimeManagementController *ptManageMentVC =[[LPPartTimeManagementController alloc] init];
    ptManageMentVC.index = btn.tag;

    [self.navigationController pushViewController:ptManageMentVC animated:YES];
  
}

@end
