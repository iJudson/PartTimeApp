//
//  LPCompanyHeaderView.h
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/3/31.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TapCompanyHeaderV <NSObject>

- (void)didTapimgview_longyellow;

@end

@interface LPCompanyHeaderView : UIView

// 定义去认证btn的image属性
@property(nonatomic,strong)UIImage *btnImage;
// 定义头像属性
@property(nonatomic,strong)UIImage *headImage;
// 定义认证等级属性
@property(nonatomic,strong)UIImage *authorImage;
// 定义公司名称属性
@property(nonatomic,copy)NSString *companyName;

@property (nonatomic, retain) id <TapCompanyHeaderV> delegate;

+ (instancetype)companyHeaderView;

@end
