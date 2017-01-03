//
//  XZPayTopView.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/3.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

typedef enum : NSUInteger {
    XZMasterPay,
    XZLecturePay,
    XZOtherPay,
} XZPayTopStyle;//何种类型的支付（大师，讲座）
#import <UIKit/UIKit.h>

@interface XZPayTopView : UIView
- (instancetype)initWithFrame:(CGRect)frame topStyle:(XZPayTopStyle)style;
-(void)refreshTopInfo;
@end
