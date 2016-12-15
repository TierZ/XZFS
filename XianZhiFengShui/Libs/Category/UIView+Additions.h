//
//  UIView+Additions.h
//  
//
//  Created by 东哥 on 15/5/19.
//  Copyright (c) 2015年 bing3511. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGPoint leftTop;
@property (nonatomic) CGPoint leftBottom;
@property (nonatomic) CGPoint rightTop;
@property (nonatomic) CGPoint rightBottom;
@property (nonatomic, readonly) CGPoint boundsCenter;
@property (nonatomic) CGPoint topCenter;
@property (nonatomic) CGPoint bottomCenter;
@property (nonatomic) CGPoint leftCenter;
@property (nonatomic) CGPoint rightCenter;
@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;


@end
