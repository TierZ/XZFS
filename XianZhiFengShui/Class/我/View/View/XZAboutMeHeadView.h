//
//  XZAboutMeHeadView.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

// 我  界面 的头部 
#import <UIKit/UIKit.h>

typedef void(^EditInfoBlock)();
@interface XZAboutMeHeadView : UIView
@property (nonatomic,copy)EditInfoBlock block;
-(void)refreshInfoWithLogin:(BOOL)isLogin;
-(void)editInfoWithBlock:(EditInfoBlock)block;
@end
