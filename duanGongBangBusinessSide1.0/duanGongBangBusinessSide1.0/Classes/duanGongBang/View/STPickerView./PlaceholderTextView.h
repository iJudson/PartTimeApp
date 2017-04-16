//
//  PlaceholderTextView.h
//  SaleHelper
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 Burning_git. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlaceholderTextH <NSObject>
- (void)refreshlaceholderTextH:(float)TextH andIndexPath:(NSIndexPath *)IndexPath andtext:(NSString *)text andtag:(NSInteger)tag;

//- (void)refreshlaceholderTextH:(float)TextH andIndexPath:(NSIndexPath *)IndexPath;

@end

/**
 *  要是用非 arc。。。。。。／／     -fno-objc-arc
 */
@interface PlaceholderTextView : UITextView

@property(copy,nonatomic) NSString *placeholder;
@property(strong,nonatomic) UIColor *placeholderColor;
@property(strong,nonatomic) UIFont * placeholderFont;
@property (strong,nonatomic) NSIndexPath * btnIndexPath;
@property (nonatomic, retain) id <PlaceholderTextH> delegate_TextH;


@property(strong,nonatomic) NSString *Type;


@end

