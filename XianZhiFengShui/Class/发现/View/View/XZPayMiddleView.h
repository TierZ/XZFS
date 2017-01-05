//
//  XZPayMiddleView.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/3.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

typedef enum : NSUInteger {
    XZHaveCoupon,
    XZNoCoupon,
} XZCouponStyle;//是否有优惠券
#import <UIKit/UIKit.h>
typedef void(^InvestFriendBlock)();
@interface XZPayMiddleView : UIView
- (instancetype)initWithFrame:(CGRect)frame couponStyle:(XZCouponStyle)style;
@property (nonatomic,copy)InvestFriendBlock block;
-(void)investFriendWithBlock:(InvestFriendBlock)block;
@end
