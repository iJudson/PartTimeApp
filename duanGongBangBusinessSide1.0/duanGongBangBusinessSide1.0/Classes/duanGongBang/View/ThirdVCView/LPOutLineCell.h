//
//  LPOutLineCell.h
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/15.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPOutLineCell : UITableViewCell

// 定义判断到底使用哪一张背景图片属性
@property(nonatomic,assign)BOOL isNormalBgView;

// 定义标志属性
@property(nonatomic,strong)UIImage *image;


// 定义标题属性
@property(nonatomic,strong)NSString *title;

@end
