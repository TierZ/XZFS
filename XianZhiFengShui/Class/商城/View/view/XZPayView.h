//
//  XZPayView.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, SelectPay) {
    AliPaySelected = 10,
    WXPaySelected,
    ZBPaySelected,
};

typedef void(^SelectPayStyleBlock)(SelectPay pay);
@interface XZPayView : UIView
@property (nonatomic,copy)SelectPayStyleBlock block;
-(void)selectPayWithBlock:(SelectPayStyleBlock)block;
@end
