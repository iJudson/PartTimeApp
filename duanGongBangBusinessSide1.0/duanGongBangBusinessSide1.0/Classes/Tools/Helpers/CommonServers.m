//
//  CommonServers.m
//  duangongbang
//
//  Created by ljx on 15/7/3.
//  Copyright (c) 2015年 duangongbang. All rights reserved.
//

#import "CommonServers.h"
#import <BmobSDK/BmobCloud.h>
#import "SVProgressHUD.h"
@implementation CommonServers

#pragma mark - servers
+ (void)callAccountWithDict:(NSDictionary *)dict success:(void (^)(NSDictionary *object))success fail:(void (^)(NSString *reason))fail{
    NSDictionary *inputData = [NSDictionary dictionaryWithObject:dict forKey:@"inputData"];

    [BmobCloud callFunctionInBackground:M_V4_Account withParameters:inputData block:^(id object, NSError *err){
        if (!err) {
            if ([object isKindOfClass:[NSDictionary class]]) {
                success(object);
            }else if ([object isKindOfClass:[NSString class]]){
                [SVProgressHUD showErrorWithStatus:@"数据异常，未知错误"];
                return;
            }else{
                fail(kDataErrorWarning);
            }

        }else{
                fail(kNetworkWarning);
                LOG(@"getmaindataerror%@",err);
            }

    }];
    
}
+ (void)callInitDataWithDict:(NSDictionary *)dict success:(void (^)(NSDictionary *object))success fail:(void (^)(NSString *reason))fail{
    NSDictionary *inputData = [NSDictionary dictionaryWithObject:dict forKey:@"inputData"];
    
    [BmobCloud callFunctionInBackground:M_V4_Account withParameters:inputData block:^(id object, NSError *err){
        if (!err) {
            if ([object isKindOfClass:[NSDictionary class]]) {
                success(object);
            }else if ([object isKindOfClass:[NSString class]]){
                [SVProgressHUD showErrorWithStatus:@"数据异常，未知错误"];
                return;
            }else{
                fail(kDataErrorWarning);
            }

        }else{
            fail(kNetworkWarning);
            LOG(@"getmaindataerror%@",err);
        }
    }];
    
}

+ (void)callCloudWithAPIName:(NSString *)apiName andDic:(NSDictionary *)dic success:(void (^)(id object))success fail:(void (^)(NSString *error))fail{

    NSDictionary *inputData = [NSDictionary dictionaryWithObject:dic forKey:@"inputData"];
    
    [BmobCloud callFunctionInBackground:apiName withParameters:inputData block:^(id object, NSError *err){
        if (!err) {
            if ([object isKindOfClass:[NSDictionary class]]) {
                success(object);
            }else if ([object isKindOfClass:[NSString class]]){
                [SVProgressHUD showErrorWithStatus:@"数据异常，未知错误"];
                return;
            }else{
                fail(kDataErrorWarning);
            }
        }else{
            fail(kNetworkWarning);
            LOG(@"getListDataError%@",err);
        }
    }];
    


}

@end
