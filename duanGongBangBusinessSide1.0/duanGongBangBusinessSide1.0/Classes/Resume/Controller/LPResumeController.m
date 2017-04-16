//
//  LPResumeController.m
//  duanGongBangBusinessSide1.0
//
//  Created by Judson on 16/3/15.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPResumeController.h"
//两种cell
#import "LPResumeMessageCell.h"
#import "LPCategoryCell.h"
//三个数据原型
#import "LPResumeMessage.h"
#import "LPResumeNode.h"
#import "LPCategory.h"

#import "LPRemindNewResume.h"


@interface LPResumeController ()

@property(strong,nonatomic) NSMutableArray* dataArray; //保存全部数据的数组
@property(strong,nonatomic) NSArray *displayArray;   //保存要显示在界面上的数据的数组
// 定义LPRemindNewResume属性
@property(nonatomic,strong)LPRemindNewResume *remindResume;

@end

static NSString * const messageReuseIdentifier = @"LPResumeMessageCell";
static NSString * const categoryReuseIdentifier = @"LPCategoryCell";

@implementation LPResumeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareForNavigationItem];
  
    [self prepareTableView];
    
    [self addTestData];//添加演示数据
    
    [self reloadDataForDisplayArray];//初始化将要显示的数据
    [self remindNewResume];
}


- (void)prepareTableView{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2x"]];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPResumeMessageCell class]) bundle:nil] forCellReuseIdentifier:messageReuseIdentifier];
   [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LPCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryReuseIdentifier];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(LPNavBarHeight, 0, tabBarheight, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}


#pragma mark - 准备navigationItem上的所有UI的内容
- (void)prepareForNavigationItem{
    
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"addBarBtn"] forState:UIControlStateNormal];
    [addBtn sizeToFit];
    [addBtn addTarget:self action:@selector(addResume) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = right;
}


/**
 *  添加简历
 */
- (void)addResume{
    NSLog(@"添加简历");
}

#pragma mark - 准备UITableViewDatasource && Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _displayArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LPResumeNode *node = [_displayArray objectAtIndex:indexPath.row];
    if(node.type == 1){//类型为1的cell
        LPCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryReuseIdentifier];
        cell.node = node;
        [self loadDataForResumeCell:cell with:node];
        
        [cell setNeedsDisplay];
        return cell;
    }
    else{//类型为2的cell
        LPResumeMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageReuseIdentifier];
        cell.node = node;
        [self loadDataForResumeCell:cell with:node];
        
        [cell setNeedsDisplay];
        
        return cell;
    }
}


//返回不同的cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LPResumeNode *node = [_displayArray objectAtIndex:indexPath.row];
    if(node.type == 1){//类型为1的cell
        return 49;
    }else{//类型为2的cell
        return 57;
    }
}



/*---------------------------------------
 处理cell选中事件，需要自定义的部分
 --------------------------------------- */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LPResumeNode *node = [_displayArray objectAtIndex:indexPath.row];
    [self reloadDataForDisplayArrayChangeAt:indexPath.row];//修改cell的状态(关闭或打开)
    if(node.type == 2){
        //处理叶子节点选中，此处需要自定义
        NSLog(@"doian");
    }
    else{
        LPCategoryCell *cell = (LPCategoryCell*)[tableView cellForRowAtIndexPath:indexPath];
        if(cell.node.isExpanded ){
            [self rotateArrow:cell with:M_PI_2];
        }
        else{
            [self rotateArrow:cell with:0];
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIImageView  *bottomShawowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, LPScreenSize.width, 4)];
    bottomShawowView.image = [UIImage imageNamed:@"bottomShawow"];
    return bottomShawowView;
    
}


#pragma mark - cell上面的一些处理事件

- (void)loadDataForResumeCell:(UITableViewCell *)cell
                           with:(LPResumeNode *)node{
    if(node.type == 1){
        LPCategory *nodeData = node.nodeData;
        ((LPCategoryCell*)cell).count.text = nodeData.sonCnt;
    }
    else{
        LPResumeMessage *nodeData = node.nodeData;
        ((LPResumeMessageCell*)cell).name.text = nodeData.name;
        ((LPResumeMessageCell*)cell).commentLabel.text = nodeData.signture;
        
        if (arc4random()%2) {
            ((LPResumeMessageCell*)cell).sexImageView.hidden = YES;

        }
        else
        {
            ((LPResumeMessageCell*)cell).sexImageView.hidden = NO;
        }
        if (arc4random()%2) {
            ((LPResumeMessageCell*)cell).ageLabel.hidden = YES;
        }
        else
        {
            ((LPResumeMessageCell*)cell).ageLabel.hidden = NO;
        }
        
        if(nodeData.headImgPath != nil){
            //本地图片
            [((LPResumeMessageCell*)cell).headerView setImage:[UIImage imageNamed:nodeData.headImgPath]];
        }
        else if (nodeData.headImgUrl != nil){
            //加载图片，这里是同步操作。建议使用SDWebImage异步加载图片
            [((LPResumeMessageCell*)cell).headerView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:nodeData.headImgUrl]]];
        }
    }

}


/*---------------------------------------
 旋转箭头图标
 --------------------------------------- */
-(void) rotateArrow:(LPCategoryCell*) cell with:(double)degree{
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        cell.rightArrow.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
    } completion:NULL];
}


/*---------------------------------------
 修改cell的状态(关闭或打开)
 --------------------------------------- */

