//
//  XZLoginRegistService.m
//  XianZhiFengShui
//
//  Created by 左晓东 on 16/11/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZLoginRegistService.h"


static NSString * XZLoginService = @"/user/login";
static NSString * XZGetSecurityCodeService = @"/user/sendSMS";
static NSString *  XZRegistService = @"/user/saveUserInfo";
static NSString * XZUpdatePwdService = @"/user/updatePassword";
static NSString * XZResetPwdService = @"/user/resetPassword";

@implementation XZLoginRegistService


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark 登录
-(void)requestLoginWithPhoneNo:(NSString * )phoneNo password:(NSString*)password view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:@"110000" forKey:@"cityCode"];
    [dic setObject:phoneNo forKey:@"username"];
    [dic setObject:password forKey:@"password"];
   
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
     [self postRequestWithUrl:XZLoginService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if ([[data objectForKey:@"statusCode"]intValue]!=200) {
             SETUserdefault([NSDictionary dictionary], @"userInfo");
         }
        
        
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:data dataService:self];
        }
    } failBlock:^(NSError *error) {
        
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 获取验证码
-(void)requestSecurityCodeWithPhoneNo:(NSString * )mobilePhone cityCode:(NSString*)cityCode type:(NSString*)type  view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:mobilePhone forKey:@"mobilePhone"];
    [dic setObject:type forKey:@"type"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZGetSecurityCodeService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if ([[data objectForKey:@"statusCode"]intValue]!=200) {
            SETUserdefault([NSDictionary dictionary], @"userInfo");
        }
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:data dataService:self];
        }
    } failBlock:^(NSError *error) {
        
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 注册
-(void)registWithMobilePhone:(NSString*)mobilePhone password:(NSString*)password nickName:(NSString*)nickname cityCode:(NSString*)cityCode view:(id)view{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:mobilePhone forKey:@"mobilePhone"];
    [dic setObject:password forKey:@"password"];
     [dic setObject:nickname forKey:@"nickname"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZRegistService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if ([[data objectForKey:@"statusCode"]intValue]!=200) {
            SETUserdefault([NSDictionary dictionary], @"userInfo");
        }else{
            [ToastManager showToastOnView:view position:CSToastPositionCenter flag:YES message:@"注册成功"];
        }
        
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:data dataService:self];
        }
    } failBlock:^(NSError *error) {
        
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}


#pragma mark 修改密码
-(void)updatePwdWithMobilePhone:(NSString*)mobilePhone oldPwd:(NSString*)oldPassword newPwd:(NSString*)newPwd cityCode:(NSString*)cityCode view:(id)view{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:mobilePhone forKey:@"mobilePhone"];
    [dic setObject:oldPassword forKey:@"oldPassword"];
    [dic setObject:newPwd forKey:@"newPassword"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZUpdatePwdService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if ([[data objectForKey:@"statusCode"]intValue]!=200) {
            SETUserdefault([NSDictionary dictionary], @"userInfo");
        }else{
            [ToastManager showToastOnView:view position:CSToastPositionCenter flag:YES message:@"更新成功"];
        }
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:data dataService:self];
        }
    } failBlock:^(NSError *error) {
        
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 重置密码
-(void)resetPwdWithMobilePhone:(NSString*)mobilePhone pwd:(NSString*)password cityCode:(NSString*)cityCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:mobilePhone forKey:@"mobilePhone"];
    [dic setObject:password forKey:@"password"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZResetPwdService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if ([[data objectForKey:@"statusCode"]intValue]!=200) {
            SETUserdefault([NSDictionary dictionary], @"userInfo");
        }else{
            [ToastManager showToastOnView:view position:CSToastPositionCenter flag:YES message:@"重置成功"];
        }
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:data dataService:self];
        }
    } failBlock:^(NSError *error) {
        
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

@end
