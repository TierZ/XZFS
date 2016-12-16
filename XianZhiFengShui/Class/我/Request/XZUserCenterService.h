//
//  XZUserCenterService.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/6.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//


typedef NS_ENUM(NSUInteger, XZUserCenterServiceTag) {
    XZFeedBackTag = 400,
};
#import "BasicService.h"

@interface XZUserCenterService : BasicService

/**
 用户反馈

 @param usercode     用户id
 @param content 内容
 @param email 邮箱
 @param view    。。
 */
-(void)feedbackWithUid:(NSString*)usercode email:(NSString*)email content:(NSString*)content view:(id)view;
@end
