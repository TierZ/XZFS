//
//  NSDate+Category.m
//  Test
//
//  Created by 高健大人辛苦了 on 15/9/23.
//  Copyright © 2015年 高健大人辛苦了. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

+ (NSInteger)IntervalToNow:(NSString *)timeStr {
    NSDate *now = [NSDate date];
    NSDateFormatter *nowFormatter = [[NSDateFormatter alloc] init];
    nowFormatter.dateFormat = @"yy-MM-dd";
    NSString *ymd = [nowFormatter stringFromDate:now];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@ %@",ymd,timeStr]];
    NSInteger second = [now timeIntervalSinceDate:date];
    return second;
}

@end
