//
//  XZBankCardModel.h
//  XianZhiFengShui
//
//  Created by 左晓东 on 16/11/17.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 我的银行卡
 */
@interface XZBankCardModel : NSObject
@property (nonatomic,copy)NSString * bankCardUrl;
@property (nonatomic,copy)NSString * cardName;
@property (nonatomic,copy)NSString * cardNum;
@end
