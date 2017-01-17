//
//  XZFindService.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/23.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "BasicService.h"

typedef NS_ENUM(NSUInteger, XZFindServiceTag) {
    XZMasterListHot = 200,//热门大师
    XZMasterListLocal,//本地大师
    XZMasterListAll,//全部大师
    XZLectureList,//讲座列表
    XZThemeTypeList,//话题类型列表
    XZThemeList,//话题列表
    XZMasterDetail,//大师详情
    XZLectureDetail,//讲座详情
    XZThemeDetail,//话题详情
    XZEvaluateMaster,//评价大师
    XZCollectionMaster,//收藏／取消大师
    XZPointOfPraiseMaster,//给大师点赞
};

@interface XZFindService : BasicService


/**
 获取大师列表

 @param pageNum    页码
 @param pageSize   每页数量
 @param cityCode   城市
 @param keyWord    关键字（本地，全部，最热） 当searchType=1时有效
 @param searchType 1表示默认列表；2表示预约（进行中）的大师列表；3表示预约（已完成）的大师列表；4表示收藏（想约）的大师列表，默认值为1
 @param userCode   用户id   当searchType字段值为2/3时，如果不传此字段或此字段为空，则返回错误信息、没有收藏大师时返回一个空的JsonObject对象；
 @param orderType   排序字段：1表示全部；2表示本地；3表示最火 当searchType=1或searchType=5时有效；默认值为3
 @param view       。。
 
 */
-(void)masterListWithPageNum:(int)pageNum PageSize:(int)pageSize cityCode:(NSString*)cityCode keyWord:(NSString*)keyWord searchType:(int)searchType userCode:(NSString*)userCode orderType:(int)orderType view:(id)view;


/**
 获取大师详情

 @param masterCode 大师code
 @param userCode   用户code
 @param cityCode   城市代码
 @param view       <#view description#>
 */
-(void)masterDetailWithMasterCode:(NSString*)masterCode UserCode:(NSString*)userCode cityCode:(NSString*)cityCode view:(id)view;

/**
 评价大师

 @param masterCode 大师编号
 @param userCode   用户编号
 @param content    内容
 @param cityCode   城市
 @param masterOrderCode   大师订单编号
 @param serviceAttitude       服务态度
 @param professionalLevel       专业水平
  @param view       。。
 */
-(void)evaluateMasterWithMasterCode:(NSString*)masterCode userCode:(NSString*)userCode content:(NSString*)content cityCode:(NSString*)cityCode masterOrderCode:(NSString *)masterOrderCode serviceAttitude:(NSInteger)serviceAttitude professionalLevel:(NSInteger)professionalLevel view:(id)view;


/**
 收藏（取消）大师

 @param masterCode 大师编码
 @param userCode   用户编码
 @param type       类型 1收藏   2 取消收藏
 @param cityCode   城市编码
 @param view       。。
 */
-(void)collectMasterWithMasterCode:(NSString*)masterCode userCode:(NSString*)userCode type:(NSInteger)type cityCode:(NSString*)cityCode view:(id)view;



/**
 讲座列表

 @param pageNum 页码
 @param pageSize 每页个数
 @param userCode 用户id
 @param cityCode 城市代码
 @param view 。。
 */
-(void)lectureListWithPageNum:(int)pageNum PageSize:(int)pageSize userCode:(NSString*)userCode cityCode:(NSString*)cityCode view:(id)view;


/**
 讲座详情

 @param masterCode 大师编号
 @param userCode 用户编号
 @param cityCode 城市代码
 @param view ，，
 */
-(void)lectureDetailWithMasterCode:(NSString*)masterCode UserCode:(NSString*)userCode cityCode:(NSString*)cityCode view:(id)view;


/**
 话题类型列表

 @param cityCode 城市代码
 @param view ..
 */
-(void)themeTypeListWithCityCode:(NSString*)cityCode view:(id)view;

/**
 话题列表

 @param pageNum  页码
 @param pageSize 个数
 @param cityCode 城市代码
 @param view     。。
 */
-(void)themeListWithPageNum:(int)pageNum PageSize:(int)pageSize cityCode:(NSString*)cityCode view:(id)view;


/**
 话题详情

 @param topicCode 话题id
 @param userCode  用户id
 @param cityCode  城市id
 @param view      。。
 */
-(void)themeDetailWithTopicCode:(NSString*)topicCode userCode:(NSString*)userCode cityCode:(NSString*)cityCode view:(id)view;



/**
 给大师点赞

 @param cityCode   城市代码
 @param masterCode 大师id
 @param userCode   用户id
 @param view       。。
 */
-(void)pointOfPraiseMasterWithCityCode:(NSString*)cityCode masterCode:(NSString*)masterCode userCode:(NSString*)userCode view:(id)view;


@end
