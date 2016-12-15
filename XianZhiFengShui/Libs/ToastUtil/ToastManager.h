//
//  ToastManager.h
//  ShaGuaLiCai
//
//  Created by shagualicai on 16/5/19.
//  Copyright © 2016年 傻瓜理财. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ToastMSG_NetworkErr     @"网络异常"     // AFN的超时、失败block/代理
#define ToastMSG_DataFormErr    @"数据格式错误"  // json为空

@interface ToastManager : NSObject
+ (void)showToastOnView:(UIView *)v position:(id)position flag:(BOOL)flag message:(NSString *)message;
@end
