//
//  LPResumeMessageCell.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/8.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPResumeMessageCell.h"

@interface LPResumeMessageCell ()

@end


@implementation LPResumeMessageCell

- (void)awakeFromNib {
    
    //头像
    _headerView.layer.cornerRadius = 20.5;
    _headerView.clipsToBounds = YES;
    //性别
    _sexImageView.backgroundColor = LPRGBColor(2, 168, 243);
    _sexImageView.userInteractionEnabled = NO;
    _sexImageView.layer.cornerRadius = 2;
    [_sexImageView clipsToBounds];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
