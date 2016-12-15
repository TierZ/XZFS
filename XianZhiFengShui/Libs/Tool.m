//
//  Tool.m
//  demo01_资讯
//
//  Created by shagualicai on 16/2/24.
//  Copyright © 2016年 YangShangJie. All rights reserved.
//

#import "Tool.h"
#import "DES3Util.h"
#import "NSString+MD5Addition.h"
#define XZFS_Image_Width(imageCount)  imageCount>2?SCREEMWIDHT

@implementation Tool

+ (CGFloat)labelHeightWithText:(NSMutableAttributedString *)text
                      fontSize:(CGFloat)fontSize
                         width:(CGFloat)width
                       lineNum:(NSInteger)lineNum {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, CGFLOAT_MAX)];
    label.font = [UIFont fontWithName:LABElFONT size:fontSize];
    label.numberOfLines = lineNum;
    //    [text addAttribute:NSKernAttributeName value:@1.5 range:NSMakeRange(0, text.length)];
    label.attributedText = text;
    [label sizeToFit];
    //    [label drawRect:label.frame];
    //    [label layoutIfNeeded];
    return label.frame.size.height;
}
//
+ (CGSize)boundingRectWithSize:(CGSize)size withStr:(NSString*)str withFont:(UIFont*)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [str boundingRectWithSize:size
                                       options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    
    return retSize;
}


// 16进制颜色转换
+(UIColor *)colorWithHexString:(NSString *)color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
// add by lf 从现在起n天后的日期
+ (NSString *)fromNowAfterDays:(NSInteger)days format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSTimeInterval later = days*24*60*60;
    NSString *reTime = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:later]];
    return reTime;
}
// add by lf 获取当前日期 -> string
+ (NSString *)getCurrentDateWithFormat:(NSString *)format {
    NSDate *now = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = format;
    return [df stringFromDate:now];
}
// add by lf 将日期转换成时间戳
+ (double)timestampWithNow {
    NSDate *now = [NSDate date];
    return [now timeIntervalSince1970];
}
+ (double)timestampWithDate:(NSDate *)date {
    return [date timeIntervalSince1970];
}
// add by lf 时间戳转格式化后的时间显示,用于消息列表
+ (NSString *)formatDateStrWithTimestampStr:(NSString *)stampStr {
    NSString * timeSpace;
    NSDate *transDate = [NSDate dateWithTimeIntervalSince1970:[stampStr doubleValue]];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    df.dateFormat = @"yyyy-MM-dd";
    NSString *transday = [df stringFromDate:transDate]; // 传进来的日期
    NSString *today = [df stringFromDate:[NSDate date]]; // 今天
    NSString *yesterday = [df stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-24*60*60]]; // 昨天
    if ([transday isEqualToString:today]) {
        df.dateFormat = @"HH:mm";
        timeSpace = [df stringFromDate:transDate];
    } else if ([transday isEqualToString:yesterday]) {
        timeSpace = @"昨天";
    } else {
        df.dateFormat = @"yy-MM-dd";
        timeSpace = [df stringFromDate:transDate];
    }
    /*
     double stamp = [stampStr doubleValue];
     NSDate *date = [NSDate dateWithTimeIntervalSince1970:stamp];
     double space = -1*[date timeIntervalSinceNow]; // 距离现在的时差
     int day = (int)(space/(3600*24));
     int hour = (int)(space/3600);
     int minute = (int)(space - hour*3600)/60;
     int second = space - hour*3600 - minute*60;
     if (day>0) {
     if (day < 2) {
     timeSpace = @"昨天";
     } else {
     df.dateFormat = @"MM-dd";
     timeSpace = [df stringFromDate:date];
     }
     } else if (hour>0){
     timeSpace = [NSString stringWithFormat:@"%d小时前",hour];
     } else if (minute>0){
     timeSpace = [NSString stringWithFormat:@"%d分钟前",minute];
     
     }else {
     timeSpace = @"刚刚";
     }
     */
    return timeSpace;
}

