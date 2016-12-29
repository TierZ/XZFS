//
//  XZUserCenterService.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/6.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

static NSString * feedbackService = @"/feedback/feedback";
static NSString * MySignUpLectureService = @"/lectures/signUp/list";
static NSString * MyCollectionLectureService = @"/lectures/collection/list";


#import "XZUserCenterService.h"

@implementation XZUserCenterService

#pragma mark 用户反馈
-(void)feedbackWithUid:(NSString*)usercode email:(NSString*)email content:(NSString*)content view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString * userCodeStr = usercode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
    [dic setObject:content forKey:@"content"];
    [dic setObject:email forKey:@"email"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:feedbackService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 我报名的讲座
-(void)mySignUpLectureWithUserCode:(NSString*)userCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString * userCodeStr = userCode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:MySignUpLectureService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSLog(@"MySignUpLectureService-------%@",data)
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 我收藏的讲座
-(void)myCollectionLectureWithUserCode:(NSString*)userCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString * userCodeStr = userCode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:MyCollectionLectureService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSLog(@"MyCollectionLectureService-------%@",data)
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
