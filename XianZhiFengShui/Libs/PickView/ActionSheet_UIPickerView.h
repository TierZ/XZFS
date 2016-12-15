//
//  ActionSheet_UIPickerView.h
//  UIActionSheet
//
//  Created by 李帅 on 16/3/23.
//  Copyright © 2016年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActionSheet_UIPickerViewDelegate <UIPickerViewDelegate>

//点击取消的回调接口
-(void)actionCancleWithPick:(UIPickerView*)pick;

//点击确定的回调接口
-(void)actionDoneWithPick:(UIPickerView*)pick;

@end

@interface ActionSheet_UIPickerView : UIView

@property(assign, nonatomic) id<ActionSheet_UIPickerViewDelegate> delegate;
@property(strong, nonatomic)UIView* toolBar;
@property(strong, nonatomic)UIPickerView* pickerView;

+ (instancetype)styleDefault;

//弹出
- (void)show:(UIViewController *)controller;

//收回
- (void)dismiss:(UIViewController *)controller;

//选中指定的行列
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)anime;

//获取被选中的行列
- (NSInteger)selectedRowInComponent:(NSInteger)component;

@end
