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
static NSString * XZGetMasterArticleList = @"/master/article/list";
static NSString * XZGetMasterArticleDetail = @"/master/article/detail";
static NSString * XZGetLectureList = @"/lectures/list";
static NSString * XZGetLectureDetail = @"/lectures/detail";
static NSString * XZGetThemeTypeList = @"/topic/typeList";
static NSString * XZGetThemeList = @"/topic/list";
static NSString * XZGetThemeDetail = @"/topic/detail";
static NSString * XZPointOfPraiseService = @"/master/pointOfPraise";

#import "XZFindService.h"
#import "XZTheMasterModel.h"
#import "XZThemeListModel.h"
#import "XZMasterInfoModel.h"
@implementation XZFindService

#pragma mark 大师列表
-(void)masterListWithPageNum:(int)pageNum PageSize:(int)pageSize cityCode:(NSString*)cityCode keyWord:(NSString*)keyWord searchType:(int)searchType userCode:(NSString*)userCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:keyWord forKey:@"keyWord"];
    NSString * userCodeStr = userCode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
    [dic setObject:[NSNumber numberWithInt:searchType] forKey:@"searchType"];
    [dic setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    [dic setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];

    [self postRequestWithUrl:XZGetMasterList parmater:lastDic view:view isOpenHUD:NO Block:^(NSDictionary *data) {
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
    NSString * userCodeStr = userCode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
    
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
-(void)evaluateMasterWithMasterCode:(NSString*)masterCode userCode:(NSString*)userCode content:(NSString*)content cityCode:(NSString*)cityCode masterOrderCode:(NSString *)masterOrderCode serviceAttitude:(NSInteger)serviceAttitude professionalLevel:(NSInteger)professionalLevel view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:masterCode forKey:@"masterCode"];
    NSString * userCodeStr = userCode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
    [dic setObject:content forKey:@"content"];
    [dic setObject:masterOrderCode forKey:@"masterOrderCode"];
    [dic setObject:[NSNumber numberWithInteger:serviceAttitude] forKey:@"serviceAttitude"];
     [dic setObject:[NSNumber numberWithInteger:professionalLevel] forKey:@"professionalLevel"];
    
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
    NSString * userCodeStr = userCode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
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
    
    [self postRequestWithUrl:XZGetLectureList parmater:lastDic view:view isOpenHUD:NO Block:^(NSDictionary *data) {
        NSArray * arr = [[data objectForKey:@"data"]objectForKey:@"list"];
        NSMutableArray * dataArr = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            XZTheMasterModel * model = [XZTheMasterModel modelWithDictionary:arr[i]];
            [dataArr addObject:model];
        }
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:dataArr dataService:self];
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
    
    NSString * masterCodeStr = masterCode?:@"";
    [dic setObject:masterCodeStr forKey:@"lecturesCode"];
    
    NSString * userCodeStr = userCode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZGetLectureDetail parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 话题类型列表

-(void)themeTypeListWithCityCode:(NSString*)cityCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZGetThemeTypeList parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSLog(@"data = %@",data);
        NSArray * arr = [[data objectForKey:@"data"]objectForKey:@"list"];
        NSMutableArray * dataArr = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            XZTheMasterModel * model = [XZTheMasterModel modelWithDictionary:arr[i]];
            [dataArr addObject:model];
        }
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:dataArr dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 话题列表

-(void)themeListWithPageNum:(int)pageNum PageSize:(int)pageSize cityCode:(NSString*)cityCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    [dic setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZGetThemeList parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSArray * arr = [[data objectForKey:@"data"]objectForKey:@"list"];
        NSMutableArray * dataArr = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            XZThemeListModel * model = [XZThemeListModel modelWithDictionary:arr[i]];
            [dataArr addObject:model];
        }
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:dataArr dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 话题详情
-(void)themeDetailWithTopicCode:(NSString*)topicCode userCode:(NSString*)userCode cityCode:(NSString*)cityCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:topicCode forKey:@"topicCode"];
    if (userCode) {
         [dic setObject:userCode forKey:@"userCode"];
    }else{
        [dic setObject:@"" forKey:@"userCode"];
    }

    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZGetThemeDetail parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}


#pragma mark 给大师点赞
-(void)pointOfPraiseMasterWithCityCode:(NSString*)cityCode masterCode:(NSString*)masterCode userCode:(NSString*)userCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:masterCode forKey:@"masterCode"];
    if (userCode) {
        [dic setObject:userCode forKey:@"userCode"];
    }else{
        [dic setObject:@"" forKey:@"userCode"];
    }
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZPointOfPraiseService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
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
