//
//  MyCouponModel.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/21.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 我的优惠券
 */
@interface MyCouponModel : NSObject
@property (nonatomic,copy)NSString * price;
@property (nonatomic,copy)NSString * time;
@property (nonatomic,copy)NSString * warn;
@property (nonatomic,copy)NSString * useRange;
@end
