

#import "LPCarouselViewModel.h"
#import "LPCarousel.h"
#import "LPApiManager.h"

@implementation LPCarouselViewModel

+ (void)carouselDataWithCompletion:(void (^)(NSArray *responseObject,NSError *error))compeltion{
    [LPApiManager requestCarouselDataWithPath:@"ad/headline/0-4.html" completion:^(id responseObject, NSError *error) {
        NSMutableArray *caouselItems;
        if (responseObject) {
            NSArray *data = responseObject[@"headline_ad"];
            caouselItems = [NSMutableArray array];
            [data enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                LPCarousel *carousel = [LPCarousel carouselWithDict:obj];
                [caouselItems addObject:carousel];
            }];
        }
        compeltion(caouselItems.copy,error);
    }];
    
}



@end
