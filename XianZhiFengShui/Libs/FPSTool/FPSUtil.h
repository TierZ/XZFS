//
//  FPSUtil.h
//  NormalProject
//
//  Created by shagualicai on 2016/11/25.
//  Copyright © 2016年 BAT. All rights reserved.
//
/** 在window上显示fps值 */
#import <Foundation/Foundation.h>

@interface FPSUtil : NSObject
/** 显示FPS值 rootVC的viewDidLayout里调用(tabBarController最好) */
+ (void)showFPS;
/** 隐藏FPS */
+ (void)hideFPS;
@end
