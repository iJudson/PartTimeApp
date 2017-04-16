//
//  LPPartTimeManagementController.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/6.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPPartTimeManagementController.h"
#import "LPExamingController.h"
#import "LPEmployingController.h"
#import "LPOffshelfController.h"
#import "LPDuanGongBangController.h"
#import "LPDgbTableHeaderView.h"

@interface LPPartTimeManagementController ()<LPDgbTableHeaderViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;

//存放按钮的数组
@property(nonatomic,strong)NSMutableArray *btnArray;

// 定义代理属性
@property(nonatomic,strong)LPDgbTableHeaderView *tabHeaderView;

// 定义属性
@property(nonatomic,assign)NSInteger choiceIndex;

@end

static NSString *const reuseIdentifier = @"LPPartTimeManagementCell";

@implementation LPPartTimeManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置colllectionView
    [self prepareForCollectionView];
    
    // 设置导航栏
    [self setupNav];
    
    // 初始化子控制器
    [self setupChildVCs];
    
     //设置顶部的标签栏
    [self setupTitlesView];

    
    
}


- (instancetype)init{
    
    //创建流水布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //这里设定的itemSize不可以太大，不然在短工邦控制器里面会出现大小约束的问题
    flowLayout.itemSize = CGSizeMake(LPScreenSize.width, LPScreenSize.height);
    
    //设置水平滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //  设置行距
    flowLayout.minimumLineSpacing = 0;
//    flowLayout.minimumInteritemSpacing = 0;
    
    return [super initWithCollectionViewLayout:flowLayout];
}

- (void)prepareForCollectionView{
    
    //设置collectionView
    self.collectionView.bounces = NO;
    self.collectionView.showsVerticalScrollIndicator =  NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor clearColor];
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    

//    UIGestureRecognizer * ges = [[UIGestureRecognizer alloc] init];
//    ges.delegate = self;
//    [self.collectionView addGestureRecognizer:ges];
}


////tableView的侧滑是从右往左滑。而抽屉是从左往右滑。 解决方法刚刚找到了，判断滑动的视图。
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    // 输出点击的view的类名
//    NSLog(@"%@", NSStringFromClass([touch.view class]));
//    
//    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
//    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableView"]) {
//        return NO;
//    }
//    return  YES;
//}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.childViewControllers.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    UIViewController *childVC = self.childViewControllers[indexPath.item];
    [cell addSubview:childVC.view];
    
    return cell;
}


- (void)setupNav{
    // 设置导航栏标题;
    self.navigationItem.title = @"兼职管理";
    
//    self.view.backgroundColor = [UIColor colorWithRed:(233)/255.0 green:(233)/255.0 blue:(233)/255.0 alpha:1.0];
}


- (void)setupChildVCs{
    LPExamingController * examingVC = [[LPExamingController alloc] init];
    [self addChildViewController:examingVC];
    
    LPEmployingController *employVC = [[LPEmployingController alloc] init];
    [self addChildViewController:employVC];
    
    LPOffshelfController *offSelfVC =[[LPOffshelfController alloc] init];
    [self addChildViewController:offSelfVC];
    
}


- (void)setupTitlesView{
    
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    titlesView.IJ_width = self.view.IJ_width;
    titlesView.IJ_height = 40;
    titlesView.IJ_y = 64;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的蓝色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = LPRGBColor(2,168,243);
    indicatorView.IJ_height = 4;
    indicatorView.tag = -1;
    indicatorView.IJ_y = titlesView.IJ_height - indicatorView.IJ_height;
    self.indicatorView = indicatorView;
    
    //原图片
    UIImage *bgImage = [UIImage imageNamed:@"bottomShawow"];
    // 设置端盖的值
    CGFloat top = bgImage.size.height * 0.5;
    CGFloat left = bgImage.size.width * 0.5;
    CGFloat bottom = bgImage.size.height * 0.5;
    CGFloat right = bgImage.size.width * 0.5;
    UIImage *strenchImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
    UIImageView *shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(indicatorView.frame), LPScreenSize.width, 4)];
    shadowView.image = strenchImage;
    [titlesView addSubview:shadowView];
    
    // 内部的子标签
    NSArray *titles = @[@"审核中", @"招聘中", @"已下架"];
    CGFloat width = titlesView.IJ_width / titles.count;
    CGFloat height = titlesView.IJ_height;
    for (NSInteger i = 0; i<titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.IJ_height = height;
        button.IJ_width = width;
        button.IJ_x = i * width;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        //        [button layoutIfNeeded]; // 强制布局(强制更新子控件的frame)
        [button setTitleColor:LPRGBColor(102,102,102) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        [self.btnArray addObject:button];
        // 默认点击了第一个按钮
        if (i == 0) {
            self.selectedButton = button;
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.IJ_width = button.titleLabel.IJ_width + 18;
            self.indicatorView.IJ_centerX = button.IJ_centerX;
        }
    }
    
    [titlesView addSubview:indicatorView];
}


- (void)titleClick:(UIButton *)button
{
    
    // 滚动
//    CGPoint offset = self.contentView.contentOffset;
//    offset.x = button.tag * self.contentView.IJ_width;
    
    // 动画
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:button.tag  inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [UIView animateWithDuration:0.20 animations:^{
        
        self.indicatorView.IJ_centerX = button.IJ_centerX;
        
    }];
    
}

#pragma mark - delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIButton *fBtn = self.btnArray[0];
    UIButton *sBtn = self.btnArray[1];
    //中心距离
    CGFloat centerDistance = sBtn.IJ_centerX - fBtn.IJ_centerX;
    //移动的距离
    CGFloat movingDistance = fBtn.IJ_centerX + centerDistance/LPScreenSize.width * scrollView.contentOffset.x;
    // 动画
    [UIView animateWithDuration:0.20 animations:^{
        self.indicatorView.IJ_centerX = movingDistance;
    }];
}

//让用户点击按钮之后跳转到相应的界面
-(void)setIndex:(NSInteger)index{
    
    self.choiceIndex = index;
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}


-(void)viewWillAppear:(BOOL)animated{
    
    UIButton *btn = self.btnArray[self.choiceIndex];
    self.indicatorView.IJ_centerX = btn.IJ_centerX;
}

#pragma mark - 懒加载
-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}



@end
