//
//  XZTheMasterView.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/11.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

//大师 列表

//大师 分类筛选
typedef enum : NSUInteger {
    MasterHot = 0,//最热
    MasterLocal,//本地
    MasterAll,//所有
    MasterOther,//其他
} MasterSelect;

#import <UIKit/UIKit.h>
#import "XZFindService.h"
@class  UIViewController;
@interface XZTheMasterView : UIView<UIScrollViewDelegate,DataReturnDelegate>
-(instancetype)initWithFrame:(CGRect)frame curVC:(UIViewController*)vc;
@property (nonatomic,assign)MasterSelect style;
@property (nonatomic,weak)UIViewController* curVC;
@end
