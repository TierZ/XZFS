//
//  ToastManager.m
//  ShaGuaLiCai
//
//  Created by shagualicai on 16/5/19.
//  Copyright © 2016年 傻瓜理财. All rights reserved.
//

#import "ToastManager.h"
//#import "UIView+Toast.h"
@implementation ToastManager


+ (void)showToastOnView:(UIView *)v position:(id)position flag:(BOOL)flag message:(NSString *)message {
    
    CSToastStyle* cs = [[CSToastStyle alloc]initWithDefaultStyle];
    cs.imageSize = CGSizeMake(40, 40);
    cs.cornerRadius = 3;
    cs.messageFont =  XZFS_S_FONT(15);
    cs.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    cs.horizontalPadding = 50;
    cs.verticalPadding = 10;
    cs.messageAlignment = NSTextAlignmentCenter;
    cs.maxWidthPercentage = 0.9;
    
    NSString *imgName = @"tankuang_icon_cry-face";
    if (flag) {
        imgName = @"tankuang_icon_smile-face";
    }
    [v makeToast:message duration:1.6 position:position title:nil image:[UIImage imageNamed:imgName] style:cs completion:nil];
}
@end
