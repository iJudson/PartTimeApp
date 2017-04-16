

#import "LPCarouselCell.h"
#import "LPCarousel.h"
#import "LPPageControl.h"

#import <UIImageView+WebCache.h>


@interface LPCarouselCell ()

//item上面显示的图片
@property (strong,nonatomic) UIImageView *itemImageView;


@end


@implementation LPCarouselCell

-(void)setCarousel:(LPCarousel *)carousel{
    _carousel = carousel;
    //设置cell中的子控件
    [self prepareForCell];

    //设置占位的图片
   [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:_carousel.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority];
}

#pragma mark - 准备UI
- (void)prepareForCell{
    //添加子控件
    [self.contentView addSubview:self.itemImageView];

    [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //上下左右都与父控件对齐
        make.left.right.top.bottom.equalTo(self);
    }];
  
}

#pragma mark - 懒加载
-(UIImageView *)itemImageView{
    if (!_itemImageView) {
        _itemImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _itemImageView;
}



@end
