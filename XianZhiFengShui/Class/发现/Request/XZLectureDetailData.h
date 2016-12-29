//
//  XZLectureDetailData.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/29.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "BasicService.h"

typedef NS_ENUM(NSUInteger, XZLectureDetailListTag) {//讲座详情内
    XZLectureSignUp = 260,//讲座报名
    XZLectureCollection,//讲座收藏
};

/**
 讲座相关
 */
@interface XZLectureDetailData : BasicService

/**
 报名/取消报名

 @param usercode 用户id
 @param lectCode 讲座id
 @param type     类型  1：报名 0：取消报名
 @param view     。。
 */
-(void)signupLectureWithUsercode:(NSString*)usercode lectCode:(NSString*)lectCode type:(NSString*)type view:(id)view;


/**
 收藏/取消收藏 讲座

 @param usercode 用户id
 @param lectCode 讲座id
 @param type     类型  1：收藏讲座 0：取消收藏
 @param view     。。
 */
-(void)collectLectureWithUsercode:(NSString*)usercode lectCode:(NSString*)lectCode type:(NSString*)type view:(id)view;
@end
