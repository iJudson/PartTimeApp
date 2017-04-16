//
//  LPCategoryCell.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/9.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPCategoryCell.h"
#import "LPResumeNode.h"


@implementation LPCategoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//重新描绘cell
- (void)drawRect:(CGRect)rect
{
    int addX = _node.nodeLevel*25; //根据节点所在的层次计算平移距离
    CGRect imgFrame = _rightArrow.frame;
    imgFrame.origin.x = 14 + addX;
    _rightArrow.frame = imgFrame;
    
}


@end
