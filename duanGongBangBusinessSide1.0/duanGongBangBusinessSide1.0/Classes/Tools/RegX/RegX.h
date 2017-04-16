//
//  RegX.h
//  loginDemo
//
//  Created by apple on 15/1/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegX : NSObject

//邮箱验证
+ (BOOL) validateEmail:(NSString *)email;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//电话号码验证
+ (BOOL) validateTelPhone:(NSString *)telPhone;
@end
