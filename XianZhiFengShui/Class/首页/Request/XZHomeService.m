//
//  XZHomeService.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/21.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//


#define XZHomeData @"/getDataList"
#define XZHomeCityList @"/getCityList"

#import "XZHomeService.h"

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
    
    [self postRequestWithUrl:XZHomeData parmater:lastDic view:view isOpenHUD:YES  Block:^(NSDictionary *data) {
//        NSDictionary * dics = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSDictionary * resultDic = [self dataDecryptionWithDic:dics];
//        [self showFailInfoWithDic:resultDic view:view];
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



@end
