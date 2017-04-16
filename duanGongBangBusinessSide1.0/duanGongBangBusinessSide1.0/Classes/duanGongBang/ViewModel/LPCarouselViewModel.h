///这个类（viewModel）主要用于处理数据

#import <Foundation/Foundation.h>

@interface LPCarouselViewModel : NSObject

/**
 *  主要是被controller去调用，可以尽量简单，返回成功或者失败的数据即可
 *
 *  @param compeltion
 responseObject：向服务器拿到数据之后，字典数组成功转成模型数组
 error：失败之后返回的数据
 */
+ (void)carouselDataWithCompletion:(void (^)(NSArray *responseObject,NSError *error))compeltion;

@end
