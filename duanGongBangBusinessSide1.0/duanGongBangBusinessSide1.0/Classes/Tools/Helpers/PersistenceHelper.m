//
//  PersistenceHelper.m
//  duangongbang
//
//  Created by ljx on 15/5/26.
//  Copyright (c) 2015年 duangongbang. All rights reserved.
//

#import "PersistenceHelper.h"


@implementation PersistenceHelper

//持久化Model
- (void)archiveData:(id)object withKey:(NSString*)key;
{
    
    NSString *path = [self getFilePathWithKey:key];
    
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:object forKey:key];
    [archiver finishEncoding];
    
    [data writeToFile:path atomically:YES];
    LOG(@"保存数据成功archiveData");
    
}

- (BOOL)deleteFileWithKey:(NSString *)key
{
    NSString *path  = [self getFilePathWithKey:key];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSFileManager *file = [NSFileManager defaultManager];
        NSError *error = [[NSError alloc]init];
        return [file removeItemAtPath:path error:&error];
    }else
    {
        return true;
    }
    
}
- (id)unarchiveDatawithKey:(NSString*)key;
{
     NSString *path = [self getFilePathWithKey:key];
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSData *data = [[NSMutableData alloc]
                        initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                         initForReadingWithData:data];
        
        id object = [unarchiver decodeObjectForKey:key];
        
        return object;
    }
    return nil;
}


//获得userModel持久化文件保存的路径
- (NSString*)getFilePathWithKey:(NSString*)key
{
    NSArray * paths =NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *fileName  =  [NSString stringWithFormat:@"%@.archive",key];
    return [documentDirectory stringByAppendingString:fileName];
}

singleton_implementation(PersistenceHelper)

@end
