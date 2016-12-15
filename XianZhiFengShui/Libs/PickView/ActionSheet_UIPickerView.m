//
//  ActionSheet_UIPickerView.m
//  UIActionSheet
//
//  Created by 李帅 on 16/3/23.
//  Copyright © 2016年 漠然丶情到深处. All rights reserved.
//

#import "ActionSheet_UIPickerView.h"
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface ActionSheet_UIPickerView(){
    UIColor *toolBarColor;
    UIColor *textColorNormal;
    UIColor *textColorPressed;
    UIColor *pickerBgColor;
}
@end

@implementation ActionSheet_UIPickerView

+ (instancetype)styleDefault {
    ActionSheet_UIPickerView *sheet = [[ActionSheet_UIPickerView alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height)];
    
    [sheet setBackgroundColor:[UIColor clearColor]];
    sheet.toolBar = [sheet actionToolBar];
    sheet.pickerView = [sheet actionPicker];
    [sheet addSubview:sheet.toolBar];
    [sheet addSubview:sheet.pickerView];
    
    return sheet;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        toolBarColor = XZFS_HEX_RGB(@"#f9f9f9");
        textColorNormal = XZFS_HEX_RGB(@"#0077ff");
        textColorPressed = RGBACOLOR(209.0, 213.0, 219.0, 0.9);
        pickerBgColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupInitPostion:(UIViewController *)controller {
    [UIApplication.sharedApplication.keyWindow?UIApplication.sharedApplication.keyWindow:UIApplication.sharedApplication.windows[0] addSubview:self];
    [self.superview bringSubviewToFront:self];
    CGFloat pickerViewYpositionHidden = UIScreen.mainScreen.bounds.size.height;
    [self.pickerView setFrame:CGRectMake(self.pickerView.frame.origin.x,pickerViewYpositionHidden,SCREENWIDTH,self.pickerView.frame.size.height)];
    [self.toolBar setFrame:CGRectMake(self.toolBar.frame.origin.x,pickerViewYpositionHidden,SCREENWIDTH,self.toolBar.frame.size.height)];
}

//弹出 ActionSheet
- (void)show:(UIViewController *)controller {
    [self setupInitPostion:controller];
    
    CGFloat toolBarYposition = UIScreen.mainScreen.bounds.size.height - (self.pickerView.frame.size.height + self.toolBar.frame.size.height);
    [UIView animateWithDuration:0.25f animations:^{
        [self setBackgroundColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.5]];
        [controller.view setTintAdjustmentMode:UIViewTintAdjustmentModeDimmed];
        [controller.navigationController.navigationBar setTintAdjustmentMode:UIViewTintAdjustmentModeDimmed];
        
        [self.toolBar setFrame:CGRectMake(self.toolBar.frame.origin.x,toolBarYposition,SCREENWIDTH,self.toolBar.frame.size.height)];
        [self.pickerView setFrame:CGRectMake(self.pickerView.frame.origin.x,toolBarYposition+self.toolBar.frame.size.height,SCREENWIDTH,self.pickerView.frame.size.height)];
    } completion:nil];
}

//收回 ActionSheet
- (void)dismiss:(UIViewController *)controller {
    [UIView animateWithDuration:0.25f animations:^{
        [self setBackgroundColor:[UIColor clearColor]];
        [controller.view setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
        [controller.navigationController.navigationBar setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
        [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIView* v = (UIView*)obj;
            [v setFrame:CGRectMake(v.frame.origin.x,UIScreen.mainScreen.bounds.size.height,v.frame.size.width,v.frame.size.height)];
        }];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (UIView *)actionToolBar {
    UIView *tools = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44)];
    tools.backgroundColor = toolBarColor;
    UIButton *cancle = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    [cancle setTitleColor:textColorPressed forState:UIControlStateHighlighted];
    [cancle setTitleColor:textColorNormal forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(actionCancle) forControlEvents:UIControlEventTouchUpInside];
    [cancle sizeToFit];
    [tools addSubview:cancle];
    
    cancle.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *cancleConstraintLeft = [NSLayoutConstraint constraintWithItem:cancle attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:tools attribute:NSLayoutAttributeLeading multiplier:1.0f constant:10.0f];
    NSLayoutConstraint *cancleConstrainY = [NSLayoutConstraint constraintWithItem:cancle attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:tools attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
    [tools addConstraint:cancleConstraintLeft];
    [tools addConstraint:cancleConstrainY];
    
    UIButton *ok = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [ok setTitle:@"确定" forState:UIControlStateNormal];
    [ok setTitleColor:textColorNormal forState:UIControlStateNormal];
    [ok setTitleColor:textColorPressed forState:UIControlStateHighlighted];
    [ok addTarget:self action:@selector(actionDone) forControlEvents:UIControlEventTouchUpInside];
    [ok sizeToFit];
    [tools addSubview:ok];
    
    ok.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *okConstraintRight = [NSLayoutConstraint constraintWithItem:ok attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:tools attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-10.0f];
    NSLayoutConstraint *okConstraintY = [NSLayoutConstraint constraintWithItem:ok attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:tools attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
    [tools addConstraint:okConstraintRight];
    [tools addConstraint:okConstraintY];
    
    return tools;
}

- (UIPickerView *)actionPicker {
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 250)];
    picker.showsSelectionIndicator = YES;
    [picker setBackgroundColor:pickerBgColor];
    
    return picker;
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)anime {
    [_pickerView selectRow:row inComponent:component animated:anime];
}

- (NSInteger)selectedRowInComponent:(NSInteger)component {
    return [_pickerView selectedRowInComponent:component];
}

- (void)actionDone {
    if([_delegate respondsToSelector:@selector(actionDoneWithPick:)]){
        [_delegate actionDoneWithPick:self.pickerView];
    }
}

- (void)actionCancle {
    if ([_delegate respondsToSelector:@selector(actionCancleWithPick:)]) {
        [_delegate actionCancleWithPick:self.pickerView];
    }
}

- (void)setDelegate:(id<ActionSheet_UIPickerViewDelegate>)delegate {
    _delegate = delegate;
    _pickerView.delegate = delegate;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
