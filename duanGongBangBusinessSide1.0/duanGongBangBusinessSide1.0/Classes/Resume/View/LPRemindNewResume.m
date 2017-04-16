//
//  LPRemindNewResume.m
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/9.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPRemindNewResume.h"

@interface LPRemindNewResume ()



@end

@implementation LPRemindNewResume

+ (instancetype)remindNewResume{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LPRemindNewResume" owner:nil options: nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.frame = CGRectMake(0, LPNavBarHeight, LPScreenSize.width, 60);
}


@end
