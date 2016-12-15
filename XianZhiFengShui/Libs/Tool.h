//
//  Tool.h
//  demo01_资讯
//
//  Created by shagualicai on 16/2/24.
//  Copyright © 2016年 YangShangJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

// 计算label高度
+ (CGFloat)labelHeightWithText:(NSMutableAttributedString *)text
                      fontSize:(CGFloat)fontSize
                         width:(CGFloat)width
                       lineNum:(NSInteger)lineNum;
// 16进制颜色转换
+(UIColor *)colorWithHexString:(NSString *)color;
// 时间戳转时间
+ (NSString *)timeWithTimestamp:(double)timestamp dateFormat:(NSString *)format;

//计算label size
+ (CGSize)boundingRectWithSize:(CGSize)size withStr:(NSString*)str withFont:(UIFont*)font;
+ (NSString *)fromNowAfterDays:(NSInteger)days format:(NSString *)format; // n天后的日期
+(NSString*)timeSpaceWithTimestamp:(double)timestamp;//计算时间间隔

+ (NSString *)getCurrentDateWithFormat:(NSString *)format;

+ (double)timestampWithNow;

+ (NSString *)formatDateStrWithTimestampStr:(NSString *)stampStr;

+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;//日期转成星期

// 转化为标准数字 1,234,567.00
+ (NSString *)standardNumStringWithNumber:(NSNumber *)num;
+ (NSString *)standardNumStringWithString:(NSString *)numStr;
+ (NSString *)standardNumStringWithDouble:(double)dNum;


+ (UIImage *)fixOrientation:(UIImage *)aImage;//照相时 获取到的照片是被旋转的 情况

+ (BOOL)isAllowedNotification;//判断用户是否允许推送

//参数加密
+(NSDictionary*)encodeParamsWithDic:(NSDictionary*)dic;

//参数解密
+(NSDictionary*)decodeParamsWithDic:(NSDictionary*)dic;


//保持原来的长宽比，生成一个缩略图
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;


/**
给指定view 画圆角

 @param rect        控件的frame
 @param corners     圆角的位置（左上，左下，右上，右下）
 @param cornerRadii 弧度的size
 @param borderWidth borderwidth
 @param strokeColor 边框颜色
 @param fillColor   填充颜色

 @return 返回 控件的layer  view.layer.mask = 
 */
+(CAShapeLayer*)drawCornerWithRect:(CGRect)rect  byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii borderWidth:(CGFloat)borderWidth strokeColor:(UIColor*)strokeColor fillColor:(UIColor *)fillColor;

@end
