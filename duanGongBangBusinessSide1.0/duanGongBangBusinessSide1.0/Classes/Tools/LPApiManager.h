
/**
 *  这个类是专门用于封装某一个模块，或者整个应用程序中的网络请求（通过单例或者类方法都可以）
 */

#import <Foundation/Foundation.h>

@interface LPApiManager : NSObject

/**
 * 头条数据的网络接口请求
 *
 *  @param path       请求的路径
 *  @param compeltion:
                responseObject:请求成功之后返回的数据
                         error:请求失败之后返回的数据
 */
+ (void)requestCarouselDataWithPath:(NSString *)path completion:(void (^)(id responseObject,NSError *error))compeltion;

//请求tableViewCell中的每一栏新闻，参数同上
+ (void)requestNewsDataWithPath:(NSString *)path completion:(void (^)(id responseObject,NSError *error))compeltion;

@end
