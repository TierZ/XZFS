//
//  XZThemeDetailData.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/3.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

typedef NS_ENUM(NSUInteger, XZThemeDetailListTag) {//话题相关
    XZConfirmTopicTag = 280,//发布话题
    XZUpdateTopicTag,//修改话题
    XZPointOfPraiseTopicTag,//话题点赞
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


/**
 给话题点赞

 @param cityCode  城市
 @param topicCode 话题id
 @param userCode  用户id
 @param view      。。
 */
-(void)pointOfPraiseTopicWithCityCode:(NSString*)cityCode topicCode:(NSString*)topicCode userCode:(NSString*)userCode view:(id)view;


/**
 修改话题

 @param cityCode 城市
 @param bizCode  话题编号
 @param userCode 用户id
 @param title    标题
 @param content  内容
 @param typeCode 话题类型
 @param picList  图片数组
 @param view     。。
 */
-(void)updateMyTopicWithCityCode:(NSString*)cityCode bizCode:(NSString*)bizCode userCode:(NSString*)userCode title:(NSString*)title content:(NSString*)content typeCode:(NSString*)typeCode picList:(NSArray*)picList view:(id)view;
@end
