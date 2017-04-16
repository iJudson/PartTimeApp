//
//  LPResumeMessageCell.h
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/8.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LPResumeNode.h"

@interface LPResumeMessageCell : UITableViewCell

// 定义模型属性
@property(nonatomic,strong)LPResumeNode *node;

//头像
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
//名字
@property (weak, nonatomic) IBOutlet UILabel *name;
//评价
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
//性别图片
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
//性别文字label
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
//年龄
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
//分割线
@property (weak, nonatomic) IBOutlet UIView *seperatorLine;


@end
