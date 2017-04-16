//
//  LPPageControl.m
//  duanGongBangBusinessSide1.0
//
//  Created by likar on 16/3/23.
//  Copyright © 2016年 lingpin. All rights reserved.
//

#import "LPPageControl.h"

@interface LPPageControl ()

//主要用于记录上一个subView
@property(nonatomic,strong)UIImageView *lastsubView;

@end

@implementation LPPageControl


//重写currentPage方法，重新设定选中点的大小
-(void)setCurrentPage:(NSInteger)currentPage{
  [super setCurrentPage:currentPage];
  for (NSUInteger subViewIndex = 0; subViewIndex < [self.subviews count]; subViewIndex ++) {
    UIImageView *subView = [self.subviews objectAtIndex:subViewIndex];
    subView.backgroundColor = [UIColor whiteColor];
    CGSize size = CGSizeMake(4, 4);
    [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, size.width, size.height)];
    
    
    if (subViewIndex == currentPage) {
      self.lastsubView = subView;
      [subView setBackgroundColor:self.currentPageIndicatorTintColor];
      
      [UIView animateWithDuration:0.4 animations:^{
        [self.lastsubView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, 4, 4)];
        [subView setFrame:CGRectMake(subView.frame.origin.x, subView.frame.origin.y, 6, 6)];
      }];
     
      }
  }
}




@end
