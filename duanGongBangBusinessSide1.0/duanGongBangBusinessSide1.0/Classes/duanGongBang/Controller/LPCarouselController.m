//
//  LPLunBoController.m
//  duanGongBangBusinessSide1.0
//
//  Created by Judson on 16/3/15.
//  Copyright © 2016年 lingpin. All rights reserved.
//


#import "LPCarouselController.h"
#import "LPCarouselViewModel.h"
#import "LPCarouselCell.h"
#import "LPCarousel.h"
#import "LPPageControl.h"


@interface LPCarouselController ()

//存放从后台拿到的轮播器的图片数据
@property (strong,nonatomic) NSArray *carousels;
//自定义的cell
@property (strong,nonatomic) LPCarouselCell *carouselCell;

//是否正在拖动
@property (nonatomic,assign) BOOL isDragging;

// 定义section数属性
@property(nonatomic,assign)NSInteger sectionIndex;
// 定义item数属性
@property(nonatomic,assign)NSInteger itemIndex;

//设置动画
@property (nonatomic,strong)NSTimer *timer;

@end

@implementation LPCarouselController

static NSString * const reuseIdentifier = @"LPCarouselCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.itemIndex =0;
    self.sectionIndex =0;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self prepareForCollectionView];
    [self loadData];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.5f target:self selector:@selector(update:) userInfo:nil repeats:YES];
  
  //将定时器添加到主线程中
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)update:(NSTimer * )timer{
    if (self.isDragging) {
        return;
    }
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.itemIndex  inSection:self.sectionIndex] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    if (self.currentpageBlock) {
        self.currentpageBlock(self.itemIndex);
    }
    self.itemIndex ++ ;
    if (self.itemIndex >= 4) {
        self.sectionIndex ++ ;
        self.itemIndex = 0;
    }
    
}


- (instancetype)init{
    //创建流水布局对象
     UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //这里设定的itemSize不可以太大，不然在短工邦控制器里面会出现大小约束的问题
    flowLayout.itemSize = CGSizeMake(LPScreenSize.width, 100);

     //设置水平滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

     //  设置行距
     flowLayout.minimumLineSpacing = 0;

   return [super initWithCollectionViewLayout:flowLayout];
}


- (void)prepareForCollectionView{
    
    //设置collectionView
    self.collectionView.bounces = NO;
    self.collectionView.showsVerticalScrollIndicator =  NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    
    // Register cell classes
    [self.collectionView registerClass:[LPCarouselCell class] forCellWithReuseIdentifier:reuseIdentifier];
  
}


#pragma mark - 数据相关
- (void)loadData{
    
    [LPCarouselViewModel carouselDataWithCompletion:^(NSArray *responseObject, NSError *error) {
        if (error) {
            NSLog(@"轮播器加载数据时出现错误error: %@",error);
        }
        self.carousels = responseObject;
        
        [self.collectionView reloadData];
      
    }];
    
}

#pragma mark - datasource&&代理方法

//开始拉动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  self.isDragging = YES;
  //关闭定时器
  [self.timer setFireDate:[NSDate distantFuture]];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return LPCarouselSectionCount;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.carousels.count;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LPCarouselCell *cell = (LPCarouselCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    self.carouselCell = cell;
    cell.carousel = self.carousels[indexPath.row];
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    //当前的页码
    NSInteger pageIndex = index%self.carousels.count;
  
    //当前所在是第几个section
    NSInteger sectionIndex = index/self.carousels.count;
  
    self.itemIndex = pageIndex;
    self.sectionIndex = sectionIndex;
    
    //用于传值的block
    if (self.currentpageBlock) {
      self.currentpageBlock(pageIndex);
    }
  
    //判断当前的section数
    if (sectionIndex < 2 || sectionIndex > LPCarouselSectionCount-2) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:pageIndex inSection:LPCarouselSectionCount/2] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    //开启定时器
    [self.timer setFireDate:[NSDate distantPast]];
    self.isDragging = NO;
}


//便于外界传值的一个方法
- (void)returnCurrentPageBlock:(CurrentPageIndex)block{
  self.currentpageBlock = block;
}


-(void)dealloc{
    
    [self.timer invalidate];
    self.timer = nil;
}


@end
