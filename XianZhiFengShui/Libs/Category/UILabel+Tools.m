//
//  UILabel+Tools.m
//  JeeSea
//
//  Created by 高健大人辛苦了 on 15/9/1.
//  Copyright (c) 2015年 范茂羽. All rights reserved.
//

#import "UILabel+Tools.h"

@implementation UILabel (Tools)

+ (UILabel *)labelWithFontSize:(float)fontSize textColor:(UIColor *)textColor shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)offset {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.shadowColor = shadowColor;
    label.shadowOffset = offset;
 
    return label;
}

+ (CGSize)sizeWithText:(NSString *)text fontSize:(float)fontSize maxWidth:(CGFloat)maxWidth {
    if (text == nil) {
        return CGSizeZero;
    }
    UILabel *label = [self multiLineLabelWithFontSize:fontSize];
    label.text = text;
    return [label sizeThatFits:CGSizeMake(maxWidth, 0)];
}
+ (CGSize)sizeWithText:(NSString *)text fontSize:(float)fontSize {
    if (text == nil) {
        return CGSizeZero;
    }
    UILabel *label = [UILabel labelWithFontSize:fontSize];
    label.text = text;
    [label sizeToFit];
    return label.size;
}

+ (UILabel *)multiLineLabelWithFontSize:(float)fontSize {
    UILabel *label = [self labelWithFontSize:fontSize];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    return label;
}

+ (UILabel *)multiLineLabelWithFontSize:(float)fontSize textColor:(UIColor *)textColor {
    UILabel *label = [self labelWithFontSize:fontSize textColor:textColor];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    return label;
}

+ (UILabel *)labelWithFontSize:(float)fontSize {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}

+ (UILabel *)labelWithFontSize:(float)fontSize textColor:(UIColor *)textColor {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    return label;
}

- (void)sizeToFitWidth:(float)width {
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByCharWrapping;
    self.size = [self sizeThatFits:CGSizeMake(width, 0)];
}

@end
