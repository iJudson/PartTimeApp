//
//  LPDgbSecondCell.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/4.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPDgbFirstCell.h"

@interface LPDgbFirstCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;


@end


@implementation LPDgbFirstCell

- (void)awakeFromNib {
    //原图片
    UIImage *bgImage = [UIImage imageNamed:@"bg_halfwrite_2x"];
    // 设置端盖的值
    CGFloat top = bgImage.size.height * 0.5;
    CGFloat left = bgImage.size.width * 0.5;
    CGFloat bottom = bgImage.size.height * 0.5;
    CGFloat right = bgImage.size.width * 0.5;
    /*
     经过拉伸之后的图片
     UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
     UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图片
     */
    UIImage *strenchImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
    self.bgImageView.image = strenchImage;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
