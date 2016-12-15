//
//  ColorTools.m
//
//  Copyright (c) 2014年 pursuitdream. All rights reserved.
//

#import "ColorTools.h"

@implementation ColorTools


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, (CGRect){.size = size});
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [ColorTools imageWithColor:color size:CGSizeMake(1, 1)];
}
@end
