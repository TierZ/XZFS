//
//  XZOpenProvinceDB.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface XZOpenProvinceDB : NSObject
+(XZOpenProvinceDB*)sharedProvinceDB;
- (BOOL) OpenDatabase;
- (NSArray*)selectDBData;
- (NSArray*)selectDBCityAllNameWithProID:(int)proID;
- (NSArray*)selectDBAreaAllNameWithProID:(int)proID withCityID:(int)cityID;
- (NSArray*)selectDBTownAllNameWithProID:(int)proID withCityID:(int)cityID withAreaID:(int)areaID
;
- (NSMutableDictionary *)CompatibleName:(NSArray *)array withName:(NSString *)name;


/**
 获取省id

 @param prov 省名

 @return 省id
 */
- (int) selectProStr:(NSString*)prov;

/**
 获取市id

 @param city  市名字
 @param proID 省id

 @return 市id
 */
- (int) selectCityStr:(NSString *)city withProID:(int)proID;

/**
 区id

 @param area   区名
 @param proID  省id
 @param cityID 市id

 @return 区id
 */
- (int)selectAreaStr:(NSString *)area withProID:(int)proID withCityID:(int)cityID;

/**
 街道（镇）id

 @param town   街道/镇  名
 @param proID  省id
 @param cityID 市id
 @param areaID 区id

 @return 。。
 */
- (int)selectTownStr:(NSString *)town withProID:(int)proID withCityID:(int)cityID withAreaID:(int)areaID;

- (NSArray*)selectCityData:(int)provId;
- (NSArray*)selectAreaData:(int)cityId;
- (NSArray*)selectTownData:(int)areaId;
@end
