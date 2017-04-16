

#import "LPHTTPSessionManager.h"

@implementation LPHTTPSessionManager


+ (instancetype)shareInstance{
    static LPHTTPSessionManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //使用默认的配置即可
        NSURLSessionConfiguration * configure = [NSURLSessionConfiguration defaultSessionConfiguration];
        //配置超时时间
        configure.timeoutIntervalForRequest = 15;
        
        manager = [[LPHTTPSessionManager alloc] initWithBaseURL:LPBaseUrl sessionConfiguration:configure];
        //设置内容样式（content-type）
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    });
    return manager;
}


@end
