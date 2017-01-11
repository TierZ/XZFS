//
//  XZTheMasterModel.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/10.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 发现 model
 */
@interface XZTheMasterModel : NSObject

//大师
@property (nonatomic,copy)NSString * id;//大师id（无实际含义
@property (nonatomic,copy)NSString * masterCode;//大师编号（唯一性）
@property (nonatomic,copy)NSString * bizCode;//大师编号（唯一
@property (nonatomic,copy)NSString * name;//大师名称
@property (nonatomic,copy)NSString * icon;//大师图片
@property (nonatomic,copy)NSString * nickname;//大师昵称
@property (nonatomic,copy)NSString * level;//等级
@property (nonatomic,copy)NSString * singleVolume;//成单数
@property (nonatomic,copy)NSString * pointOfPraise;//点赞数
@property (nonatomic,copy)NSString * collection;//收藏数
@property (nonatomic,strong)NSArray * type;//服务类型
@property (nonatomic,copy)NSString * summary;//介绍

@property (nonatomic,copy)NSString * service;//约见的项目内容
@property (nonatomic,assign)BOOL isFinished;//约见大师 （yes 表示 已结束，no表示正在进行中）

//讲座
@property (nonatomic,copy)NSString * title;//标题
@property (nonatomic,copy)NSString * price;//价格
@property (nonatomic,copy)NSString * lecturesCode;//讲座编码
@property (nonatomic,copy)NSString * desc;//大师详细介绍
@property (nonatomic,copy)NSString * appoint;//预约数
@property (nonatomic,copy)NSString * address;//大师地址
@property (nonatomic,strong)NSArray * serviceType;//客户评价：客户头像、昵称、简介、日期、评价内容
@property (nonatomic,copy)NSString * masterDesc;//大师介绍
@property (nonatomic,copy)NSString * masterName;//大师名字
@property (nonatomic,copy)NSString * startTime;//开始时间
@property (nonatomic,copy)NSString * remainSeats;//剩余
@property (nonatomic,copy)NSString * totalSeats;//总共座位
@property (nonatomic,copy)NSString * masterIcon;//大师icon


@property (nonatomic,copy)NSString* collect;//是否收藏 1：收藏 0：未收藏

// 话题
@property (nonatomic,copy)NSString * onFocus;//关注
@property (nonatomic,copy)NSString * browse;//浏览
@property (nonatomic,assign)BOOL isFocused;//关注typeCode
@property (nonatomic,copy)NSString * typeCode;//话题类型编号

@end
