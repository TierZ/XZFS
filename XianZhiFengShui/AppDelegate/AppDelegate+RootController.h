//
//  AppDelegate+RootController.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/8.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//
/**
 *  app的 根vc
 *
 *  @param RootController <#RootController description#>
 *
 *  @return <#return value description#>
 */
#import "AppDelegate.h"

@interface AppDelegate (RootController)<UIScrollViewDelegate>
/**
 *  首次启动轮播图
 */
- (void)createLoadingScrollView;
/**
 *  tabbar实例
 */
//- (void)setTabbarController;

/**
 *  window实例
 */
//- (void)setAppWindows;

/**
 *  根视图
 */
- (void)setRootViewController;
@end
