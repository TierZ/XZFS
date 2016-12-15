//
//  ValidateRule.h
//  ShaGuaLiCai
//
//  Created by 李清娟 on 15/12/17.
//  Copyright © 2015年 傻瓜理财. All rights reserved.
//

#import <Foundation/Foundation.h>

#define XZFS_PhoneRule  @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0-9])|(14[0-9]))\\d{8}$"
#define XZFS_VerifyRule  @"^[0-9]{6}$"
#define XZFS_LoginAccount  @"^[.a-zA-Z_0-9-@\u4E00-\u9FA5]{2,32}$"

#define XZFS_PwdRule @"^[.a-zA-Z_0-9-!@#$%&*()]{6,32}$"
#define XZFS_NickRule @"^[a-zA-Z_\u4e00-\u9fa5]{2,16}$"
#define XZFS_EmailRule @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
#define XZFS_RealNameRule @"[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,8})*"
#define XZFS_BankNoRule @"^[0-9]{16,21}$"
#define XZFS_BandAddressRule @"^[A-Za-z0-9\u4E00-\u9FA5_-]+$"
#define XZFS_NumberRule @"^[0-9]+([.]{0,1}[0-9]{0,2}+){0,1}$"
#define XZFS_BankNameRule @"^[~\u4e00-\u9fa5]{4,30}$"
#define XZFS_IdentifyRule @"^(\\d{14}|\\d{17})([0-9]|[xX])$"

#define XZFS_FeedBackContact @"^(((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0-9])|(14[0-9]))\\d{8})|([1-9]\\d{5,9})$"
@interface ValidateRule : NSObject
-(BOOL)validateResultWithView:(id)view;
+ (BOOL)verifyIDCardNumber:(NSString *)value;//验证身份证号
-(BOOL) isValidateMobile:(NSString *)mobile;

@end
