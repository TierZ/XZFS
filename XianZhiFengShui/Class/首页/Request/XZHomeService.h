//
//  XZHomeService.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/21.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

typedef NS_ENUM(NSUInteger, XZHomeServiceTag) {
    XZGetDataList = 100,
    XZGettCityList,
};

#import "BasicService.h"

@interface XZHomeService : BasicService

/**
 获取首页数据

 @param cityCode 城市编码
 @param view     <#view description#>
 */
-(void)requestHomeDataWithCityCode:(NSString*)cityCode View:(id)view ;


/**
 首页数据

 @param cityCode     城市
 @param view         ，，
 @param successBlock 成功
 @param errorBlock   失败
 */
-(void)requestHomeDataWithCityCode:(NSString*)cityCode View:(id)view successBlock:(void (^)(NSDictionary *data))successBlock failBlock:(void (^)(NSError *error))errorBlock;


/**
 首页大师

 @param pageNum    页码
 @param pageSize   每页数量
 @param cityCode   城市
 @param keyWord    关键字（本地，全部，最热） 当searchType=1时有效
 @param searchType 1表示默认列表；2表示预约（进行中）的大师列表；3表示预约（已完成）的大师列表；4表示收藏（想约）的大师列表，默认值为1
 @param userCode   用户id   当searchType字段值为2/3时，如果不传此字段或此字段为空，则返回错误信息、没有收藏大师时返回一个空的JsonObject对象；
 @param successBlock 成功
 @param errorBlock   失败
 */
-(void)masterListWithPageNum:(int)pageNum PageSize:(int)pageSize cityCode:(NSString*)cityCode keyWord:(NSString*)keyWord searchType:(int)searchType userCode:(NSString*)userCode view:(id)view successBlock:(void (^)(NSArray *data))successBlock failBlock:(void (^)(NSError *error))errorBlock;


/**
 首页讲座

 @param pageNum      页码
 @param pageSize     每页
 @param cityCode     城市
 @param view         。。
 @param successBlock 成功
 @param errorBlock   失败
 */
-(void)lectureListWithPageNum:(int)pageNum PageSize:(int)pageSize cityCode:(NSString*)cityCode view:(id)view successBlock:(void (^)(NSArray *data))successBlock failBlock:(void (^)(NSError *error))errorBlock;

/**
 获取城市列表

 @param view <#view description#>
 */
-(void)requestHomeCityListWithView:(id)view;


@end
