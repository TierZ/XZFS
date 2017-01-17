//
//  XZMyAccountService.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/10.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMyAccountService.h"
static NSString * rechargeRecordService = @"account/recharge/list";
static NSString * myAccountService = @"/mine/account/query";
static NSString * accountRechargeService = @"/account/recharge/confirm";
static NSString * accountOrderListService = @"/pay/order/list";
static NSString * accountOrderDetailService = @"/pay/order/detail";
@implementation XZMyAccountService

#pragma mark 请求我的账户
-(void)requestMyAccountWithUserCode:(NSString*)userCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:userCode forKey:@"userCode"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    [self postRequestWithUrl:myAccountService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSDictionary * dataDic = [data objectForKey:@"data"];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:dataDic dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 知币充值
-(void)accountRechargeWithUserCode:(NSString*)userCode ip:(NSString*)ip totalFee:(long)totalFee totalCoin:(long)totalCoin payType:(NSString*)payType view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:userCode forKey:@"usercode"];
    [dic setObject:ip forKey:@"ip"];
    [dic setObject:payType forKey:@"payType"];
    [dic setObject:[NSNumber numberWithLong:totalFee] forKey:@"totalFee"];
    [dic setObject:[NSNumber numberWithLong:totalCoin] forKey:@"totalCoin"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    [self postRequestWithUrl:accountRechargeService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSDictionary * dataDic = [data objectForKey:@"data"];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:dataDic dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}
#pragma mark 知币充值历史记录
-(void)rechargeRecordWithUserCode:(NSString*)userCode pageNum:(int)pageNum pageSize:(int)pageSize view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:userCode forKey:@"userCode"];
    [dic setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    [dic setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    [self postRequestWithUrl:rechargeRecordService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSDictionary * dataDic = [data objectForKey:@"data"];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:dataDic dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 账单列表
-(void)myAccoutOrderListWithPage:(int)pageNum pageSize:(int)pageSize usercode:(NSString*)usercode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:usercode forKey:@"userCode"];
    [dic setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    [dic setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    [self postRequestWithUrl:accountOrderListService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSDictionary * dataDic = [data objectForKey:@"data"];
        if ([[dataDic objectForKey:@"list"]isKindOfClass:[NSArray class]]) {
            NSArray* array = [dataDic objectForKey:@"list"];
            if (self.delegate&&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
                [self.delegate netSucceedWithHandle:array dataService:self];
            }
        }
           } failBlock:^(NSError *error) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 订单详情
-(void)myAccountOrderDetailWithTradeNo:(NSString*)tradeNo view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:tradeNo forKey:@"tradeNo"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    [self postRequestWithUrl:accountOrderDetailService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSDictionary * dataDic = [data objectForKey:@"data"];
        if (self.delegate&&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:dataDic dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

@end
