//
//  XZHomeService.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/21.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//


#define XZHomeData @"/getDataList"
#define XZHomeCityList @"/getCityList"

static NSString * XZHomeMasterList = @"/master/list";
static NSString * XZHomeLectureList = @"/lectures/list";
static NSString * XZHomeNaviMenuList = @"/getNaviMenuList";
#import "XZHomeService.h"
#import "XZTheMasterModel.h"

@implementation XZHomeService
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark 获取首页数据
-(void)requestHomeDataWithCityCode:(NSString*)cityCode View:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];

    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZHomeData parmater:lastDic view:view isOpenHUD:NO  Block:^(NSDictionary *data) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 获取城市列表

-(void)requestHomeCityListWithView:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSDictionary * lastDic =[self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZHomeCityList parmater:lastDic view:view isOpenHUD:YES  Block:^(NSDictionary *data) {
      
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"]];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:)]) {
            [self.delegate netFailedWithHandle:error];
        }
    }];
}



#pragma mark 首页数据
-(void)requestHomeDataWithCityCode:(NSString*)cityCode View:(id)view successBlock:(void (^)(NSDictionary *data))successBlock failBlock:(void (^)(NSError *error))errorBlock{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZHomeData parmater:lastDic view:view isOpenHUD:NO  Block:^(NSDictionary *data) {
        successBlock(data);
    } failBlock:^(NSError *error) {
        errorBlock(error);
    }];
}



#pragma mark 首页大师

-(void)masterListWithPageNum:(int)pageNum PageSize:(int)pageSize cityCode:(NSString*)cityCode keyWord:(NSString*)keyWord searchType:(int)searchType userCode:(NSString*)userCode view:(id)view successBlock:(void (^)(NSArray *data))successBlock failBlock:(void (^)(NSError *error))errorBlock{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:keyWord forKey:@"keyWord"];
    NSString * userCodeStr = userCode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
    [dic setObject:[NSNumber numberWithInt:searchType] forKey:@"searchType"];
    [dic setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    [dic setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZHomeMasterList parmater:lastDic view:view isOpenHUD:NO  Block:^(NSDictionary *data) {
        NSArray * arr = [[data objectForKey:@"data"]objectForKey:@"list"];
        NSMutableArray * dataArr = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            XZTheMasterModel * model = [XZTheMasterModel modelWithDictionary:arr[i]];
            [dataArr addObject:model];
        }
        successBlock(dataArr);
    } failBlock:^(NSError *error) {
        errorBlock(error);
    }];
}



#pragma mark 首页讲座
 
-(void)lectureListWithPageNum:(int)pageNum PageSize:(int)pageSize cityCode:(NSString*)cityCode view:(id)view successBlock:(void (^)(NSArray *data))successBlock failBlock:(void (^)(NSError *error))errorBlock{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    [dic setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZHomeLectureList parmater:lastDic view:view isOpenHUD:NO  Block:^(NSDictionary *data) {
        NSArray * arr = [[data objectForKey:@"data"]objectForKey:@"list"];
        NSMutableArray * dataArr = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            XZTheMasterModel * model = [XZTheMasterModel modelWithDictionary:arr[i]];
            [dataArr addObject:model];
        }
        successBlock(dataArr);
    } failBlock:^(NSError *error) {
        errorBlock(error);
    }];
}

#pragma mark 首页获取大师服务列表
-(void)requestNaviMenuListWithCityCode:(NSString*)cityCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZHomeNaviMenuList parmater:lastDic view:view isOpenHUD:NO  Block:^(NSDictionary *data) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}
@end
