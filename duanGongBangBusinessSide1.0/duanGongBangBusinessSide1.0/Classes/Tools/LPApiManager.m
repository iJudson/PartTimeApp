

#import "LPApiManager.h"

#import "LPHTTPSessionManager.h"

@implementation LPApiManager

+ (void)requestCarouselDataWithPath:(NSString *)path completion:(void (^)(id responseObject,NSError *error))compeltion{

    [self requestDataWithPath:path completion:compeltion];
}


+ (void)requestNewsDataWithPath:(NSString *)path completion:(void (^)(id responseObject,NSError *error))compeltion{

    [self requestDataWithPath:path completion:compeltion];
}

//封装网络底层工具类方法,便于所有的网络接口类方法调用
+ (void)requestDataWithPath:(NSString *)path completion:(void (^)(id responseObject,NSError *error))compeltion{
    NSAssert(compeltion != nil, @"网络请求不可以为空");
    [[LPHTTPSessionManager shareInstance] GET:path parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        compeltion(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        compeltion(nil,error);
    }];
}


@end
