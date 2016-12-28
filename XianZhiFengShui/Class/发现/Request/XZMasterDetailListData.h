//
//  XZMasterDetailListData.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/27.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicService.h"

typedef NS_ENUM(NSUInteger, XZMasterDetailListTag) {//大师详情内
    XZMasterArticleDetail = 230,//大师文章详情
    XZMasterArticleList,//大师文章列表
};

@interface XZMasterDetailListData : BasicService

/**
 大师文章列表
 
 @param masterCode 大师id
 @param pageNum    页码
 @param pageSize   每页
 @param cityCode   城市id
 @param view       。。
 */
-(void)articleListWithMasterCode:(NSString*)masterCode pageNum:(int)pageNum pageSize:(int)pageSize cityCode:(NSString*)cityCode view:(id)view successBlock:(void (^)(NSArray  *data))successBlock failBlock:(void (^)(NSError *error))errorBlock;



/**
 文章详情

 @param cityCode     城市
 @param articleCode  文章id
 @param view         。。
 @param successBlock 成功回调
 @param errorBlock   失败回调
 */
-(void)articleDetailWithCityCode:(NSString*)cityCode articleCode:(NSString*)articleCode view:(id)view successBlock:(void (^)(NSDictionary  *data))successBlock failBlock:(void (^)(NSError *error))errorBlock;
@end
