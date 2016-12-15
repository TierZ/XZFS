//
//  XZMasterBasicInfo.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/9.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//
/**
 成为大师 填写基本信息
 */
#import <UIKit/UIKit.h>


@interface XZMasterBasicInfo : UIScrollView
@property (nonatomic,strong)NSMutableDictionary * itemsDic;
-(BOOL)validateTfInfo;
@end
