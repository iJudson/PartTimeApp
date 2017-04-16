//
//  LPCompanyHeaderView.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/3/31.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPCompanyHeaderView.h"
//#define LPCompanyGlobalPadding 7
@interface LPCompanyHeaderView ()
//
//// 定义去认证的属性
//@property(nonatomic,strong)UIButton *authorButton;
//// 定义头像下面圈圈的图层属性
//@property(nonatomic,strong)UIImageView *circleImageView;
//// 定义头像属性
//@property(nonatomic,strong)UIImageView *headerImageView;
//// 定义公司属性
//@property(nonatomic,strong)UILabel *companyNameLabel;
//// 定义认证属性
//@property(nonatomic,strong)UIImageView *authorImageView;
@property (weak, nonatomic) IBOutlet UIImageView *authorImageView;

@property (weak, nonatomic) IBOutlet UIImageView *circleImageView;

@property (weak, nonatomic) IBOutlet UIImageView *headerView;

@end


@implementation LPCompanyHeaderView

+ (instancetype)companyHeaderView{
    return [[[NSBundle mainBundle] loadNibNamed:@"LPCompanyHeaderView" owner:nil options:nil] lastObject];
}

-(void)setFrame:(CGRect)frame{
    CGRect cframe = CGRectMake(0, 0, LPScreenSize.width, 204);
    [super setFrame:cframe];
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.headerView.layer.cornerRadius = 55;
    self.headerView.clipsToBounds = YES;
    
    self.circleImageView.layer.borderColor = LPRGBColor(170, 161, 159).CGColor;
    self.circleImageView.layer.borderWidth = 2;
    self.circleImageView.layer.cornerRadius = 63;
    self.circleImageView.clipsToBounds = YES;
    
    self.authorImageView.layer.cornerRadius = 7.5;
    self.authorImageView.clipsToBounds = YES;
    
}

- (IBAction)makeAuthor:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didTapimgview_longyellow)]) {
        [self.delegate didTapimgview_longyellow];
    }
}



@end
