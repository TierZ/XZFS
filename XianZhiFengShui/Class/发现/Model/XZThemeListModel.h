//
//  XZThemeListModel.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/21.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

//话题二级分类 cell的model
#import <Foundation/Foundation.h>

@interface XZThemeListModel : NSObject
@property (nonatomic, copy) NSString *id;//话题id
@property (nonatomic, copy) NSString *topicCode;//话题编号（唯一性）

@property (nonatomic, copy) NSString *icon;//头像链接
@property (nonatomic, copy) NSString *issuer;//昵称名字
@property (nonatomic, copy) NSString *issueTime;//时间（xx前）
@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *content;//内容
@property (nonatomic,strong)NSArray * photo;//图片数组
@property (nonatomic, copy) NSString *pointOfPraise;//点赞数
@property (nonatomic, copy) NSString *commentCount;//评论数（暂时弃用）
@property (nonatomic, assign) BOOL isAgree;//是否点赞
@property (nonatomic, assign) BOOL isComment;//是否评论
@property (nonatomic,copy)NSString * comments;//评论内容
@property (nonatomic,copy)NSString * comment;//评论数
@end
