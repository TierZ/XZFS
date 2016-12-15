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
-(void)requestHomeDataWithCityCode:(NSString*)cityCode View:(id)view;


/**
 获取城市列表

 @param view <#view description#>
 */
-(void)requestHomeCityListWithView:(id)view;
@end
