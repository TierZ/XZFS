//
//  XZThemeDetailData.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/3.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

static NSString * XZComfirmTopicService = @"/topic/issue/confirm";


#import "XZThemeDetailData.h"

@implementation XZThemeDetailData
#pragma mark 发表话题
-(void)confirmTopicWithCityCode:(NSString*)cityCode userCode:(NSString*)userCode title:(NSString*)title content:(NSString*)content typeCode:(NSString*)typeCode picList:(NSArray*)picList view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:userCode forKey:@"userCode"];
    [dic setObject:title forKey:@"title"];
    [dic setObject:content forKey:@"content"];
    [dic setObject:typeCode forKey:@"typeCode"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    NSArray * piclist = picList?:@[];
    [self postAddFiles:XZComfirmTopicService parameters:lastDic fileName:@"confirmTopic" fileDatas:piclist view:view isOpenHUD:YES Block:^(NSDictionary *data) {
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
