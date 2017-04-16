//
//  LPLunBoController.h
//  duanGongBangBusinessSide1.0
//
//  Created by Judson on 16/3/15.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import <UIKit/UIKit.h>

//重新定义一个block
typedef void (^CurrentPageIndex) (NSInteger index);


@interface LPCarouselController : UICollectionViewController

//定义block变量
@property(nonatomic,copy)CurrentPageIndex currentpageBlock;

//便于外界传值的一个方法
- (void)returnCurrentPageBlock:(CurrentPageIndex)block;

@end
