//
//  UIButton+XZImageTitleSpacing.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/1.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

typedef NS_ENUM(NSUInteger, XZButtonEdgeInsetsStyle) {
    XZButtonEdgeInsetsStyleTop, // image在上，label在下
    XZButtonEdgeInsetsStyleLeft, // image在左，label在右
    XZButtonEdgeInsetsStyleBottom, // image在下，label在上
    XZButtonEdgeInsetsStyleRight // image在右，label在左
};


#import <UIKit/UIKit.h>

@interface UIButton (XZImageTitleSpacing)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(XZButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
