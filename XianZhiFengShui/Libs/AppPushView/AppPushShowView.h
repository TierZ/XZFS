//
//  AppPushShowView.h
//  ShaGuaLiCai
//
//  Created by 李清娟 on 16/2/1.
//  Copyright © 2016年 YangShangJie. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^appPushBlock)();
@interface AppPushShowView : UIView
@property (nonatomic,copy)appPushBlock block;
-(instancetype)initWithFrame:(CGRect)frame title:(NSString*)title;
-(void)show;
-(void)appPushWithBlock:(appPushBlock)block;
@end
