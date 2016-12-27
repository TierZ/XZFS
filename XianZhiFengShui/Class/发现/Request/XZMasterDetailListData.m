//
//  XZMasterDetailListData.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/27.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterDetailListData.h"
#import "XZMasterInfoModel.h"

static NSString * XZGetMasterArticleList = @"/master/article/list";
static NSString * XZGetArticleDetail = @"/master/article/detail";
@implementation XZMasterDetailListData


#pragma mark 文章列表
-(void)articleListWithMasterCode:(NSString*)masterCode pageNum:(int)pageNum pageSize:(int)pageSize cityCode:(NSString*)cityCode view:(id)view successBlock:(void (^)(NSArray  *data))successBlock failBlock:(void (^)(NSError *error))errorBlock{
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    [dic setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    [dic setObject:masterCode forKey:@"masterCode"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZGetMasterArticleList parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSArray * arr = [[data objectForKey:@"data"]objectForKey:@"list"];
        NSMutableArray * dataArr = [NSMutableArray array];
        for (int i = 0; i<arr.count; i++) {
            XZMasterInfoArticleModel * model = [XZMasterInfoArticleModel modelWithDictionary:arr[i]];
            [dataArr addObject:model];
        }
        if (successBlock) {
            successBlock(dataArr);
        }
    } failBlock:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

#pragma mark 文章详情
-(void)articleDetailWithCityCode:(NSString*)cityCode articleCode:(NSString*)articleCode view:(id)view successBlock:(void (^)(NSDictionary *data))successBlock failBlock:(void (^)(NSError *error))errorBlock{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:articleCode forKey:@"articleCode"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZGetArticleDetail parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSDictionary * dic = [data objectForKey:@"data"];
        if (successBlock) {
            successBlock(dic);
        }
    } failBlock:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

@end
