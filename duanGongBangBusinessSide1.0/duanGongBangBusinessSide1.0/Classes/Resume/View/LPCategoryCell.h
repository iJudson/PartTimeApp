//
//  LPCategoryCell.h
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/9.
//  Copyright © 2016年 lingpin. All rights reserved.
//


#import <UIKit/UIKit.h>
@class LPResumeNode;

@interface LPCategoryCell : UITableViewCell

// 定义数据模型的属性
@property(nonatomic,strong)LPResumeNode *node;

//箭头
@property (weak, nonatomic) IBOutlet UIImageView *rightArrow;
//叶子的名字和数量
@property (weak, nonatomic) IBOutlet UILabel *count;
//更多
@property (weak, nonatomic) IBOutlet UIImageView *more;

@end
