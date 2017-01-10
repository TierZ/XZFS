//
//  XZMyAccountService.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/10.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "BasicService.h"

typedef NS_ENUM(NSUInteger, XZMyAccountTag) {
    XZAccountTag = 500,//我的账户
    XZAccountRechargeTag,//知币充值
    XZRechargeRecordTag,//知币充值记录
//    XZMyCollectionLectureTag,//我收藏的讲座列表
//    XZHelpAndFeedbackListTag,//帮助反馈导航列表
//    XZRegistMasterTag,//成为大师
};
@interface XZMyAccountService : BasicService

/**
 请求用户个人账户

 @param userCode 用户id
 @param view     。。
 */
-(void)requestMyAccountWithUserCode:(NSString*)userCode view:(id)view;


/**
 知币充值

 @param userCode  用户id
 @param ip        ip
 @param totalFee  订单费用（单位：分）
 @param totalCoin 充值知币数量
 @param payType   支付类型 微信:W ,支付宝:A
 @param view      。。
 */
-(void)accountRechargeWithUserCode:(NSString*)userCode ip:(NSString*)ip totalFee:(long)totalFee totalCoin:(long)totalCoin payType:(NSString*)payType view:(id)view;


/**
 知币充值历史记录

 @param userCode 用户id
 @param pageNum  页数
 @param pageSize 每页数
 @param view     。。
 */
-(void)rechargeRecordWithUserCode:(NSString*)userCode pageNum:(int)pageNum pageSize:(int)pageSize view:(id)view;
@end
