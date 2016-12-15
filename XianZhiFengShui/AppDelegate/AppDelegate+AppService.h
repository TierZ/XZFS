//
//  AppDelegate+AppService.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/8.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//
/**
 *  app 的一些服务项目 （推送，分享 统计 等）
 *
 *  @param AppService <#AppService description#>
 *
 *  @return <#return value description#>
 */


#import "AppDelegate.h"
#import "WeiboSDK.h"
#import "JMessage.framework/Headers/JMessage.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate (AppService)<JMessageDelegate,UNUserNotificationCenterDelegate,JPUSHRegisterDelegate,WeiboSDKDelegate>
//@property (strong, nonatomic) NSString *wbtoken;
//@property (strong, nonatomic) NSString *wbRefreshToken;
//@property (strong, nonatomic) NSString *wbCurrentUserID;
-(void)registNotificationWithOptions:(NSDictionary *)launchOptions;//注册 推送
@end
