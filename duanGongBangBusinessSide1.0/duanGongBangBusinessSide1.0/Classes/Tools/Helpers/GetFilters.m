//
//  GetFilters.m
//  duangongbang
//
//  Created by ljx on 15/5/21.
//  Copyright (c) 2015年 duangongbang. All rights reserved.
//

#import "GetFilters.h"

@implementation GetFilters

+ (NSDictionary *)getAllAreaWithArray:(NSArray *)areaArray{
    
    NSMutableArray *area = [NSMutableArray arrayWithArray:areaArray];
    
    NSMutableArray *areaWithName = [NSMutableArray arrayWithCapacity:area.count];
    NSMutableArray *areaWithObjectId = [NSMutableArray arrayWithCapacity:area.count];
//    
//    NSMutableArray *areaWithNameArray;
//    NSMutableArray *areaWithObjectIdArray;
//    NSMutableArray *allAreaWithNameArray;
//    NSMutableArray *allAreaWithObjectIdArray;
//    
    for (int i = 0; i < area.count; i++) {
        if (i == 0) {
            [areaWithName addObject:@"全城"];
            [areaWithObjectId addObject:[[area objectAtIndex:i] objectForKey:@"objectId"]];
        }else{
            [areaWithName addObject:[[area objectAtIndex:i] objectForKey:@"AreaName"] ? [[area objectAtIndex:i] objectForKey:@"AreaName"] : @""];
            [areaWithObjectId addObject:[[area objectAtIndex:i] objectForKey:@"objectId"] ? [[area objectAtIndex:i] objectForKey:@"objectId"] : @""];
        }
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         areaWithName,@"areaName",
                         areaWithObjectId,@"areaObject",nil];
    return dic;
}

+ (NSDictionary *)getAllClassisfyWithArray:(NSArray *)classifyArray{
    
    NSMutableArray *classify = [NSMutableArray arrayWithArray:classifyArray];
    
    NSMutableArray *classifyWithName = [NSMutableArray arrayWithCapacity:classify.count];
    NSMutableArray *classifyWithObjectId = [NSMutableArray arrayWithCapacity:classify.count];
    NSMutableArray *classifyWithNameArray = nil;
    NSMutableArray *classifyWithObjectIdArray = nil;
    NSMutableArray *allClassifyWithNameArray = [[NSMutableArray alloc] init];
    NSMutableArray *allClassifyWithObjectIdArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < classify.count; i++) {
        
        [classifyWithName addObject:[[classify objectAtIndex:i] objectForKey:@"ClassifyName"]];
        [classifyWithObjectId addObject:[[classify objectAtIndex:i] objectForKey:@"objectId"]];
        classifyWithNameArray = [NSMutableArray arrayWithCapacity:[(NSArray *)[[classify objectAtIndex:i] objectForKey:@"Classifies"] count]];
        classifyWithObjectIdArray =  [NSMutableArray arrayWithCapacity:[(NSArray *)[[classify objectAtIndex:i] objectForKey:@"Classifies"] count]];
        for (int j = 0; j < [(NSArray *)[[classify objectAtIndex:i] objectForKey:@"Classifies"] count]; j++) {
            
            [classifyWithNameArray addObject:[[[[classify objectAtIndex:i] objectForKey:@"Classifies"] objectAtIndex:j] objectForKey:@"ClassifyName"] ? [[[[classify objectAtIndex:i] objectForKey:@"Classifies"] objectAtIndex:j] objectForKey:@"ClassifyName"] : @""];
            [classifyWithObjectIdArray addObject:[[[[classify objectAtIndex:i] objectForKey:@"Classifies"] objectAtIndex:j] objectForKey:@"objectId"] ? [[[[classify objectAtIndex:i] objectForKey:@"Classifies"] objectAtIndex:j] objectForKey:@"objectId"] : @""];
        }
        
        [allClassifyWithNameArray addObject:classifyWithNameArray];
        [allClassifyWithObjectIdArray addObject:classifyWithObjectIdArray];
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         classifyWithName,@"classifyName",
                         classifyWithObjectId,@"classifyObjectId",
                         allClassifyWithNameArray,@"classifyNameArray",
                         allClassifyWithObjectIdArray,@"classifyObjectIdArray",nil];
    return dic;
}
@end
