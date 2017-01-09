//
//  XZLoginRegistService.h
//  XianZhiFengShui
//
//  Created by 左晓东 on 16/11/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "BasicService.h"

typedef NS_ENUM(NSUInteger, XZLoginRegistServiceTag) {
    XZLoginTag = 1,//登录
    XZGetSecurityTag,//注册获取验证码
    XZRegistTag,//注册
    XZUpdatePwdTag,//修改密码
    XZGetResetSecurityTag,//重置密码 获取验证码
    XZResetPwdTag,//重置密码
    XZThirdLoginTag,//三方登录
};

@interface XZLoginRegistService : BasicService
/**
 *  登录
 *
 *  @param phoneNo  手机号
 *  @param password 密码
 *  @param view     <#view description#>
 */
-(void)requestLoginWithPhoneNo:(NSString * )phoneNo password:(NSString*)password view:(id)view;


/**
 获取验证码

 @param mobilePhone 手机号
 @param cityCode    城市列表
 @param type        类型  1表示注册验证码；2表示重置密码验证码；3表示登录操作验证码；
 @param view        。。
 */
-(void)requestSecurityCodeWithPhoneNo:(NSString * )mobilePhone cityCode:(NSString*)cityCode type:(NSString*)type  view:(id)view;


/**
 注册

 @param mobilePhone 手机号
 @param password    密码
 @param nickname    昵称
 @param cityCode    城市
 @param view        。
 */
-(void)registWithMobilePhone:(NSString*)mobilePhone password:(NSString*)password nickName:(NSString*)nickname cityCode:(NSString*)cityCode view:(id)view;



/**
 更新（修改）密码

 @param mobilePhone 手机号
 @param oldPassword 旧密码
 @param newPwd      新密码
 @param cityCode    城市
 @param view        。。
 */
-(void)updatePwdWithMobilePhone:(NSString*)mobilePhone oldPwd:(NSString*)oldPassword newPwd:(NSString*)newPwd cityCode:(NSString*)cityCode view:(id)view;


/**
 重置密码

 @param mobilePhone 手机号
 @param password    新密码
 @param cityCode    城市
 @param view        、、
 */
-(void)resetPwdWithMobilePhone:(NSString*)mobilePhone pwd:(NSString*)password cityCode:(NSString*)cityCode view:(id)view;


/**
 三方登录

 @param token     三方登录token
 @param tokenType 三方登录类型   S或者W;S代表新浪,W代表微信
 @param phone     手机号
 @param view      、、
 */
-(void)thirdLoginWithToken:(NSString*)token tokenType:(NSString*)tokenType phone:(NSString*)phone view:(id)view;
@end
