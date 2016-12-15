//
//  BasicService.h
//  ShaGuaLiCai
//
//  Created by 李清娟 on 15/12/22.
//  Copyright © 2015年 傻瓜理财. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DES3Util.h"
#import "NSString+MD5Addition.h"
@protocol DataReturnDelegate <NSObject>

@optional
-(void)netSucceedWithHandle:(id)succeedHandle;
-(void)netFailedWithHandle:(id)failHandle;

-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service;
-(void)netFailedWithHandle:(id)failHandle dataService:(id)service;

@end

@interface BasicService : NSObject
@property (nonatomic,weak)id<DataReturnDelegate> delegate;
@property (nonatomic,assign)int serviceTag;//请求的标签
@property (nonatomic, assign) BOOL isShowNetErrToast;
+(BasicService*)sharedService;
/**
 *  get 请求
 *
 *  @param url           url地址
 *  @param requestData   请求体
 *  @param isOpenHUD     是否显示hub
 *  @param block         成功的block
 *  @param errorBlock    失败的block
 *  @param currentView   显示toast 的当前view
 
 */

- (void)getRequestWithUrl:(NSString *)url parmater:(NSDictionary *)requestData view:(UIView*)currentView isOpenHUD:(BOOL)isOpenHUD  Block:(void (^)(NSData *data))block failBlock:(void (^)(NSError *error))errorBlock;
/**
 *  post 请求
 *
 *  @param url           url地址
 *  @param requestData   请求体
 *  @param isOpenHUD     是否显示hub
 *  @param block         成功的block
 *  @param errorBlock    失败的block
 *  @param currentView   显示toast 的当前view

 */
- (void)postRequestWithUrl:(NSString *)url parmater:(NSDictionary *)requestData view:(UIView*)currentView isOpenHUD:(BOOL)isOpenHUD Block:(void (^)(NSDictionary *data))block failBlock:(void (^)(NSError *error))errorBlock;
/**
 *  得到 auth_key 和 seq 的值 字典形式
 *
 *  add by lf
 */
-(NSMutableDictionary*)getCommonDictionary;


/**
 参数数据加密

 @param dic <#dic description#>

 @return <#return value description#>
 */
-(NSDictionary*)dataEncryptionWithDic:(NSDictionary*)dic;

/**
 参数数据解密

 @param dic <#dic description#>

 @return <#return value description#>
 */
-(NSDictionary*)dataDecryptionWithDic:(NSDictionary*)dic;


///**
// 显示 失败内容
//
// @param dic <#dic description#>
// */
//-(void)showFailInfoWithDic:(NSDictionary*)dic view:(id)view;

- (instancetype)initWithServiceTag:(int)tag;
@end
