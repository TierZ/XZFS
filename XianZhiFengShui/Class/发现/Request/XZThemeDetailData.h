//
//  XZThemeDetailData.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/3.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

typedef NS_ENUM(NSUInteger, XZThemeDetailListTag) {//话题相关
    XZConfirmTopicTag = 280,//发布话题
    XZAlertTopicTag,//修改话题
};

#import "BasicService.h"

/**
 话题相关
 */
@interface XZThemeDetailData : BasicService

/**
 发表话题

 @param cityCode 城市代码
 @param userCode 用户id
 @param title    标题
 @param content  内容
 @param typeCode 类型
 @param picList  图片数组
 @param view     。。
 */
-(void)confirmTopicWithCityCode:(NSString*)cityCode userCode:(NSString*)userCode title:(NSString*)title content:(NSString*)content typeCode:(NSString*)typeCode picList:(NSArray*)picList view:(id)view;
@end
