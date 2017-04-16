

#import "LPCarousel.h"

@implementation LPCarousel

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

//防止未定义的key，造成错误
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

+ (instancetype)carouselWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
