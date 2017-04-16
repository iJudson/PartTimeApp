//
//  DownloadFileWithAFN.m
//  duangongbang
//
//  Created by ljx on 15/6/17.
//  Copyright (c) 2015年 duangongbang. All rights reserved.
//

#import "DownloadFileWithAFN.h"

@implementation DownloadFileWithAFN
+ (void)sessionDownloadWithUrl:(NSString *)urlStr success:(void (^)(NSURL *fileURL))success fail:(void (^)())fail progress:(void (^)(float prog))progress
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    NSString *urlString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        // 指定下载文件保存的路径
        //        NSLog(@"%@ %@", targetPath, response.suggestedFilename);
        // 将下载文件保存在缓存路径中
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
        
        // URLWithString返回的是网络的URL,如果使用本地URL,需要注意
        //        NSURL *fileURL1 = [NSURL URLWithString:path];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        
        //        NSLog(@"== %@ |||| %@", fileURL1, fileURL);
        
//        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//        operation.inputStream   = [NSInputStream inputStreamWithURL:url];
//        operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:path append:NO];
//        
////        下载进度控制
//         [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//         LOG(@"is download：%f", (float)totalBytesRead/totalBytesExpectedToRead);
//             float prog = (float)totalBytesRead/totalBytesExpectedToRead;
//             progress(prog);
//         }];
        
        if (success) {
            success(fileURL);
        }
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        LOG(@"%@ %@", filePath, error);
        if (fail) {
            fail();
        }
    }];
    
    [task resume];
}

/**
 * 下载文件
 */
//- (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName tag:(NSInteger)aTag
//{
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    //检查本地文件是否已存在
//    NSString *fileName = [NSString stringWithFormat:@"%@/%@", aSavePath, aFileName];
//    
//    //检查附件是否存在
//    if ([fileManager fileExistsAtPath:fileName]) {
//        NSData *audioData = [NSData dataWithContentsOfFile:fileName];
//        [self requestFinished:[NSDictionary dictionaryWithObject:audioData forKey:@"res"] tag:aTag];
//    }else{
//        //创建附件存储目录
//        if (![fileManager fileExistsAtPath:aSavePath]) {
//            [fileManager createDirectoryAtPath:aSavePath withIntermediateDirectories:YES attributes:nil error:nil];
//        }
//        
//        //下载附件
//        NSURL *url = [[NSURL alloc] initWithString:aUrl];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        
//        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//        operation.inputStream   = [NSInputStream inputStreamWithURL:url];
//        operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];
//        
//        //下载进度控制
//        
//        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//            NSLog(@"is download：%f", (float)totalBytesRead/totalBytesExpectedToRead);
//        }];
//         
//        
//        //已完成下载
//        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//            NSData *audioData = [NSData dataWithContentsOfFile:fileName];
//            //设置下载数据到res字典对象中并用代理返回下载数据NSData
//            [self requestFinished:[NSDictionary dictionaryWithObject:audioData forKey:@"res"] tag:aTag];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//            //下载失败
//            [self requestFailed:aTag];
//        }];
//        
//        [operation start];
//    }
//}
@end
