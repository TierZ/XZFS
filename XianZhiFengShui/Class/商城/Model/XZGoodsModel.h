//
//  XZGoodsModel.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/8.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    orderWaitPay = 1,//等待支付
    orderSendOutGoods,//卖家已发货
    orderSuccess,//交易成功
    orderCancel,//交易取消
} OrderState;
/**
 宝贝 model
 */
@interface XZGoodsModel : NSObject
@property (nonatomic,copy)NSString * image;//路径
@property (nonatomic,copy)NSString * name;//名称
@property (nonatomic,copy)NSString * storeName;//店名
@property (nonatomic,copy)NSString * price;//价格
@property (nonatomic,copy)NSString * expressPrice;//快递费
@property (nonatomic,copy)NSString * comment;//评价
@property (nonatomic,copy)NSString * wellComment;//好评
@property (nonatomic,copy)NSString * selectCount;//选择的购买数量
@property (nonatomic,copy)NSString * counts;//购买数量
@property (nonatomic,copy)NSString * introduce;//简介
@property (nonatomic,assign)OrderState state;//订单状态
@end


@interface XZAddressModel : NSObject
@property (nonatomic,copy)NSString * consignee;//收货人
@property (nonatomic,copy)NSString * phone;//手机号
@property (nonatomic,copy)NSString * address;//地址
@property (nonatomic,assign)BOOL isHideEditBar;//隐藏编辑框
@end

