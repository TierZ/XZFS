//
//  UILabel+Tools.h
//  JeeSea
//
//  Created by 高健大人辛苦了 on 15/9/1.
//  Copyright (c) 2015年 范茂羽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Tools)

+ (UILabel *)labelWithFontSize:(float )fontSize textColor:(UIColor *)textColor shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize )offset;
+ (CGSize)sizeWithText:(NSString *)text fontSize:(float )fontSize maxWidth:(CGFloat )maxWidth;
+ (CGSize)sizeWithText:(NSString *)text fontSize:(float )fontSize;
+ (UILabel *)multiLineLabelWithFontSize:(float )fontSize;
+ (UILabel *)multiLineLabelWithFontSize:(float )fontSize textColor:(UIColor *)textColor;
+ (UILabel *)labelWithFontSize:(float )fontSize;
+ (UILabel *)labelWithFontSize:(float )fontSize textColor:(UIColor *)textColor;
- (void)sizeToFitWidth:(float )width;

@end
