//
//  LPWholeHeaderView.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/13.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPWholeHeaderView.h"

@implementation LPWholeHeaderView

+ (instancetype)returnWholeHeaderView{

    return [[[NSBundle mainBundle] loadNibNamed:@"LPWholeHeaderView" owner:nil  options:nil] lastObject];
}




@end
