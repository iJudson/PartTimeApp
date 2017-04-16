//
//  LPTabBar.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/15.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPTabBar.h"

@implementation LPTabBar

+ (instancetype)returnATabBar{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LPTabBar" owner:nil options:nil] lastObject];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.9;
}

@end
