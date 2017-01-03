//
//  XZLectureDetailData.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/29.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZLectureDetailData.h"

static NSString * XZSignUpLecture = @"/lectures/signUp/sign";
static NSString * XZCollectLecture = @"/lectures/collection/collect";
@implementation XZLectureDetailData
#pragma mark 报名/取消报名 讲座
-(void)signupLectureWithUsercode:(NSString*)usercode lectCode:(NSString*)lectCode type:(NSString*)type view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString * userCodeStr = usercode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
    [dic setObject:lectCode forKey:@"lectCode"];
     [dic setObject:type forKey:@"type"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    [self postRequestWithUrl:XZSignUpLecture parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:data dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 收藏/取消收藏 讲座
-(void)collectLectureWithUsercode:(NSString*)usercode lectCode:(NSString*)lectCode type:(NSString*)type view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString * userCodeStr = usercode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
    [dic setObject:lectCode forKey:@"lectCode"];
    [dic setObject:type forKey:@"type"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:XZCollectLecture parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:data dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}
@end
