//
//  XZMasterInfoModel.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

//大师详情model
#import <Foundation/Foundation.h>

#pragma mark 大师服务项目
@interface XZMasterInfoServiceModel:NSObject
@property (nonatomic,copy)NSString * serviceName;//服务名称
@property (nonatomic,copy)NSString * serviceContent;//服务内容
@property (nonatomic,copy)NSString * servicePrice;//服务价格
@property (nonatomic,assign)BOOL  isAppointment;//是否预约
@end

#pragma mark 大师文章
@interface XZMasterInfoArticleModel:NSObject
@property (nonatomic,copy)NSString * articleTitle;//文章名称
@property (nonatomic,copy)NSString * articleDetail;//文章简介
@end

#pragma mark 大师详情
@interface XZMasterInfoDetailModel:NSObject
@property (nonatomic,copy)NSString * masterDetail;//关于大师
@end

#pragma mark 客户评价
@interface XZMasterInfoEvaluateModel:NSObject
@property (nonatomic,copy)NSString * evaluateAvatar;//客户头像
@property (nonatomic,copy)NSString * evaluateName;//客户名称
@property (nonatomic,copy)NSString * evaluateContent;//评价内容
@property (nonatomic,copy)NSString * evaluateTime;//评价时间
@end
