//
//  LPDgbTableHeaderView.h
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/4.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LPDgbTableHeaderViewDelegate <NSObject>

@optional
- (void)didSelectedReleaseButton;
- (void)didSelectedButton:(UIButton*) btn;

- (void)didSelectedJumpingButton:(UIButton *)btn;


@end


@interface LPDgbTableHeaderView : UIView

+ (instancetype)dgbTableHeaderView;


// 定义代理属性
@property(nonatomic,weak)id<LPDgbTableHeaderViewDelegate> tableHeaderViewDelegate;


@end
