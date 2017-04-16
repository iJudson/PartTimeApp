//
//  LPOutLineCell.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/15.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPOutLineCell.h"

@interface LPOutLineCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgView;

//标志
@property (weak, nonatomic) IBOutlet UIButton *logoSize;

@end

@implementation LPOutLineCell

- (void)awakeFromNib {
  
}


#pragma mark - setter
-(void)setIsNormalBgView:(BOOL)isNormalBgView{
    _isNormalBgView = isNormalBgView;
    if (self.isNormalBgView) {
        self.bgView.image = [UIImage imageNamed:@"normalCellBG"];
    }else{
        self.bgView.image = [UIImage imageNamed:@"bg_halfwrite_2x"];
    }

}


-(void)setImage:(UIImage *)image{
    _image = image;
    [self.logoSize setBackgroundImage:image forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [self.logoSize setTitle:title forState:UIControlStateNormal];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
