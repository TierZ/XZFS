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
    XZHelpAndFeedbackListTag,//帮助反馈导航列表
     XZRegistMasterTag,//成为大师
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
 @param pageNum    页码
 @param pageSize    每页个数
 @param view     。。
 */
-(void)mySignUpLectureWithUserCode:(NSString*)userCode pageNum:(int)pageNum pageSize:(int)pageSize view:(id)view;


/**
 我收藏的讲座列表

 @param userCode 用户id
 @param pageNum    页码
 @param pageSize    每页个数
 @param view     。。
 */
-(void)myCollectionLectureWithUserCode:(NSString*)userCode pageNum:(int)pageNum pageSize:(int)pageSize view:(id)view;

/**
 帮助与反馈导航界面

 @param cityCode 城市代码
 @param view     。。
 */
-(void)feedbackListWithCityCode:(NSString*)cityCode view:(id)view;


/**
 成为大师

 @param cityCode    城市代码
 @param masterCode  大师id（不知干啥用）
 @param name        真实姓名
 @param phoneNo     手机号
 @param email       邮箱
 @param city        城市
 @param company     任职机构
 @param position    职位
 @param nickname    昵称（没乱用）
 @param sex         性别（貌似也没地方写）
 @param title       大师标语（什么鬼）
 @param summary     大师摘要（从哪写）
 @param descr       大师描述（都从哪写）
 @param icon        头像？
 @param serviceType 服务类型 （貌似很复杂）
 @param photoList   照片数组（其实就一张）
 @param idcardList  身份证数组
 @param view        。。
 */
-(void)RegistMasterWithCityCode:(NSString*)cityCode masterCode:(NSString*)masterCode name:(NSString*)name phoneNo:(NSString*)phoneNo email:(NSString*)email city:(NSString*)city company:(NSString*)company position:(NSString*)position nickname:(NSString*)nickname sex:(NSString*)sex title:(NSString*)title summary:(NSString*)summary descr:(NSString*)descr icon:(NSString*)icon serviceType:(NSArray*)serviceType photoList:(NSArray*)photoList idcardList:(NSArray*)idcardList view:(id)view;
@end