-(void) reloadDataForDisplayArrayChangeAt:(NSInteger)row{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    NSInteger cnt=0;
    for (LPResumeNode *node in _dataArray) {
        [tmp addObject:node];
        if(cnt == row){
            node.isExpanded = !node.isExpanded;
        }
        ++cnt;
        if(node.isExpanded){
            for(LPResumeNode *node2 in node.sonNodes){
                [tmp addObject:node2];
                if(cnt == row){
                    node2.isExpanded = !node2.isExpanded;
                }
                ++cnt;
                if(node2.isExpanded){
                    for(LPResumeNode *node3 in node2.sonNodes){
                        [tmp addObject:node3];
                        ++cnt;
                    }
                }
            }
        }
    }
    _displayArray = [NSArray arrayWithArray:tmp];
    
    
    [UIView animateWithDuration:1 animations:^{
        [self.tableView reloadData];
    }];
    
}



- (void)addTestData{
    LPResumeNode *node3 = [[LPResumeNode alloc]init];
    node3.nodeLevel = 0;//根层cell
    node3.type = 1;//type 1的cell
    node3.sonNodes = nil;
    node3.isExpanded = FALSE;//关闭状态
    LPCategory *tmp3 =[[LPCategory alloc]init];
    tmp3.name = @"琶洲展会派单";
    tmp3.sonCnt = @"琶洲展会派单 (4)";
    node3.nodeData = tmp3;
    
    LPResumeNode *node4 = [[LPResumeNode alloc]init];
    node4.nodeLevel = 0;
    node4.type = 1;
    node4.sonNodes = nil;
    node4.isExpanded = FALSE;
    LPCategory *tmp4 =[[LPCategory alloc]init];
    tmp4.name = @"南丰酒店日结兼职";
    tmp4.sonCnt = @"南丰酒店日结兼职 (2)";
    node4.nodeData = tmp4;
    
    
    LPResumeNode *node5 = [[LPResumeNode alloc]init];
    node5.nodeLevel = 1;//第一层节点
    node5.type = 2;//type 2的cell
    node5.sonNodes = nil;
    node5.isExpanded = FALSE;
    LPResumeMessage *tmp5 =[[LPResumeMessage alloc]init];
    tmp5.name = @"iJudson";
    tmp5.signture = @"好评率100%";
    tmp5.headImgPath = @"headerView.png";
    tmp5.headImgUrl = nil;
    node5.nodeData = tmp5;
    
    LPResumeNode *node6 = [[LPResumeNode alloc] init];
    node6.nodeLevel = 1;
    node6.type = 2;
    node6.sonNodes = nil;
    node6.isExpanded = FALSE;
    LPResumeMessage *tmp6 =[[LPResumeMessage alloc]init];
    tmp6.name = @"iJudson";
    tmp6.signture = @"好评率100%";
    tmp6.headImgPath = @"headerView.png";
    tmp6.headImgUrl = nil;
    node6.nodeData = tmp6;
    
    LPResumeNode *node7 = [[LPResumeNode alloc]init];
    node7.nodeLevel = 1;
    node7.type = 2;
    node7.sonNodes = nil;
    node7.isExpanded = FALSE;
    LPResumeMessage *tmp7 =[[LPResumeMessage alloc]init];
    tmp7.name = @"iJudson";
    tmp7.signture = @"好评率100%";
    tmp7.headImgPath = @"headerView.png";
    tmp7.headImgUrl = nil;
    node7.nodeData = tmp7;
    
    LPResumeNode *node8 = [[LPResumeNode alloc]init];
    node8.nodeLevel = 1;
    node8.type = 2;
    node8.sonNodes = nil;
    node8.isExpanded = FALSE;
    LPResumeMessage *tmp8 =[[LPResumeMessage alloc]init];
    tmp8.name = @"iJudson";
    tmp8.signture = @"好评率100%";
    tmp8.headImgPath = @"headerView.png";
    tmp8.headImgUrl = nil;
    node8.nodeData = tmp8;
    
    LPResumeNode *node9 = [[LPResumeNode alloc]init];
    node9.nodeLevel = 1;
    node9.type = 2;
    node9.sonNodes = nil;
    node9.isExpanded = FALSE;
    LPResumeMessage *tmp9 =[[LPResumeMessage alloc]init];
    tmp9.name = @"iJudson";
    tmp9.signture = @"好评率100%";
    tmp9.headImgPath = @"headerView.png";
    tmp9.headImgUrl = nil;
    node9.nodeData = tmp9;
    
    LPResumeNode *node0 = [[LPResumeNode alloc]init];
    node0.nodeLevel = 1;
    node0.type = 2;
    node0.sonNodes = nil;
    node0.isExpanded = FALSE;
    LPResumeMessage *tmp0 =[[LPResumeMessage alloc]init];
    tmp0.name = @"iJudson";
    tmp0.signture = @"好评率100%";
    tmp0.headImgPath = @"headerView.png";
    tmp0.headImgUrl = nil;
    node0.nodeData = tmp0;
    
    node3.sonNodes = [NSMutableArray arrayWithObjects:node5,node6,node7,node8,nil];//插入子节点
    node4.sonNodes = [NSMutableArray arrayWithObjects:node9,node0,nil];
    _dataArray = [NSMutableArray arrayWithObjects:node3,node4, nil];//插入到元数据数组

}


- (void)reloadDataForDisplayArray{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    for (LPResumeNode *node in _dataArray) {
        [tmp addObject:node];
    }
    
    _displayArray = [NSArray arrayWithArray:tmp];
    [self.tableView reloadData];
}


- (void)remindNewResume{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    LPRemindNewResume *newResume = [LPRemindNewResume remindNewResume];
    newResume.backgroundColor = [UIColor clearColor];
    self.remindResume = newResume;
    [keyWindow addSubview:newResume];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.remindResume removeFromSuperview];

}




@end
