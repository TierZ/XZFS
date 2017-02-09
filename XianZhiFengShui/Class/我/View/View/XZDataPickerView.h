//
//  XZDataPickerView.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/2/8.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//


#import <UIKit/UIKit.h>

/**
 时间选择器
 */


/**
 时间选择block

 @param startDate 开始时间
 @param endDate 结束时间
 */
typedef void(^DateClickBlock)(NSDate * startDate,NSDate * endDate);


@interface XZDataPickerView : UIView
@property (nonatomic,copy)DateClickBlock block;
-(void)selectDateWithBlock:(DateClickBlock)block;
@end
