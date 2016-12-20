//
//  XZFindService.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/23.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

static NSString * evaluateMasterService = @"/master/evaluate/confirm";
static NSString * collectionMasterService = @"/master/collection/confirm";
static NSString * XZGetMasterList = @"/master/list";
static NSString * XZGetMasterDetail = @"/master/detail";
static NSString * XZGetLectureList = @"/lectures/list";
static NSString * XZGetLectureDetail = @"/lectures/detail";



#import "XZFindService.h"

@implementation XZFindService

#pragma mark 大师列表
-(void)masterListWithPageNum:(int)pageNum PageSize:(int)pageSize cityCode:(NSString*)cityCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    [dic setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];

    [self postRequestWithUrl:XZGetMasterList parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
              if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}


#pragma mark 大师详情
-(void)masterDetailWithMasterCode:(NSString*)masterCode UserCode:(NSString*)userCode cityCode:(NSString*)cityCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:masterCode forKey:@"masterCode"];
    [dic setObject:userCode forKey:@"userCode"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZGetMasterDetail parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
            if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 评价大师
-(void)evaluateMasterWithMasterCode:(NSString*)masterCode userCode:(NSString*)userCode content:(NSString*)content cityCode:(NSString*)cityCode masterOrderCode:(NSString *)masterOrderCode star:(NSInteger)star view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:masterCode forKey:@"masterCode"];
    [dic setObject:userCode forKey:@"userCode"];
    [dic setObject:content forKey:@"content"];
    [dic setObject:masterOrderCode forKey:@"masterOrderCode"];
    [dic setObject:[NSNumber numberWithInteger:star] forKey:@"star"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:evaluateMasterService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 收藏/取消收藏  大师
-(void)collectMasterWithMasterCode:(NSString*)masterCode userCode:(NSString*)userCode type:(NSInteger)type cityCode:(NSString*)cityCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:masterCode forKey:@"masterCode"];
    [dic setObject:userCode forKey:@"userCode"];
    [dic setObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:collectionMasterService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}


#pragma mark 讲座列表
-(void)lectureListWithPageNum:(int)pageNum PageSize:(int)pageSize cityCode:(NSString*)cityCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    [dic setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZGetLectureList parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}


#pragma mark 讲座详情
-(void)lectureDetailWithMasterCode:(NSString*)masterCode UserCode:(NSString*)userCode cityCode:(NSString*)cityCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:masterCode forKey:@"masterCode"];
    [dic setObject:userCode forKey:@"userCode"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZGetMasterDetail parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
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
