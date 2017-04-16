//
//  UIView+IJExtension.m
//
//  Created by 陈恩湖 on 14-11-14.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "UIView+IJExtension.h"

@implementation UIView (IJExtension)

- (void)setIJ_x:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)IJ_x{
    return self.frame.origin.x;
}
- (void)setIJ_y:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)IJ_y{
    return self.frame.origin.y;
}
- (void)setIJ_centerX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)IJ_centerX{
    return self.center.x;
}

- (void)setIJ_centerY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)IJ_centerY{
    return self.center.y;
}

- (void)setIJ_width:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)IJ_width{
    return self.frame.size.width;
}

- (void)setIJ_height:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)IJ_height{
    return self.frame.size.height;
}

- (void)setIJ_size:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)IJ_size{
    return self.frame.size;
}

@end