// 时间戳转时间
+ (NSString *)timeWithTimestamp:(double)timestamp dateFormat:(NSString *)format {
    if (!timestamp) {
        return @"";
    }
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = format;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return [df stringFromDate:date];
}

+(NSString*)timeSpaceWithTimestamp:(double)timestamp{
    NSString * timeSpace;
    int day = (int)(timestamp/(3600*24));
    int hour = (int)(timestamp/3600);
    int minute = (int)(timestamp - hour*3600)/60;
    int second = timestamp - hour*3600 - minute*60;
    if (day>0) {
        timeSpace = [NSString stringWithFormat:@"%d天前",day];
    }else if (hour>0){
        timeSpace = [NSString stringWithFormat:@"%d小时前",hour];
    }else if (minute>0){
        timeSpace = [NSString stringWithFormat:@"%d分钟前",minute];
        
    }else{
        timeSpace = [NSString stringWithFormat:@"%d秒前",second];
    }
    return timeSpace;
}

#pragma mark 根据时间获得周几
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+ (NSString *)standardNumStringWithDouble:(double)dNum {
    NSNumber *num = [NSNumber numberWithDouble:dNum];
    return [self standardNumStringWithNumber:num];
}
+ (NSString *)standardNumStringWithString:(NSString *)numStr {
    NSNumber *num = [NSNumber numberWithString:numStr];
    return [self standardNumStringWithNumber:num];
}
+ (NSString *)standardNumStringWithNumber:(NSNumber *)num {
    if (!num) {
        num = [NSNumber numberWithDouble:0];
    }
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *stdStr = [numFormatter stringFromNumber:num];
    NSString *symbol = numFormatter.currencySymbol; // 货币符号
    NSString *retStr = [stdStr stringByReplacingOccurrencesOfString:symbol withString:@""];
    /*
     NSString *str1 = [stdStr stringByReplacingOccurrencesOfString:@"￥" withString:@""];
     NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"$" withString:@""];
     NSString *retStr = [str2 stringByReplacingOccurrencesOfString:@" " withString:@""];
     */
    return retStr;
}


#pragma mark image 旋转
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma mark  保持原来的长宽比，生成一个缩略图
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

#pragma mark 判断用户 是否允许推送
+ (BOOL)isAllowedNotification {
    
    //iOS8 check if user allow notification
    
    if (XZFS_IS_IOS8) {// system is iOS8
        
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        
        if (UIUserNotificationTypeNone != setting.types) {
            
            return YES;
            
        }
        
    } else {//iOS7
        
//        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
//        
//        if(UIRemoteNotificationTypeNone != type)
            
            return YES;
    }
    
    
    
    return NO;
    
}

//判断是否开启推送
//if ([Tool isAllowedNotification]) {
//    NSLog(@"开启了推送");
//}else{
//    NSLog(@"没开启推送");
//    if (SGLC_IS_IOS8) {
//        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        if ([[UIApplication sharedApplication] canOpenURL:url]) {
//            [[UIApplication sharedApplication] openURL:url];
//        }
//    } else {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=NOTIFICATIONS_ID"]];
//    }
//}


//参数加密
+(NSDictionary*)encodeParamsWithDic:(NSDictionary*)dic{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * str =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return @{@"json":[DES3Util encryptUseDES:str key:@""],@"sign":[str stringFromMD5]};
}

//参数解密
+(NSDictionary*)decodeParamsWithDic:(NSDictionary*)dic{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * str =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return @{@"json":[DES3Util decryptUseDES:str key:@""],@"sign":[str stringFromMD5]};
    return nil;
}


#pragma 控件画圆角
+(CAShapeLayer*)drawCornerWithRect:(CGRect)rect  byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii borderWidth:(CGFloat)borderWidth strokeColor:(UIColor*)strokeColor fillColor:(UIColor *)fillColor{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];

    //设置大小
    maskLayer.frame = rect;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    maskLayer.strokeColor = strokeColor.CGColor;
    maskLayer.fillColor = fillColor.CGColor;
    maskLayer.lineWidth = borderWidth;
    return maskLayer;
}

@end
