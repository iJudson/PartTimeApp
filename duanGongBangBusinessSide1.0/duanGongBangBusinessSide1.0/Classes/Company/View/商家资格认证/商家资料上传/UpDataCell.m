//
//  UpDataCell.m
//  duanGongBangBusinessSide1.0
//
//  Created by ljx on 16/4/16.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "UpDataCell.h"

@implementation UpDataCell

- (void)awakeFromNib {

    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, Width - 24, self.img.frame.size.height);
    borderLayer.position = CGPointMake(Width/2 - 12, 102);
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:4].CGPath;
    borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale];
    //虚线边框
    borderLayer.lineDashPattern = @[@8, @8];
    //实线边框
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor whiteColor].CGColor;
    [self.img.layer addSublayer:borderLayer];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
