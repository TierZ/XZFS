//
//  ValidateTextField.m
//  ShaGuaLiCai
//
//  Created by 李清娟 on 15/12/18.
//  Copyright © 2015年 傻瓜理财. All rights reserved.
//

#import "ValidateTextField.h"

@implementation ValidateTextField
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.clearButtonMode = UITextFieldViewModeAlways;
    }
    return self;
}

//-(void)setValldataRuleStr:(NSString *)valldataRuleStr{
//    if (valldataRuleStr !=self.valldataRuleStr) {
//        self.valldataRuleStr = valldataRuleStr;
//    }
//
//}
//-(NSString *)valldataRuleStr{
//    return self.valldataRuleStr;
//}
//
//
//-(void)setErrorMsg:(NSString *)errorMsg{
//    if (errorMsg!=self.errorMsg) {
//        self.errorMsg = errorMsg;
//    }
//}
//
//-(NSString *)errorMsg{
//    return  self.errorMsg;
//}
//
//
//-(void)setEmptyMsg:(NSString *)emptyMsg{
//    if (emptyMsg!=self.emptyMsg) {
//        self.emptyMsg = emptyMsg;
//    }
//
//}
//-(NSString *)emptyMsg{
//    return  self.emptyMsg;
//}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
