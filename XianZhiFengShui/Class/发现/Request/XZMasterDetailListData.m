//
//  XZMasterDetailListData.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/27.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterDetailListData.h"
#import "XZMasterInfoModel.h"

static NSString * XZGetMasterArticleList = @"/master/article/list";
static NSString * XZGetArticleDetail = @"/master/article/detail";
static NSString * XZGetMasterOrderDetail = @"/master/order/detail";
static NSString * XZGetMasterOrderPay= @"/master/order/pay";
@implementation XZMasterDetailListData


#pragma mark 文章列表
-(void)articleListWithMasterCode:(NSString*)masterCode pageNum:(int)pageNum pageSize:(int)pageSize cityCode:(NSString*)cityCode view:(id)view successBlock:(void (^)(NSArray  *data))successBlock failBlock:(void (^)(NSError *error))errorBlock{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    [dic setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    [dic setObject:masterCode forKey:@"masterCode"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZGetMasterArticleList parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSArray * arr = [[data objectForKey:@"data"]objectForKey:@"list"];
        NSMutableArray * dataArr = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            XZMasterInfoArticleModel * model = [XZMasterInfoArticleModel modelWithDictionary:arr[i]];
            [dataArr addObject:model];
        }
        if (successBlock) {
            successBlock(dataArr);
        }
    } failBlock:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

#pragma mark 文章详情
-(void)articleDetailWithCityCode:(NSString*)cityCode articleCode:(NSString*)articleCode view:(id)view successBlock:(void (^)(NSDictionary *data))successBlock failBlock:(void (^)(NSError *error))errorBlock{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:articleCode forKey:@"articleCode"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZGetArticleDetail parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSDictionary * dic = [data objectForKey:@"data"];
        if (successBlock) {
            successBlock(dic);
        }
    } failBlock:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}


#pragma mark 大师订单详情
-(void)masterOrderDetailWithTradeNo:(NSString*)tradeNo view:(id)view successBlock:(void (^)(NSDictionary *data))successBlock failBlock:(void (^)(NSError *error))errorBlock{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:tradeNo forKey:@"tradeNo"];
//    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZGetMasterOrderDetail parmater:dic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSDictionary * dic = [data objectForKey:@"data"];
        if (successBlock) {
            successBlock(dic);
        }
    } failBlock:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

#pragma mark 预约大师（付款）
-(void)masterOrderPayWithUsercode:(NSString*)usercode ip:(NSString*)ip totalFee:(long)totalFee body:(NSString*)body mastCode:(NSString*)mastCode payType:(NSString*)payType reserveTime:(NSString*)reserveTime view:(id)view successBlock:(void (^)(NSDictionary *data))successBlock failBlock:(void (^)(NSError *error))errorBlock{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:usercode forKey:@"usercode"];
    [dic setObject:ip forKey:@"ip"];
    [dic setObject:[NSNumber numberWithLong:totalFee] forKey:@"totalFee"];
    [dic setObject:body forKey:@"body"];
    [dic setObject:mastCode forKey:@"mastCode"];
    [dic setObject:payType forKey:@"payType"];
    [dic setObject:reserveTime forKey:@"reserveTime"];
    //    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZGetMasterOrderPay parmater:dic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSDictionary * dic = [data objectForKey:@"data"];
        if (successBlock) {
            successBlock(dic);
        }
    } failBlock:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}
@end
