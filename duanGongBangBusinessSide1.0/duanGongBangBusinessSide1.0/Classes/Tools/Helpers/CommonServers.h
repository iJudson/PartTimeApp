//
//  CommonServers.h
//  duangongbang
//
//  Created by ljx on 15/7/3.
//  Copyright (c) 2015年 duangongbang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonServers : NSObject
+ (void)callAccountWithDict:(NSDictionary *)dict success:(void (^)(NSDictionary *object))success fail:(void (^)(NSString *reason))fail;
+ (void)callInitDataWithDict:(NSDictionary *)dict success:(void (^)(NSDictionary *object))success fail:(void (^)(NSString *reason))fail;
/**
 *  调用云端代码
 *
 *  @param apiName 接口名称
 *  @param dic     传入字典
 *  @param success 成功返回object
 *  @param fail    失败返回网络错误
 */
+ (void)callCloudWithAPIName:(NSString *)apiName andDic:(NSDictionary *)dic success:(void (^)(id object))success fail:(void (^)(NSString *reason))fail;

@end
