//
//  ShareDataSource.m
//  duangongbangUser
//
//  Created by ljx on 15/3/9.
//  Copyright (c) 2015年 duangongbang. All rights reserved.
//

#import "ShareDataSource.h"

@implementation ShareDataSource

+(ShareDataSource *)sharedDataSource{
    
    static ShareDataSource *dataSource = nil;
    
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        dataSource = [ShareDataSource new];
    });
    
    return dataSource;
}

@end
