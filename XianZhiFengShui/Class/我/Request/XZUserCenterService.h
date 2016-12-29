//
//  XZUserCenterService.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/6.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//


typedef NS_ENUM(NSUInteger, XZUserCenterServiceTag) {
    XZFeedBackTag = 400,
    XZMySignupLectureTag,//我报名的讲座列表
    XZMyCollectionLectureTag,//我收藏的讲座列表
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


/**
 我报名的讲座列表

 @param userCode 用户id
 @param view     。。
 */
-(void)mySignUpLectureWithUserCode:(NSString*)userCode view:(id)view;


/**
 我收藏的讲座列表

 @param userCode 用户id
 @param view     。。
 */
-(void)myCollectionLectureWithUserCode:(NSString*)userCode view:(id)view;
@end
