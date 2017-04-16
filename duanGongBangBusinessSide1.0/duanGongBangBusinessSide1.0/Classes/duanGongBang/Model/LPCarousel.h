
#import <Foundation/Foundation.h>

@interface LPCarousel : NSObject

/// 标题
@property (nonatomic, copy) NSString *title;
/// 图片路径
@property (nonatomic, copy) NSString *imgsrc;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)carouselWithDict:(NSDictionary *)dict;

@end
