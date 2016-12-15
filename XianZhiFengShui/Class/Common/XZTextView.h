//
//  XZTextView.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/27.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

/**
 自定义textview  textview的高度随字数变化而变化
 */

#import <UIKit/UIKit.h>

typedef void(^XZTextHeightChangedBlock)(NSString * text,float textHeight);
@interface XZTextView : UITextView

/**
 占位符
 */
@property (nonatomic,strong) NSString * placeholder;

/**
 占位符颜色
 */
@property (nonatomic,strong) UIColor * placeholderColor;

/**
 占位符字号
 */
@property (nonatomic,strong) UIFont * placeholderFont;

/**
 最大行，如果设置为0，则不限最大行
 */
@property (nonatomic,assign) NSUInteger maxRow;

/**
 行间距
 */
@property (nonatomic,assign) NSUInteger lineSpace;

@property (nonatomic,copy)XZTextHeightChangedBlock block;

- (void)textHeightDidChanged:(XZTextHeightChangedBlock)block;
@end
