//
//  XZUserCenterService.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/6.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

static NSString * feedbackService = @"/mine/feedback";
static NSString * MySignUpLectureService = @"/lectures/signUp/list";
static NSString * MyCollectionLectureService = @"/lectures/collection/list";
static NSString * HelpAndFeedbackListService = @"/helpAndFeedback/list";
static NSString * RegistMasterService = @"/master/authentication/toBeMaster";
static NSString * MyMasterService = @"/master/list";

#import "XZUserCenterService.h"
#import "XZTheMasterModel.h"

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
-(void)mySignUpLectureWithUserCode:(NSString*)userCode pageNum:(int)pageNum pageSize:(int)pageSize view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString * userCodeStr = userCode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
    [dic setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    [dic setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:MySignUpLectureService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSLog(@"MySignUpLectureService-------%@",data)
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[[data objectForKey:@"data"] objectForKey:@"list"]dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 我收藏的讲座
-(void)myCollectionLectureWithUserCode:(NSString*)userCode pageNum:(int)pageNum pageSize:(int)pageSize view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString * userCodeStr = userCode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
    [dic setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    [dic setObject:[NSNumber numberWithInt:pageSize] forKey:@"pageSize"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:MyCollectionLectureService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSLog(@"MyCollectionLectureService-------%@",data)
        
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[[data objectForKey:@"data"] objectForKey:@"list"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 帮助与反馈导航列表
-(void)feedbackListWithCityCode:(NSString*)cityCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:cityCode forKey:@"cityCode"];
    
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:HelpAndFeedbackListService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 成为大师

-(void)RegistMasterWithCityCode:(NSString*)cityCode masterCode:(NSString*)masterCode name:(NSString*)name phoneNo:(NSString*)phoneNo email:(NSString*)email city:(NSString*)city company:(NSString*)company position:(NSString*)position nickname:(NSString*)nickname sex:(NSString*)sex title:(NSString*)title summary:(NSString*)summary descr:(NSString*)descr icon:(NSString*)icon serviceType:(NSArray*)serviceType photoList:(NSArray*)photoList idcardList:(NSArray*)idcardList view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:masterCode forKey:@"masterCode"];
    [dic setObject:name forKey:@"name"];
    [dic setObject:phoneNo forKey:@"phoneNo"];
    [dic setObject:email forKey:@"email"];
    [dic setObject:city forKey:@"city"];
    [dic setObject:company forKey:@"company"];
    [dic setObject:position forKey:@"position"];
    [dic setObject:nickname forKey:@"nickname"];
    [dic setObject:sex forKey:@"sex"];
    [dic setObject:title forKey:@"title"];
    [dic setObject:summary forKey:@"summary"];
    [dic setObject:descr forKey:@"descr"];
    [dic setObject:icon forKey:@"icon"];
    [dic setObject:serviceType forKey:@"serviceType"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postAddWithFiles:RegistMasterService parameters:lastDic fileNames:@[@"photoList",@"idcardList1",@"idcardList2",@"idcardList3"] fileDatas:@[photoList[0],idcardList[0],idcardList[1],idcardList[2]] view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
            [self.delegate netSucceedWithHandle:[data objectForKey:@"data"] dataService:self];
        }
        
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 我的大师 （进行中）
-(void)myFinishingMasterWithUserCode:(NSString*)userCode pageNum:(int)pageNum PageSize:(int)PageSize cityCode:(NSString*)cityCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString * userCodeStr = userCode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
     [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:[NSNumber numberWithInteger:2] forKey:@"searchType"];
    [dic setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    [dic setObject:[NSNumber numberWithInt:PageSize] forKey:@"pageSize"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:MyMasterService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSLog(@"我的大师 进行中------%@",data)

        if ([[[data objectForKey:@"data"] objectForKey:@"list"] isKindOfClass:[NSArray class]]) {
            NSArray * array = [[data objectForKey:@"data"] objectForKey:@"list"];
            NSMutableArray * lastArray = [NSMutableArray array];
            for (int i = 0; i<array.count; i++) {
                XZTheMasterModel * model = [XZTheMasterModel modelWithJSON:array[i]];
                model.isFinished = NO;
                [lastArray addObject:model];
            }
            if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
                [self.delegate netSucceedWithHandle:lastArray dataService:self];
            }
        }else{
            NSError * error;
            if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
                [self.delegate netFailedWithHandle:error dataService:self];
            }
            NSLog(@"返回的数据不是数组");
        }

    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 我的大师 （已结束）
-(void)myFinishedMasterWithUserCode:(NSString*)userCode pageNum:(int)pageNum PageSize:(int)PageSize cityCode:(NSString*)cityCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString * userCodeStr = userCode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:[NSNumber numberWithInteger:3] forKey:@"searchType"];
    [dic setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    [dic setObject:[NSNumber numberWithInt:PageSize] forKey:@"pageSize"];
    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:MyMasterService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSLog(@"我的大师 （已结束）-------%@",data)
        
        if ([[[data objectForKey:@"data"] objectForKey:@"list"] isKindOfClass:[NSArray class]]) {
            NSArray * array = [[data objectForKey:@"data"] objectForKey:@"list"];
            NSMutableArray * lastArray = [NSMutableArray array];
            for (int i = 0; i<array.count; i++) {
                XZTheMasterModel * model = [XZTheMasterModel modelWithJSON:array[i]];
                model.isFinished = YES;
                [lastArray addObject:model];
            }
            if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
                [self.delegate netSucceedWithHandle:lastArray dataService:self];
            }
        }else{
            NSError * error;
            if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
                [self.delegate netFailedWithHandle:error dataService:self];
            }
            NSLog(@"返回的数据不是数组");
        }
        
    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];
}

#pragma mark 我的大师 （想约的）
-(void)myWantMasterWithUserCode:(NSString*)userCode pageNum:(int)pageNum PageSize:(int)PageSize cityCode:(NSString*)cityCode view:(id)view{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString * userCodeStr = userCode?:@"";
    [dic setObject:userCodeStr forKey:@"userCode"];
    [dic setObject:[NSNumber numberWithInt:pageNum] forKey:@"pageNum"];
    [dic setObject:[NSNumber numberWithInt:PageSize] forKey:@"pageSize"];
    [dic setObject:cityCode forKey:@"cityCode"];
    [dic setObject:[NSNumber numberWithInteger:4] forKey:@"searchType"];

    NSDictionary * lastDic = [self dataEncryptionWithDic:dic];
    
    [self postRequestWithUrl:MyMasterService parmater:lastDic view:view isOpenHUD:YES Block:^(NSDictionary *data) {
        NSLog(@"我的大师 想约-------%@",data)
        if ([[[data objectForKey:@"data"] objectForKey:@"list"] isKindOfClass:[NSArray class]]) {
            NSArray * array = [[data objectForKey:@"data"] objectForKey:@"list"];
            NSMutableArray * lastArray = [NSMutableArray array];
            for (int i = 0; i<array.count; i++) {
                XZTheMasterModel * model = [XZTheMasterModel modelWithJSON:array[i]];
                [lastArray addObject:model];
            }
            if (self.delegate &&[self.delegate respondsToSelector:@selector(netSucceedWithHandle:dataService:)]) {
                [self.delegate netSucceedWithHandle:lastArray dataService:self];
            }
        }else{
            NSError * error;
            if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
                [self.delegate netFailedWithHandle:error dataService:self];
            }
            NSLog(@"返回的数据不是数组");
        }

    } failBlock:^(NSError *error) {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(netFailedWithHandle:dataService:)]) {
            [self.delegate netFailedWithHandle:error dataService:self];
        }
    }];

}

@end
