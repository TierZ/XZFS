//
//  XZMessageModel.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/1.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZMessageModel : NSObject
@property (nonatomic,copy)NSString * icon;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * time;
@property (nonatomic,copy)NSString * detail;
@property (nonatomic,copy)NSString * content;//二级详情
@property (nonatomic,copy)NSString * contentTime;//二级详情时间
@end
