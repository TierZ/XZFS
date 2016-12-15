//
//  XZMasterIntroduce.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/9.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

/**
 成为大师 个人介绍及认证
 */
#import <UIKit/UIKit.h>
#import "XZRegistMasterVC.h"

@interface XZMasterIntroduce : UIScrollView
@property (nonatomic,weak)XZRegistMasterVC * currentVC;
@property (nonatomic,strong)NSMutableDictionary * introduceDic;
- (instancetype)initWithFrame:(CGRect)frame Tags:(NSArray*)tags;
-(BOOL)validateIntroduce;
@end
