//
//  AppDelegate.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/9/30.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+RootController.h"
#import "AppDelegate+AppLifeCircle.h"
#import "AppDelegate+AppService.h"
#import "IQKeyboardManager.h"
#import "WTThirdPartyLoginManager.h"
#define kDBMigrateFinishNotification @"DBMigrateFinishNotification"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self setAppWindows];
//    [self setTabbarController];
    [self setRootViewController];
    [self registNotificationWithOptions:launchOptions];
    [self setupIqKeyboardManager];
    

    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// iOS9 以上用这个方法接收
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    NSDictionary * dic = options;
    NSLog(@"%@", dic);
    if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.sina.weibo"]) {
        NSLog(@"新浪微博~");
        
        return [WeiboSDK handleOpenURL:url delegate:[WTThirdPartyLoginManager shareWTThirdPartyLoginManager]];
    }else if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.xin"]){
        
        return [WXApi handleOpenURL:url delegate:[WTThirdPartyLoginManager shareWTThirdPartyLoginManager]];
    }else if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.mqq"]){
        
        //        [WTThirdPartyLoginManager didReceiveTencentUrl:url];
//        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}
// iOS9 以下用这个方法接收
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"%@",url);
    
    
    if ([sourceApplication isEqualToString:@"com.sina.weibo"]) {
        
        return [WeiboSDK handleOpenURL:url delegate:[WTThirdPartyLoginManager shareWTThirdPartyLoginManager]];
        
    }else if ([sourceApplication isEqualToString:@"com.tencent.xin"]){
        
        return [WXApi handleOpenURL:url delegate:[WTThirdPartyLoginManager shareWTThirdPartyLoginManager]];
        
    }else if ([sourceApplication isEqualToString:@"com.tencent.mqq"]){
        
        //        [WTShareManager didReceiveTencentUrl:url];
//        return [TencentOAuth HandleOpenURL:url];
    }
    
    
    return YES;
}



#pragma mark 键盘躲避库
-(void)setupIqKeyboardManager{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    
    manager.enable = YES;
    
    manager.shouldResignOnTouchOutside = YES;
    
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    
    manager.enableAutoToolbar = YES;
}

- (void)onDBMigrateStart {
    NSLog(@"onDBmigrateStart in appdelegate");
    _isDBMigrating = YES;
}

- (void)onDBMigrateFinishedWithError:(NSError *)error {
    NSLog(@"onDBmigrateFinish in appdelegate");
    _isDBMigrating = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:kDBMigrateFinishNotification object:nil];
}

@end
