//
//  UIView+Additions.m
//
//
//  Created by 东哥 on 15/5/19.
//  Copyright (c) 2015年 bing3511. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    self.frame = CGRectMake(left, self.top, self.width, self.height);
}

- (CGFloat)right {
    return self.left + self.width;
}

- (void)setRight:(CGFloat)right {
    self.frame = CGRectMake(right - self.width, self.top, self.width, self.height);
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    self.frame = CGRectMake(self.left, top, self.width, self.height);
}

- (CGFloat)bottom {
    return self.top + self.height;
}

- (void)setBottom:(CGFloat)bottom {
    self.frame = CGRectMake(self.left, bottom - self.height, self.width, self.height);
}

- (CGPoint)leftTop {
    return CGPointMake(self.left, self.top);
}

- (void)setLeftTop:(CGPoint)leftTop {
    self.left = leftTop.x;
    self.top = leftTop.y;
}

- (CGPoint)leftBottom {
    return CGPointMake(self.left, self.bottom);
}

- (void)setLeftBottom:(CGPoint)leftBottom {
    self.left = leftBottom.x;
    self.bottom = leftBottom.y;
}

- (CGPoint)rightTop {
    return CGPointMake(self.right, self.top);
}

- (void)setRightTop:(CGPoint)rightTop {
    self.right = rightTop.x;
    self.top = rightTop.y;
}

- (CGPoint)rightBottom {
    return CGPointMake(self.right, self.bottom);
}

- (void)setRightBottom:(CGPoint)rightBottom {
    self.right = rightBottom.x;
    self.bottom = rightBottom.y;
}

- (CGPoint)boundsCenter {
    return CGPointMake(self.width / 2, self.height / 2);
}

- (CGPoint)topCenter {
    return CGPointMake(self.centerX, self.top);
}

- (void)setTopCenter:(CGPoint)topCenter {
    self.left = topCenter.x - self.width / 2;
    self.top = topCenter.y;
}


- (CGPoint)bottomCenter {
    return CGPointMake(self.centerX, self.bottom);
}

- (void)setBottomCenter:(CGPoint)bottomCenter {
    self.left = bottomCenter.x - self.width / 2;
    self.bottom = bottomCenter.y;
}

- (CGPoint)leftCenter {
    return CGPointMake(self.left, self.centerY);
}

- (void)setLeftCenter:(CGPoint)leftCenter {
    self.left = leftCenter.x;
    self.top = leftCenter.y - self.height / 2;
}

- (CGPoint)rightCenter {
    return CGPointMake(self.right, self.centerY);
}

- (void)setRightCenter:(CGPoint)rightCenter {
    self.right = rightCenter.x;
    self.top = rightCenter.y - self.height / 2;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.left, self.top, size.width, size.height);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.left, self.top, width, self.height);
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.left, self.top, self.width, height);
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.left = centerX - self.width / 2;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.top = centerY - self.height / 2;
}

@end
