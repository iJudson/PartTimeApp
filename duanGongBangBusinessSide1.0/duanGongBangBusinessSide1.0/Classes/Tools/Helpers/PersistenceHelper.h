//
//  PersistenceHelper.h
//  duangongbang
//
//  Created by ljx on 15/5/26.
//  Copyright (c) 2015年 duangongbang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface PersistenceHelper : NSObject

singleton_interface(PersistenceHelper)

-(void)archiveData:(id)object  withKey:(NSString*)key;
-(id)unarchiveDatawithKey:(NSString*)key;
-(NSString*)getFilePathWithKey:(NSString*)key;
-(BOOL)deleteFileWithKey:(NSString*)key;

@end
