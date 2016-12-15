//
//  WTPayManager.m
//  WT_Pay
//
//  Created by Mac on 16/7/5.
//  Copyright © 2016年 wutong. All rights reserved.
//

#import "WTPayManager.h"
//#import "payRequsestHandler.h"
#import "Order.h"
#import "DataSigner.h"

@interface WTPayManager ()<NSCopying>
@property (nonatomic, copy)WTPayResultBlock result;
@end

@implementation WTPayManager

+ (void)initialize
{
    [WTPayManager shareWTPayManager];
}


static WTPayManager * _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
        [_instance setRegisterApps];
    });
    return _instance;
}

+ (instancetype)shareWTPayManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
        [_instance setRegisterApps];
    });
    return _instance;
}


- (id)copyWithZone:(nullable NSZone *)zone
{
    return _instance;
}



// 注册appid
- (void)setRegisterApps
{    // 微信注册
    [WXApi registerApp:kWeixinAppId];
}

+ (void)wtPayOrderItem:(WTPayOrderItem *)orderItem payType:(WTPayType)type result:(WTPayResultBlock)result
{
    [WTPayManager shareWTPayManager].result = result;
    if (type == WTPayTypeWeixin) {
        [WTPayManager weixinPayWithOrderItem:orderItem];
    }else if (type == WTPayTypeAli){
        [WTPayManager aliPayWithOrderItem:orderItem];
    }
}
+ (void)aliPayWithOrderItem:(WTPayOrderItem *)orderItem
{
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"";
    NSString *privateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = @"12312313"; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderInfo];
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}

- (void)handleAlipayResponse:(NSDictionary *)resultDic
{
    
//    resultDic;
    NSLog(@"%@", resultDic);
    
    if ([resultDic[@"resultStatus"] integerValue] != WTPayAilPayResultTypeSucess) {
        
        NSString * errorStr;
        errorStr = resultDic[@"memo"] ? resultDic[@"memo"] : @"支付失败";
        self.result(nil, errorStr);
    }else{
        NSDictionary * response = @{@"result":@"支付宝支付成功!"};
        self.result(response,nil);
    }
    
    
}




+ (void)weixinPayWithOrderItem:(WTPayOrderItem *)orderItem
{
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = @"10000100";
    request.prepayId= @"1101000000140415649af9fc314aa427";
    request.package = @"Sign=WXPay";
    request.nonceStr= @"a462b76e7436e98e0ed6e13c64b4fd1c";
    request.timeStamp= 1397527777;
    request.sign= @"582282D72DD2B03AD892830965F428CB16E7A256";
    BOOL success = [WXApi sendReq:request];
                if(!success){
                    NSLog(@"调微信失败");
                }
                return;

    
    
//    payRequsestHandler *payObj = [payRequsestHandler sharedInstance];
//    //1. 拿到prepayId 和 sign, 其他参数写在外面都行
//    NSDictionary * dict = [payObj sendPay:orderItem.orderName orderPrice:orderItem.orderPrice outTradeNo:orderItem.orderOutTradeNO];


//    // 2.调起微信支付
//    if(dict != nil){
//        NSMutableString *retcode = [dict objectForKey:@"retcode"];
//        if (retcode.intValue == 0){
//            NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//            
//            //调起微信支付
//            PayReq* req             = [[PayReq alloc] init];
//            req.partnerId           = [dict objectForKey:@"partnerid"];
//            req.prepayId            = [dict objectForKey:@"prepayid"];
//            req.nonceStr            = [dict objectForKey:@"noncestr"];
//            req.timeStamp           = stamp.intValue;
//            req.package             = [dict objectForKey:@"package"];
//            req.sign                = [dict objectForKey:@"sign"];
//            
//            BOOL success = [WXApi sendReq:req];
//            if(!success){
//                NSLog(@"调微信失败");
//            }
//            return;
//        }else{
//            NSLog(@"%@",[dict objectForKey:@"retmsg"]);
//        }
//    }else{
//        NSLog(@"服务器返回错误");
//    }


    
}




-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        
        
        if (response.errCode == WXSuccess) {
            NSDictionary * response = @{@"result":@"微信支付成功!"};
            self.result(response,nil);

        }else{
            NSLog(@"支付失败，retcode=%d",resp.errCode);
            
            self.result(nil,@"支付失败");
            
        }
    }
}

@end



@implementation WTPayOrderItem
@end
