//
//  XZMyCouponVC.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/20.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

typedef enum : NSUInteger {
    MyCouponCanUse = 1,
    MyCouponOutOfData,
    MyCouponDetail,
} MyCoupon;
//我的优惠券 () 
#import "BaseLoginController.h"

@interface XZMyCouponVC : BaseLoginController
@property (nonatomic,assign)BOOL isOutOfData;//失效的
- (instancetype)initWithStyle:(MyCoupon)style;
@end
