//
//  XZMallService.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/16.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMallService.h"
static NSString * XZModifyAddressService = @"/shop/address/update";
static NSString * XZDeleteAddressService = @"/shop/address/delete";
static NSString *  XZAddressListService = @"/shop/address/list";
static NSString * XZAddAddressService = @"/shop/address/add";
@implementation XZMallService

#pragma mark 修改地址
-(void)modifyAddressWithUsercode:(NSString*)usercode recvName:(NSString*)recvName mobile:(NSString*)mobile prov:(NSString*)prov city:(NSString*)city county:(NSString*)county detail:(NSString*)detail isDef:(NSString*)isDef acode:(NSString*)acode view:(id)view{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:usercode forKey:@"usercode"];
    [dic setObject:recvName forKey:@"recvName"];
    [dic setObject:mobile forKey:@"mobile"];
    [dic setObject:prov forKey:@"prov"];
    [dic setObject:city forKey:@"city"];
    [dic setObject:county forKey:@"county"];
    [dic setObject:detail forKey:@"detail"];
    [dic setObject:isDef forKey:@"isDef"];
    [dic setObject:acode forKey:@"acode"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZModifyAddressService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}
#pragma mark 添加地址
-(void)addAddressWithUsercode:(NSString*)usercode recvName:(NSString*)recvName mobile:(NSString*)mobile prov:(NSString*)prov city:(NSString*)city county:(NSString*)county detail:(NSString*)detail isDef:(NSString*)isDef  view:(id)view{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:usercode forKey:@"usercode"];
    [dic setObject:recvName forKey:@"recvName"];
    [dic setObject:mobile forKey:@"mobile"];
    [dic setObject:prov forKey:@"prov"];
    [dic setObject:city forKey:@"city"];
    [dic setObject:county forKey:@"county"];
    [dic setObject:detail forKey:@"detail"];
    [dic setObject:isDef forKey:@"isDef"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZAddAddressService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 地址列表
-(void)adddressListWithUsercode:(NSString*)usercode recvName:(NSString*)recvName mobile:(NSString*)mobile prov:(NSString*)prov city:(NSString*)city county:(NSString*)county detail:(NSString*)detail isDef:(NSString*)isDef  view:(id)view{
    
//    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
//    [dic setObject:usercode forKey:@"usercode"];
//    [dic setObject:recvName forKey:@"recvName"];
//    [dic setObject:mobile forKey:@"mobile"];
//    [dic setObject:prov forKey:@"prov"];
//    [dic setObject:city forKey:@"city"];
//    [dic setObject:county forKey:@"county"];
//    [dic setObject:detail forKey:@"detail"];
//    [dic setObject:isDef forKey:@"isDef"];
//    
//    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
//    
//    [self postRequestWithUrl:XZAddAddressService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
//        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
//            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
//        }
//    } failBlock:^(NSError *error) {
//        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
//            [self.delegate netFailedWithHandle:error dataService:self];
//        }
//    }];
}

#pragma mark 删除地址
-(void)deleteAddressWithAcode:(NSString*)acode usercode:(NSString*)usercode  view:(id)view{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:usercode forKey:@"usercode"];
    [dic setObject:acode forKey:@"acode"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZDeleteAddressService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

@end
