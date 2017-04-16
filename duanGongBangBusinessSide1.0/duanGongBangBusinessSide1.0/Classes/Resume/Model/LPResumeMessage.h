//
//  LPResumeMessage.h
//  duanGongBangBusinessSide1.0
//
//  Created by 陈恩湖 on 16/4/9.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPResumeMessage : NSObject

//名字
@property (strong,nonatomic) NSString *name;

//签名
@property (strong,nonatomic) NSString *signture;

//本地图片名,若不为空则优先于远程图片加载
@property (strong,nonatomic) NSString *headImgPath;

@property (strong,nonatomic) NSURL *headImgUrl;//远程图片链接


@end
