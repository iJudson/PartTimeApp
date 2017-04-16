//
//  TimeCaculate.m
//  duangongbang
//
//  Created by ljx on 15/5/26.
//  Copyright (c) 2015年 duangongbang. All rights reserved.
//

#import "TimeCaculate.h"

@implementation TimeCaculate
+ (NSString *)getUTCFormateDate:(NSString *)newsDate {
    //    newsDate = @"2013-08-09 17:01";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *newsDateFormatted = [dateFormatter dateFromString:newsDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    NSDate *current_date = [[NSDate alloc] init];
    
    NSTimeInterval time = [current_date timeIntervalSinceDate:newsDateFormatted];//间隔的秒数
    int month = ((int)time) / (3600 * 24 * 30);
    int days = ((int)time) / (3600 * 24);
    int hours = ((int)time) % (3600 * 24) / 3600;
    int minute = ((int)time) % (3600 * 24) / 60;
    
    NSString *dateContent;
    
    if(month!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"",month,@"个月前"];
        
    }else if(days!=0){
        
        dateContent = [NSString stringWithFormat:@"%@%i%@",@"",days,@"天前"];
        
    }else if(hours!=0){
        if (hours < 0) {
            dateContent =[NSString stringWithFormat:@"%@30%@",@"",@"秒前"];
        }else {
            dateContent = [NSString stringWithFormat:@"%@%i%@",@"",hours,@"小时前"];
        }
    }else if(minute!=0){
        if (minute < 0) {
            dateContent = [NSString stringWithFormat:@"%@30%@",@"",@"秒前"];
        }else {
            dateContent = [NSString stringWithFormat:@"%@%i%@",@"",minute,@"分钟前"];
        }
    }else {
        dateContent = @"刚刚";
    }
    //    NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    
    return dateContent;
}
@end
