
/*
 这个类继承AFHTTPSessionManager，主要是用于封装网络模型的工具类
*/

#import <AFNetworking/AFNetworking.h>


@interface LPHTTPSessionManager : AFHTTPSessionManager

//创建网络单例类
+ (instancetype)shareInstance;

@end
