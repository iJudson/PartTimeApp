//
//  ShareDataSource.h
//  duangongbangUser
//
//  Created by ljx on 15/3/9.
//  Copyright (c) 2015年 duangongbang. All rights reserved.
//

//      单例数据

#import <Foundation/Foundation.h>

@interface ShareDataSource : NSObject

@property (nonatomic, strong) id myData;

+ (ShareDataSource *)sharedDataSource;

@end
