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

 @param pageNum      页码
 @param pageSize     每页
 @param cityCode     城市
 @param view         。。
 @param successBlock 成功
 @param errorBlock   失败
 */
-(void)masterListWithPageNum:(int)pageNum PageSize:(int)pageSize cityCode:(NSString*)cityCode view:(id)view successBlock:(void (^)(NSArray *data))successBlock failBlock:(void (^)(NSError *error))errorBlock;


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
