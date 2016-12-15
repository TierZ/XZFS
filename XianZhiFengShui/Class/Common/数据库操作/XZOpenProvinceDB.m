//
//  XZOpenProvinceDB.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZOpenProvinceDB.h"

@implementation XZOpenProvinceDB{
    sqlite3 * _dataBase;
}
static XZOpenProvinceDB*sharedProvinceDB = nil;

+(XZOpenProvinceDB*)sharedProvinceDB{
    static dispatch_once_t  predicate;
    dispatch_once(&predicate, ^{
        sharedProvinceDB = [[self alloc]init ];
    });
    return sharedProvinceDB;
}


#pragma mark - 数据库
- (BOOL) OpenDatabase
{
  
    // 数据库路径
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"miy.db" ofType:nil];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isFile = [fileManager fileExistsAtPath:dataPath];
    
    // 数据库已存在
    if (isFile)
    {
        if (sqlite3_open([dataPath UTF8String], &_dataBase) != SQLITE_OK)
        {
            NSLog(@"open database fail");
            return NO;
        }
        else
        {
            NSLog(@"open database success");
            return YES;
        }
    }
    // 数据库不存在
    else
    {
        NSLog(@"the database is not existed");
        
    }
    return YES;
}

- (NSArray*)selectDBData
{
    NSMutableArray *arr = [NSMutableArray array];
    NSString *query = [NSString stringWithFormat:@"select * from province"];
    //打开数据库
    if ([self OpenDatabase])
    {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_dataBase, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                // 获取数据
                int m_id = sqlite3_column_int(statement, 1);
                char *name = (char *)sqlite3_column_text(statement, 2);
                
                [dictionary setValue:[NSNumber numberWithInt:m_id] forKey:@"id"];
                [dictionary setValue:[NSString stringWithCString:name encoding:NSUTF8StringEncoding] forKey:@"name"];
                [arr addObject:dictionary];
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(_dataBase);
            
            return arr;
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_dataBase);
        
    }
    
    
    return arr;
}
#pragma mark - 兼容容错
//兼容
//- (NSArray*)selectDBProAllName
//{
//    NSMutableArray *arr = [NSMutableArray array];
//    NSString *query = [NSString stringWithFormat:@"select * from province"];
//    //打开数据库
//    if ([self OpenDatabase])
//    {
//        sqlite3_stmt *statement;
//        if (sqlite3_prepare_v2(_dataBase, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
//        {
//            while (sqlite3_step(statement) == SQLITE_ROW)
//            {
//                // 获取数据
//                char *name = (char *)sqlite3_column_text(statement, 2);
//                [arr addObject:[NSString stringWithCString:name encoding:NSUTF8StringEncoding]];
//            }
//
//            sqlite3_finalize(statement);
//            sqlite3_close(_dataBase);
//
//            return arr;
//        }
//
//        sqlite3_finalize(statement);
//        sqlite3_close(_dataBase);
//
//    }
//
//    return arr;
//}

- (NSArray*)selectDBCityAllNameWithProID:(int)proID
{
    NSMutableArray *arr = [NSMutableArray array];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM province_city where prov_id = %d",proID];
    //打开数据库
    if ([self OpenDatabase])
    {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_dataBase, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                // 获取数据
                int m_id = sqlite3_column_int(statement, 1);
                char *name = (char *)sqlite3_column_text(statement, 3);
                
                [dictionary setValue:[NSNumber numberWithInt:m_id] forKey:@"id"];
                [dictionary setValue:[NSString stringWithCString:name encoding:NSUTF8StringEncoding] forKey:@"name"];
                [arr addObject:dictionary];
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(_dataBase);
            
            return arr;
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_dataBase);
        
    }
    return arr;
}

- (NSArray*)selectDBAreaAllNameWithProID:(int)proID withCityID:(int)cityID
{
    NSMutableArray *arr = [NSMutableArray array];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM province_city_area where prov_id = %d and city_id = %d",proID,cityID];
    //打开数据库
    if ([self OpenDatabase])
    {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_dataBase, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                // 获取数据
                int m_id = sqlite3_column_int(statement, 1);
                char *name = (char *)sqlite3_column_text(statement, 4);
                
                [dictionary setValue:[NSNumber numberWithInt:m_id] forKey:@"id"];
                [dictionary setValue:[NSString stringWithCString:name encoding:NSUTF8StringEncoding] forKey:@"name"];
                [arr addObject:dictionary];
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(_dataBase);
            
            return arr;
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_dataBase);
    }
    return arr;
}

- (NSArray*)selectDBTownAllNameWithProID:(int)proID withCityID:(int)cityID withAreaID:(int)areaID
{
    NSMutableArray *arr = [NSMutableArray array];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM  province_city_area_town where  prov_id = %d and city_id = %D and area_id = %d",proID,cityID,areaID];
    //打开数据库
    if ([self OpenDatabase])
    {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_dataBase, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                // 获取数据
                int m_id = sqlite3_column_int(statement, 1);
                char *name = (char *)sqlite3_column_text(statement, 5);
                
                [dictionary setValue:[NSNumber numberWithInt:m_id] forKey:@"id"];
                [dictionary setValue:[NSString stringWithCString:name encoding:NSUTF8StringEncoding] forKey:@"name"];
                [arr addObject:dictionary];
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(_dataBase);
            
            return arr;
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_dataBase);
        
    }
    return arr;
}


