//
//  XZMasterDetailInfo.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//


// 大师详情界面 大师介绍

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, HeaderDetailStyle) {
    MasterHeaderDetail,
    LectureHeaderDetail,
    OtherHeaderDetail,
};
@interface XZMasterDetailInfo : UIView
- (instancetype)initWithFrame:(CGRect)frame style:(HeaderDetailStyle)style;
-(void)refreshInfoWithDic:(NSDictionary*)dic;
@end
