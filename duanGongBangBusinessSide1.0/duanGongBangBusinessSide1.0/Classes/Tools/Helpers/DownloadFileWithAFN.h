//
//  DownloadFileWithAFN.h
//  duangongbang
//
//  Created by ljx on 15/6/17.
//  Copyright (c) 2015年 duangongbang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface DownloadFileWithAFN : NSObject

+ (void)sessionDownloadWithUrl:(NSString *)urlStr success:(void (^)(NSURL *fileURL))success fail:(void (^)())fail progress:(void (^)(float prog))progress;
/**
 * 下载文件
 *
 * @param string aUrl 请求文件地址
 * @param string aSavePath 保存地址
 * @param string aFileName 文件名
 * @param int aTag tag标识
 */
//- (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName tag:(NSInteger)aTag;

@end
