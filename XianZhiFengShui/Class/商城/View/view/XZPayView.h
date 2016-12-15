//
//  XZPayView.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectPayStyleBlock)();
@interface XZPayView : UIView
@property (nonatomic,copy)SelectPayStyleBlock block;
-(void)selectPayWithBlock:(SelectPayStyleBlock)block;
@end
