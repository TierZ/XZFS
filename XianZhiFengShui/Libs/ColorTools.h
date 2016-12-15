//
//  ColorTools.h
//
//  Copyright (c) 2014年 pursuitdream. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "StringToColor.h"
@interface ColorTools : NSObject

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
