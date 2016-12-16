//
//  XZMallService.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/16.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

typedef NS_ENUM(NSUInteger, XZMallServiceTag) {
    XZModifyAddressTag = 300,
    XZDeleteAddressTag ,
    XZAddressListTag,
    XZAddAddressTag,
};

#import "BasicService.h"

@interface XZMallService : BasicService

/**
 修改地址

 @param usercode 用户code
 @param recvName 收货人
 @param mobile   手机号
 @param prov     省代码
 @param city     市代码
 @param county   区代码
 @param detail   详细地址
 @param isDef    是否默认地址
 @param acode    业务代码
 @param view     。。
 */
-(void)modifyAddressWithUsercode:(NSString*)usercode recvName:(NSString*)recvName mobile:(NSString*)mobile prov:(NSString*)prov city:(NSString*)city county:(NSString*)county detail:(NSString*)detail isDef:(NSString*)isDef acode:(NSString*)acode view:(id)view;


/**
 添加地址
 
 @param usercode 用户code
 @param recvName 收货人
 @param mobile   手机号
 @param prov     省代码
 @param city     市代码
 @param county   区代码
 @param detail   详细地址
 @param isDef    是否默认地址
 @param view     。。
 */
-(void)addAddressWithUsercode:(NSString*)usercode recvName:(NSString*)recvName mobile:(NSString*)mobile prov:(NSString*)prov city:(NSString*)city county:(NSString*)county detail:(NSString*)detail isDef:(NSString*)isDef  view:(id)view;


/**
 删除地址

 @param acode    用户code
 @param usercode 业务代码
 @param view     。。
 */
-(void)deleteAddressWithAcode:(NSString*)acode usercode:(NSString*)usercode  view:(id)view;
@end
