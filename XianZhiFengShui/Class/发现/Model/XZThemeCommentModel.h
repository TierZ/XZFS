//
//  XZThemeCommentModel.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/27.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

/**
 话题评论model
 */

#import <Foundation/Foundation.h>

@interface XZThemeCommentModel : NSObject
@property (nonatomic,copy)NSString * avatar;//头像
@property (nonatomic,copy)NSString * name;//名称
@property (nonatomic,copy)NSString * time;//时间
@property (nonatomic,copy)NSString * comment;//评论数
@property (nonatomic,copy)NSString * agree;//点赞数
@property (nonatomic,copy)NSString * content;//评论内容
@end
