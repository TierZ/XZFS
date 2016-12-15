//
//  XZFindService.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/23.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "BasicService.h"

typedef NS_ENUM(NSUInteger, XZFindServiceTag) {
    XZMasterListHot = 200,
     XZMasterListLocal,
     XZMasterListAll,
    XZLectureList,
    XZThemeList,
    XZMasterDetail,
    XZEvaluateMaster,
    XZCollectionMaster
};

@interface XZFindService : BasicService

/**
 获取大师列表

 @param pageNum  页码
 @param pageSize 每页个数
 @param cityCode 城市列表
 @param view     a
 */
-(void)masterListWithPageNum:(int)pageNum PageSize:(int)pageSize cityCode:(NSString*)cityCode view:(id)view;


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
 @param view       。。
 */
-(void)evaluateMasterWithMasterCode:(NSString*)masterCode userCode:(NSString*)userCode content:(NSString*)content cityCode:(NSString*)cityCode view:(id)view;


/**
 收藏（取消）大师

 @param masterCode 大师编码
 @param userCode   用户编码
 @param type       类型 1收藏   2 取消收藏
 @param cityCode   城市编码
 @param view       。。
 */
-(void)collectMasterWithMasterCode:(NSString*)masterCode userCode:(NSString*)userCode type:(NSInteger)type cityCode:(NSString*)cityCode view:(id)view;
@end
