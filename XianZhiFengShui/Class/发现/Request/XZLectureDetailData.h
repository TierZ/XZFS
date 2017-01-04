//
//  XZLectureDetailData.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/29.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "BasicService.h"

typedef NS_ENUM(NSUInteger, XZLectureDetailListTag) {//讲座详情内
    XZLectureSignUp = 260,//讲座报名
    XZLectureCollection,//讲座收藏
    XZLectureOrderDetail,//讲座订单详情
    XZLectureOrderPay,//讲座支付（付费）
};

/**
 讲座相关
 */
@interface XZLectureDetailData : BasicService

/**
 报名/取消报名

 @param usercode 用户id
 @param lectCode 讲座id
 @param type     类型  1：报名 0：取消报名
 @param view     。。
 */
-(void)signupLectureWithUsercode:(NSString*)usercode lectCode:(NSString*)lectCode type:(NSString*)type view:(id)view;


/**
 收藏/取消收藏 讲座

 @param usercode 用户id
 @param lectCode 讲座id
 @param type     类型  1：收藏讲座 0：取消收藏
 @param view     。。
 */
-(void)collectLectureWithUsercode:(NSString*)usercode lectCode:(NSString*)lectCode type:(NSString*)type view:(id)view;


/**
 讲座付款（付款）
 
 @param usercode     用户id
 @param ip           ip
 @param totalFee     总价（分）
 @param body         商品描述
 @param lectCode     讲座id
 @param payType      支付类型 微信:W ,支付宝:A
 @param view         view
 */
-(void)lectureOrderPayWithUsercode:(NSString*)usercode ip:(NSString*)ip totalFee:(long)totalFee body:(NSString*)body lectCode:(NSString*)lectCode payType:(NSString*)payType  view:(id)view ;


/**
 讲座订单详情
 
 @param tradeNo      交易号
 @param view         。。
 */
-(void)lectureOrderDetailWithTradeNo:(NSString*)tradeNo view:(id)view;


@end
