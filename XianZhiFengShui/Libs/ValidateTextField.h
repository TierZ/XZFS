//
//  ValidateTextField.h
//  ShaGuaLiCai
//
//  Created by 李清娟 on 15/12/18.
//  Copyright © 2015年 傻瓜理财. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ValidateTextField : UITextField
@property (nonatomic,copy)NSString * valldataRuleStr;
@property (nonatomic,copy)NSString * errorMsg;
@property (nonatomic,copy)NSString * emptyMsg;
@end
