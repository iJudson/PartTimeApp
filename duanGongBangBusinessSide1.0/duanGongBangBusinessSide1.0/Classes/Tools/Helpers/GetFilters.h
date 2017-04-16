//
//  GetFilters.h
//  duangongbang
//
//  Created by ljx on 15/5/21.
//  Copyright (c) 2015年 duangongbang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kClassifyName @"classifyName"
#define kClassifyObjectId @"classifyObjectId"
#define kClassifyNameArray @"classifyNameArray"
#define kClassifyObjectIdArray @"classifyObjectIdArray"

#define kAreaName @"areaName"
#define kAreaObject @"areaObject"

@interface GetFilters : NSObject

+ (NSDictionary *)getAllAreaWithArray:(NSArray *)areaArray;

+ (NSDictionary *)getAllClassisfyWithArray:(NSArray *)classifyArray;

@end
