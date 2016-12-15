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
@property (nonatomic, copy) NSString *photo;//头像链接
@property (nonatomic, copy) NSString *name;//名字
@property (nonatomic, copy) NSString *time;//时间（xx前）
@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *content;//内容
@property (nonatomic,strong)NSArray * picArray;//图片数组
@property (nonatomic, copy) NSString *agreeCount;//点赞数
@property (nonatomic, copy) NSString *commentCount;//评论数
@property (nonatomic, assign) BOOL isAgree;//是否点赞
@property (nonatomic, assign) BOOL isComment;//是否评论
@property (nonatomic,copy)NSString * comments;//评论内容
@end
