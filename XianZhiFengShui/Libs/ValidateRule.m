//
//  ValidateRule.m
//  ShaGuaLiCai
//
//  Created by 李清娟 on 15/12/17.
//  Copyright © 2015年 傻瓜理财. All rights reserved.
//

#import "ValidateRule.h"
#import "ValidateTextField.h"

@implementation ValidateRule{
    NSMutableArray * validateTfArray ;
    NSMutableArray * validateArr;
}




- (instancetype)init
{
    self = [super init];
    if (self) {
        validateArr = [NSMutableArray array];
        validateTfArray = [NSMutableArray array];
    }
    return self;
}
/**
 *  判断手机号是否正确
 *
 *  @param mobile 手机号
 *
 *  @return 返回是否正确
 */
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = XZFS_PhoneRule;
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    NSLog(@"phoneTest is %@",phoneTest);
    BOOL isOk = [phoneTest evaluateWithObject:mobile];
    if (!isOk) {
        [ToastManager showToastOnView:[UIApplication sharedApplication].keyWindow position:CSToastPositionCenter flag:NO message:@"手机号格式不正确"];
    }
    return isOk;
}

/**
 *  判断密码是否合理
 *
 *  @param password 密码
 *
 *  @return 返回是否正确
 */
-(BOOL) isValidatePasswod:(NSString *)password
{
    
    NSString * passwordRegex = @"^[.a-zA-Z_0-9-!@#$%&*()]{6,32}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegex];
    NSLog(@"phoneTest is %@",passwordTest);
    return [passwordTest evaluateWithObject:password];
}

/**
 *  判断邮箱
 *
 *  @param email email地址
 *
 *
 */
+ (BOOL) validateEmail:(NSString *)email

{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

/**
 *  验证昵称是否合理
 *
 *  @param nickName 昵称
 *
 *  @return YES&NO
 */
+ (BOOL) validateNickName:(NSString *)nickName

{
    //    preg_match("/^[\x{4e00}-\x{9fa5}a-zA-Z_]{2,16}$/u", $data);
    //    ^[a-zA-Z_\u4e00-\u9fa5]{2,16}$
    NSString *nickNameRegex = @"^[a-zA-Z_\u4e00-\u9fa5]{2,16}$";
    
    NSPredicate *nickTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nickNameRegex];
    
    return [nickTest evaluateWithObject:nickName];
}

/**
 *  验证身份证号
 *
 *  @param value 身份证号
 *
 *  @return 是否正确
 */
+ (BOOL)verifyIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}



#pragma mark  通用正则方法

/**
 *  递归view 找到textfield 放到数组中
 *
 *  @param views 需要循环的view
 *
 *  @return 返回一个数组
 */
- (NSArray *)vv:(NSArray *)views
{

    [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[ValidateTextField class]] ){
            [validateArr addObject:obj];
        }else{
            [self vv:[obj subviews]];
        }
    }];
    return validateArr;
}


-(BOOL)validateResultWithView:(id)view{
    
    
    if ([view isKindOfClass:[UIView class]]) {
        validateTfArray  = [NSMutableArray arrayWithArray:[self vv:[view subviews]]] ;
    }else{
        return NO;
    }
    
    BOOL result = YES;
    for (int i = 0; i<validateTfArray.count; i++) {
        ValidateTextField * validateTf = validateTfArray[i];
        NSString * text = validateTf.text;
        NSString * emptyMsg = validateTf.emptyMsg;
        NSString * errorMsg = validateTf.errorMsg;
        NSString * validateRule = validateTf.valldataRuleStr;
        BOOL checked = NO;
        CSToastStyle* cs = [[CSToastStyle alloc]initWithDefaultStyle];
        cs.imageSize = CGSizeMake(13, 13);
        cs.messageFont =  XZFS_S_FONT(13);
        cs.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        cs.horizontalPadding = 50;
        cs.verticalPadding = 10;
        cs.messageAlignment = NSTextAlignmentCenter;
        cs.maxWidthPercentage = 0.9;
        if (text.length<=0&&emptyMsg.length>0) {
//            [view makeToast:emptyMsg duration:2 position:CSToastPositionCenter style:nil];
//             [view makeToast:emptyMsg duration:2 position:CSToastPositionCenter title:nil image:[UIImage imageNamed:@"bounced_icon_fail"] style:cs completion:nil];
            [ToastManager showToastOnView:view position:CSToastPositionCenter flag:NO message:emptyMsg];
            return NO;
        }
        
        checked = [self validateRuleWithText:text rule:validateRule];
        result = checked&&result;
        if (!result) {
//             [view makeToast:errorMsg duration:2 position:CSToastPositionCenter title:nil image:[UIImage imageNamed:@"bounced_icon_fail"] style:cs completion:nil];
            [ToastManager showToastOnView:view position:CSToastPositionCenter flag:NO message:errorMsg];

            break;
        }
    }
    return result;
    
}

- (BOOL) validateRuleWithText:(NSString *)text rule:(NSString *)rule

{
    //    preg_match("/^[\x{4e00}-\x{9fa5}a-zA-Z_]{2,16}$/u", $data);
    //    ^[a-zA-Z_\u4e00-\u9fa5]{2,16}$
    NSString *regex = rule;
    
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [test evaluateWithObject:text];
}
@end
