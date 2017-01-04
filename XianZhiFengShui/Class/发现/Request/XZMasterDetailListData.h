//
//  XZMasterDetailListData.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/27.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicService.h"

typedef NS_ENUM(NSUInteger, XZMasterDetailListTag) {//大师详情内
    XZMasterArticleDetail = 230,//大师文章详情
    XZMasterArticleList,//大师文章列表
 XZMasterOrderDetail,//大师订单详情
    XZMasterOrderPay,//预约大师（付费）
};

/**
 大师相关
 */
@interface XZMasterDetailListData : BasicService

/**
 大师文章列表
 
 @param masterCode 大师id
 @param pageNum    页码
 @param pageSize   每页
 @param cityCode   城市id
 @param view       。。
 */
-(void)articleListWithMasterCode:(NSString*)masterCode pageNum:(int)pageNum pageSize:(int)pageSize cityCode:(NSString*)cityCode view:(id)view successBlock:(void (^)(NSArray  *data))successBlock failBlock:(void (^)(NSError *error))errorBlock;



/**
 文章详情

 @param cityCode     城市
 @param articleCode  文章id
 @param view         。。
 @param successBlock 成功回调
 @param errorBlock   失败回调
 */
-(void)articleDetailWithCityCode:(NSString*)cityCode articleCode:(NSString*)articleCode view:(id)view successBlock:(void (^)(NSDictionary  *data))successBlock failBlock:(void (^)(NSError *error))errorBlock;


/**
 大师预约（付款）

 @param usercode     用户id
 @param ip           ip
 @param totalFee     总价（分）
 @param body         商品描述
 @param mastCode     大师id
 @param payType      支付类型 微信:W ,支付宝:A
 @param reserveTime  预约时间
 @param view         view
 @param successBlock ..
 @param errorBlock   ..
 */
-(void)masterOrderPayWithUsercode:(NSString*)usercode ip:(NSString*)ip totalFee:(long)totalFee body:(NSString*)body mastCode:(NSString*)mastCode payType:(NSString*)payType reserveTime:(NSString*)reserveTime view:(id)view successBlock:(void (^)(NSDictionary *data))successBlock failBlock:(void (^)(NSError *error))errorBlock;


/**
 大师订单详情

 @param tradeNo      交易号
 @param view         。。
 @param successBlock 。。
 @param errorBlock   。。
 */
-(void)masterOrderDetailWithTradeNo:(NSString*)tradeNo view:(id)view successBlock:(void (^)(NSDictionary *data))successBlock failBlock:(void (^)(NSError *error))errorBlock;
@end
