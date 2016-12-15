//
//  StringToColor.h
//
//  Copyright (c) 2014年 pursuitdream. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface StringToColor : NSObject
{
    
}
+(UIColor *) hexStringToColor: (NSString *) stringToConvert;

+(UIColor *) hexStringToColor: (NSString *) stringToConvert alpha:(CGFloat)alpha;
@end