//name 兼容
- (NSMutableDictionary *)CompatibleName:(NSArray *)array withName:(NSString *)name
{
    NSMutableDictionary *temDic = nil;
    for (NSMutableDictionary *dic in array) {
        if (!temDic) {
            temDic = dic;
        }
        if ([name rangeOfString:[dic objectForKey:@"name"]].location !=NSNotFound) {
            temDic = dic;
            break;
        }
        
        //        for (int i =0; i<array.count; i++) {
        //            //对应name 找到数组种的name 就拿到当前字典
        //             if([name isEqualToString:[[array objectAtIndex:i]objectForKey:@"name"]]){
        //                 temDic = [array objectAtIndex:i];
        //             }
        //            //如果没有返回 =-1 就赋值当前
        //            if ([[[array objectAtIndex:i]objectForKey:@"id"] isEqualToNumber:[NSNumber numberWithInt:-1]]) {
        //                string = temStr;
        //                [temDic setObject:temStr forKey:@"name"];
        //                [temDic setObject:temId forKey:@"id"];
        //            }
        //            //返回数据包含本地数据
        //            temStr = [[array objectAtIndex:i] objectForKey:@"name"];
        //            if ([name rangeOfString:temStr].location !=NSNotFound) {
        //                string = temStr;
        //            }
        //        }
    }
    return temDic;
}
#pragma mark -
//根据字符串获取ID
//省ID
- (int) selectProStr:(NSString*)prov
{
    //设置默认ID 防止崩溃
    int ID = -1;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM province where name= \'%@\'",prov];
    if ([self OpenDatabase]) {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_dataBase, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW){
                // 查询到ID就重新赋值
                int m_id = sqlite3_column_int(statement, 1);
                ID = m_id;
            }
        }
    }
    
    return ID;
}
//城市的ID
- (int) selectCityStr:(NSString *)city withProID:(int)proID
{
    int ID = -1;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM province_city where name= \'%@\' and prov_id= %d",city,proID];
    if ([self OpenDatabase]) {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_dataBase, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW){
                // 获取数据
                int m_id = sqlite3_column_int(statement, 1);
                ID = m_id;
            }
        }
    }
    return ID;
}
//县城ID
- (int)selectAreaStr:(NSString *)area withProID:(int)proID withCityID:(int)cityID
{
    int ID = -1;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM province_city_area where name= \'%@\' and prov_id= %d and city_id= %d",area,proID,cityID];
    if ([self OpenDatabase]) {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_dataBase, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW){
                // 获取数据
                int m_id = sqlite3_column_int(statement, 1);
                ID = m_id;
            }
        }
    }
    return ID;
}
//街道ID
- (int)selectTownStr:(NSString *)town withProID:(int)proID withCityID:(int)cityID withAreaID:(int)areaID
{
    int ID = -1;
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM province_city_area_town where name= \'%@\' and prov_id= %d and city_id= %d and area_id= %d",town,proID,cityID,areaID];
    if ([self OpenDatabase]) {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_dataBase, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW){
                // 获取数据
                int m_id = sqlite3_column_int(statement, 1);
                ID = m_id;
            }
        }
    }
    return ID;
}

//根据ID 获取所有数据
- (NSArray*)selectCityData:(int)provId
{
    NSMutableArray *arr = [NSMutableArray array];
    NSString *query = [NSString stringWithFormat:@"select * from province_city where prov_id = %d",provId];
    //打开数据库
    if ([self OpenDatabase])
    {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_dataBase, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                // 获取数据
                int m_id = sqlite3_column_int(statement, 1);
                char *name = (char *)sqlite3_column_text(statement, 3);
                
                [dictionary setValue:[NSNumber numberWithInt:m_id] forKey:@"id"];
                [dictionary setValue:[NSString stringWithCString:name encoding:NSUTF8StringEncoding] forKey:@"name"];
                [arr addObject:dictionary];
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(_dataBase);
            
            return arr;
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_dataBase);
        
    }
    
    
    return arr;
}

- (NSArray*)selectAreaData:(int)cityId
{
    NSMutableArray *arr = [NSMutableArray array];
    NSString *query = [NSString stringWithFormat:@"select * from province_city_area where city_id = %d",cityId];
    //打开数据库
    if ([self OpenDatabase])
    {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_dataBase, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                // 获取数据
                int m_id = sqlite3_column_int(statement, 1);
                char *name = (char *)sqlite3_column_text(statement, 4);
                
                [dictionary setValue:[NSNumber numberWithInt:m_id] forKey:@"id"];
                [dictionary setValue:[NSString stringWithCString:name encoding:NSUTF8StringEncoding] forKey:@"name"];
                [arr addObject:dictionary];
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(_dataBase);
            
            return arr;
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_dataBase);
        
    }
    
    
    return arr;
}
- (NSArray*)selectTownData:(int)areaId
{
    NSMutableArray *arr = [NSMutableArray array];
    NSString *query = [NSString stringWithFormat:@"select * from province_city_area_town where area_id = %d",areaId];
    //打开数据库
    if ([self OpenDatabase])
    {
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(_dataBase, [query UTF8String], -1, &statement, nil) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
                // 获取数据
                int m_id = sqlite3_column_int(statement, 1);
                char *name = (char *)sqlite3_column_text(statement, 5);
                
                [dictionary setValue:[NSNumber numberWithInt:m_id] forKey:@"id"];
                [dictionary setValue:[NSString stringWithCString:name encoding:NSUTF8StringEncoding] forKey:@"name"];
                [arr addObject:dictionary];
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(_dataBase);
            
            return arr;
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_dataBase);
        
    }
    
    return arr;
}

@end
