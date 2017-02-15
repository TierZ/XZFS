//
//  CountDownButton.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/2/15.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 倒计时button
 */

@class CountDownButton;
typedef NSString* (^CountDownChanging)(CountDownButton *countDownButton,NSUInteger second);
typedef NSString* (^CountDownFinished)(CountDownButton *countDownButton,NSUInteger second);
typedef void (^TouchedCountDownButtonHandler)(CountDownButton *countDownButton,NSInteger tag);

@interface CountDownButton : UIButton
@property(nonatomic,strong) id userInfo;
///倒计时按钮点击回调
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler;
//倒计时时间改变回调
- (void)countDownChanging:(CountDownChanging)countDownChanging;
//倒计时结束回调
- (void)countDownFinished:(CountDownFinished)countDownFinished;
///开始倒计时
- (void)startCountDownWithSecond:(NSUInteger)second;
///停止倒计时
- (void)stopCountDown;
@end
