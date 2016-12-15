//
//  XZUserCenterService.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/6.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//


typedef NS_ENUM(NSUInteger, XZHomeServiceTag) {
    XZFeedBackTag = 400,
};
#import "BasicService.h"

@interface XZUserCenterService : BasicService

/**
 用户反馈

 @param uid     用户id
 @param content 内容
 @param view    。。
 */
-(void)feedbackWithUid:(NSString*)uid content:(NSString*)content view:(id)view;
@end
