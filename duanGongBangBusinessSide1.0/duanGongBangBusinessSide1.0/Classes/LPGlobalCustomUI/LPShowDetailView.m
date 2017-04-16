//
//  LPShowDetailView.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/1.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPShowDetailView.h"

@interface LPShowDetailView ()

// 定义数字属性
@property(nonatomic,strong)UILabel *numberLabel;
// 定义文字描述属性
@property(nonatomic,strong)UILabel *textLabel;

@end

@implementation LPShowDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self prepareForUI];
        
    }
    return self;
}

#pragma mark - UI方面的所有设置
- (void)prepareForUI{
    //添加所有的子控件
    [self addSubview:self.numberLabel];
    [self addSubview:self.textLabel];
    
    //为所有的子控件设置约束
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(10);
        make.width.equalTo(self);
    }];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-10);
        make.width.equalTo(self);
    }];
}



#pragma mark - getter

-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = [UIColor blackColor];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    return _numberLabel;
}


-(UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textColor = [UIColor darkGrayColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:10];
    }
    return _textLabel;
}

#pragma mark - setter
-(void)setNumberString:(NSString *)numberString{
    _numberString = numberString;
    self.numberLabel.text = numberString;
}

-(void)setTextString:(NSString *)textString{
    _textString = textString;
    self.textLabel.text = textString;
}

@end

