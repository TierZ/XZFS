//
//  XZMasterModel.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/4.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 大师端 model
 */
@interface XZMasterModel : NSObject
@property (nonatomic,copy)NSString * icon;//大师头像
@property (nonatomic,copy)NSString * name;//大师名字
@property (nonatomic,copy)NSString * level;//等级
@property (nonatomic,copy)NSString * state;//服务状态：通过审核，等待审核。。
@property (nonatomic,assign)long  price;//价格
@property (nonatomic,assign)int appointCount;//约见次数
@property (nonatomic,copy)NSString * summary;//项目介绍
@end


/**
 大师订单
 */
@interface XZMasterOrderModel : NSObject
@property (nonatomic,copy)NSString * icon;
@property (nonatomic,copy)NSString * service;
@property (nonatomic,copy)NSString * time;
@property (nonatomic,copy)NSString * location;
@property (nonatomic,copy)NSString * price;
@property (nonatomic,copy)NSString * appointTime;
@property (nonatomic,copy)NSString * cancelReason;//取消原因

@end
