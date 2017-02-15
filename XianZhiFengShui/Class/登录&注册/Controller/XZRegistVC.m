//
//  XZRegistVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/10.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZRegistVC.h"
#import "ValidateTextField.h"
#import "ValidateRule.h"
#import "XZLoginRegistService.h"
#import "UIButton+XZImageTitleSpacing.h"
#import "JMessage.framework/Headers/JMessage.h"
#import "JCHATStringUtils.h"

#import "CountDownButton.h"

@interface XZRegistVC ()
@property (nonatomic,strong)UIButton * leftArrow;
@property (nonatomic,strong)UIImageView * userNoIv;
@property (nonatomic,strong)UIImageView * userPwdIv;
@property (nonatomic,strong)UIImageView * userNickIv;
@property (nonatomic,strong)ValidateTextField * userNoTf;
@property (nonatomic,strong)ValidateTextField  * userPwdTf;
@property (nonatomic,strong)ValidateTextField  * userNickTf;
@property (nonatomic,strong)ValidateTextField  * codeTf;
@property (nonatomic,strong)UIButton * registBtn;
@property (nonatomic,strong)CountDownButton * sendCodeBtn;
@property (nonatomic,strong)UIButton * agreeProtocalBtn;
@property (nonatomic,strong)UILabel * agreeProtocalLab;
@property (nonatomic,strong)UIButton * protocalBtn;
@property (nonatomic,strong)NSString * securityCode;
@property (nonatomic,strong)NSTimer * timer;

@end

@implementation XZRegistVC{
    int _countDownInt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
    self.navView.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.mainView.hidden = YES;
    _countDownInt = 59;
    [self countDownBtnAction];
}

-(void)layoutViews{
    [self.view addSubview:self.leftArrow];
    [self.view addSubview:self.userNoIv];
    [self.view addSubview:self.userPwdIv];
    [self.view addSubview:self.userNickIv];
    [self.view addSubview:self.userNoTf];
    [self.view addSubview:self.userPwdTf];
    [self.view addSubview:self.userNickTf];
    [self.view addSubview:self.codeTf];
    [self.view addSubview:self.sendCodeBtn];
    [self.view addSubview:self.registBtn];
    [self.view addSubview:self.agreeProtocalBtn];
    [self.view addSubview:self.agreeProtocalLab];
    [self.view addSubview:self.protocalBtn];
    
    self.leftArrow.frame = CGRectMake(20, 70, 80, 24);
    self.userNoIv.frame = CGRectMake(33, self.leftArrow.bottom+110, 16, 20);
    self.userPwdIv.frame =CGRectMake(33, self.userNoIv.bottom+40, 16, 20);
    self.userNickIv.frame =CGRectMake(33, self.userPwdIv.bottom+40, 16, 20);
    self.userNoTf.frame = CGRectMake(self.userNoIv.right+17, self.userNoIv.top+3, SCREENWIDTH-(self.userNoIv.right+17)-20, 17);
    self.userPwdTf.frame = CGRectMake(self.userPwdIv.right+17, self.userPwdIv.top+4, 200, 16);
    self.userNickTf.frame = CGRectMake(self.userPwdIv.right+17, self.userNickIv.top+4, 200, 16);
    self.codeTf.frame = CGRectMake(self.userPwdIv.left, self.userNickTf.bottom+44, 200, 16);
    
    self.sendCodeBtn.frame = CGRectMake(SCREENWIDTH-20-80, self.codeTf.top-9, 80, 24);
    self.registBtn.frame = CGRectMake(20, self.codeTf.bottom+30, SCREENWIDTH-40, 45);
    self.agreeProtocalBtn.frame = CGRectMake(30, self.registBtn.bottom+8, 12, 12);
    self.agreeProtocalLab.frame = CGRectMake(self.agreeProtocalBtn.right+5, self.registBtn.bottom+8, 80, 12);
    [self.agreeProtocalLab sizeToFit];
    self.protocalBtn.frame = CGRectMake(self.agreeProtocalLab.right+2, self.registBtn.bottom+8, 78, 12);
    
    for (int i = 0; i<4; i++) {
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, self.userNoIv.bottom+5+i*60, SCREENWIDTH-40, 0.5)];
        line.backgroundColor = XZFS_HEX_RGB(@"#C9C9CA");
        [self.view addSubview:line];
    }
}
-(void)countDownBtnAction{
    
    __weak typeof(self)weakSelf = self;
    [_sendCodeBtn countDownButtonHandler:^(CountDownButton*sender, NSInteger tag) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.userNoTf resignFirstResponder];
        [strongSelf.userPwdTf resignFirstResponder];
        [strongSelf.userNickTf resignFirstResponder];
        
        ValidateRule * rule = [[ValidateRule alloc]init];
        BOOL isValidate = [rule isValidateMobile:strongSelf.userNoTf.text];
        if (isValidate) {
        [strongSelf sendSecurityCodeWithPhone:strongSelf.userNoTf.text];
            NSLog(@"发送验证码");
        }
    }];
}


#pragma mark action
-(void)clickLeft:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)regist{
    ValidateRule * rule = [[ValidateRule alloc]init];
    BOOL isValidate = [rule validateResultWithView:self.view];
    if (isValidate) {
        if ([self.codeTf.text isEqualToString:self.securityCode]) {
            [self registAccount];
        }else{
            [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:NO message:@"验证码不正确"];
        }
    }
    NSLog(@"去注册");
}

-(void)agreeProtocal{
    NSLog(@"同意协议");
}

-(void)showProtocal{
    NSLog(@"展示协议");
}

#pragma mark 网络

/**
 请求验证码
 
 @param phoneNum 手机号
 */
-(void)sendSecurityCodeWithPhone:(NSString*)phoneNum{
    XZLoginRegistService * securityService = [[XZLoginRegistService alloc]initWithServiceTag:XZGetSecurityTag];
    securityService.delegate = self;
    [securityService requestSecurityCodeWithPhoneNo:phoneNum cityCode:@"110000" type:@"1" view:self.view];
}


/**
 注册
 */
-(void)registAccount{
    XZLoginRegistService * registService = [[XZLoginRegistService alloc]initWithServiceTag:XZRegistTag];
    registService.delegate = self;
    [registService registWithMobilePhone:self.userNoTf.text password:self.userPwdTf.text nickName:self.userNickTf.text cityCode:@"11000" view:self.view];
    
}

//回调
-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    XZLoginRegistService * currentService = (XZLoginRegistService*)service;
    switch (currentService.serviceTag) {
        case XZGetSecurityTag:{
            NSDictionary * dic = (NSDictionary*)succeedHandle;
            NSDictionary * data = [dic objectForKey:@"data"];
            self.securityCode = [data objectForKey:@"vcode"];
            NSLog(@"successHandle = %@",succeedHandle);
            
            [_sendCodeBtn setTitleColor:XZFS_TEXTLIGHTGRAYCOLOR forState:UIControlStateNormal];
            _sendCodeBtn.layer.borderColor = XZFS_TEXTLIGHTGRAYCOLOR.CGColor;
            
            _sendCodeBtn.enabled = NO;
            [_sendCodeBtn startCountDownWithSecond:60];
            [_sendCodeBtn countDownChanging:^NSString *(CountDownButton *countDownButton,NSUInteger second) {
                NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                return title;
            }];
            [_sendCodeBtn countDownFinished:^NSString *(CountDownButton *countDownButton, NSUInteger second) {
                countDownButton.enabled = YES;
                [countDownButton setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
                countDownButton.layer.borderColor = XZFS_TEXTORANGECOLOR.CGColor;
                return @"点击重新获取";
            }];
        }
            break;
        case XZRegistTag:{
            NSDictionary * dic = (NSDictionary*)succeedHandle;
            NSDictionary * data = [dic objectForKey:@"data"];
            if ([[dic objectForKey:@"statusCode"]isEqualToString:@"200"]) {
                if ([[data objectForKey:@"affect"]intValue]>0) {
                    [JMSGUser registerWithUsername:KISDictionaryHaveKey(data, @"userCode") password:KISDictionaryHaveKey(data, @"userCode") completionHandler:^(id resultObject, NSError *error) {
                        if (error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                            });
                            [MBProgressHUD showMessage:[JCHATStringUtils errorAlert:error] view:self.view];
                        }else{
                            [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:YES message:@"注册成功"];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [self.navigationController popViewControllerAnimated:YES];
                            });
                            
                        }
                    }];
                    
                }
            }
        }
            break;
            
        default:
            break;
    }
}

-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{
      XZLoginRegistService * currentService = (XZLoginRegistService*)service;
    switch (currentService.serviceTag) {
        case XZGetSecurityTag:{
            NSError * error = (NSError*)failHandle;
            if (error.code==508) {
                NSLog(@"已注册");
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark getter
-(UIButton *)leftArrow{
    if (!_leftArrow) {
        if (!_leftArrow) {
            _leftArrow = [UIButton buttonWithType:UIButtonTypeCustom];
            [_leftArrow setImage:XZFS_IMAGE_NAMED(@"zuojiantou") forState:UIControlStateNormal];
            [_leftArrow setTitle:@"注册" forState:UIControlStateNormal];
            [_leftArrow setTitleColor:XZFS_HEX_RGB(@"#000000") forState:UIControlStateNormal];
            _leftArrow.titleLabel.font =  XZFS_S_FONT(18);
            [_leftArrow layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:20];
            [_leftArrow addTarget:self action:@selector(clickLeft:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _leftArrow;
}

-(UIImageView *)userNoIv{
    if (!_userNoIv) {
        _userNoIv = [[UIImageView alloc]init];
        _userNoIv.image = XZFS_IMAGE_NAMED(@"zhanghao");
    }
    return _userNoIv;
}
-(UIImageView *)userPwdIv{
    if (!_userPwdIv) {
        _userPwdIv = [[UIImageView alloc]init];
        _userPwdIv.image = XZFS_IMAGE_NAMED(@"mima");
    }
    return _userPwdIv;
}
-(UIImageView *)userNickIv{
    if (!_userNickIv) {
        _userNickIv = [[UIImageView alloc]init];
        _userNickIv.image = XZFS_IMAGE_NAMED(@"nicheng");
    }
    return _userNickIv;
}

-(ValidateTextField *)userNoTf{
    if (!_userNoTf) {
        _userNoTf = [[ValidateTextField alloc]initWithFrame:CGRectMake(14, 15, SCREENWIDTH-14, 15)];
        _userNoTf.placeholder = @"请输入手机号";
        _userNoTf.errorMsg = @"账号格式不正确";
        _userNoTf.emptyMsg = @"账号不能为空";
        _userNoTf.valldataRuleStr = XZFS_LoginAccount;
        _userNoTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNoTf.font = XZFS_S_FONT(15);
        _userNoTf.textColor = XZFS_RGB(149, 149, 149);
        _userNoTf.textAlignment = NSTextAlignmentLeft;
        _userNoTf.keyboardType = UIKeyboardTypeNumberPad;
        //        [_userPhoneTf becomeFirstResponder];
    }
    return _userNoTf;
}

-(ValidateTextField *)userPwdTf{
    if (!_userPwdTf) {
        _userPwdTf = [[ValidateTextField alloc]initWithFrame:CGRectMake(14, 15, SCREENWIDTH-14, 15)];
        _userPwdTf.placeholder = @"请输入不少于6个字符密码";
        _userPwdTf.errorMsg = @"密码格式不正确";
        _userPwdTf.emptyMsg = @"密码不能为空";
        _userPwdTf.valldataRuleStr = XZFS_PwdRule;
        _userPwdTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userPwdTf.secureTextEntry = YES;
        _userPwdTf.font = XZFS_S_FONT(15);
        _userPwdTf.textColor = XZFS_RGB(149, 149, 149);
        _userPwdTf.textAlignment = NSTextAlignmentLeft;
        //        _userPhoneTf.keyboardType = UIKeyboardTypeNumberPad;
        //        [_userPhoneTf becomeFirstResponder];
    }
    return _userPwdTf;
}

-(ValidateTextField *)userNickTf{
    if (!_userNickTf) {
        _userNickTf = [[ValidateTextField alloc]initWithFrame:CGRectMake(14, 15, SCREENWIDTH-14, 15)];
        _userNickTf.placeholder = @"请输入您的昵称";
        _userNickTf.errorMsg = @"昵称格式不正确";
        _userNickTf.emptyMsg = @"昵称不能为空";
        _userNickTf.valldataRuleStr = XZFS_NickRule;
        _userNickTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNickTf.font = XZFS_S_FONT(15);
        _userNickTf.textColor = XZFS_RGB(149, 149, 149);
        _userNickTf.textAlignment = NSTextAlignmentLeft;
    }
    return _userNickTf;
}

-(ValidateTextField *)codeTf{
    if (!_codeTf) {
        _codeTf = [[ValidateTextField alloc]initWithFrame:CGRectMake(14, 15, SCREENWIDTH-14, 15)];
        _codeTf.placeholder = @"请输入验证码";
        _codeTf.errorMsg = @"验证码格式不正确";
        _codeTf.emptyMsg = @"验证码不能为空";
        _codeTf.valldataRuleStr = XZFS_NumberRule;
        _codeTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTf.font = XZFS_S_FONT(15);
        _codeTf.textColor = XZFS_RGB(149, 149, 149);
        _codeTf.textAlignment = NSTextAlignmentLeft;
        _codeTf.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _codeTf;
}

-(CountDownButton *)sendCodeBtn{
    if (!_sendCodeBtn) {
        _sendCodeBtn = [CountDownButton buttonWithType:UIButtonTypeCustom];
        [_sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_sendCodeBtn setTitleColor:XZFS_HEX_RGB(@"#eb6000") forState:UIControlStateNormal];
        _sendCodeBtn.backgroundColor = XZFS_HEX_RGB(@"#ffffff");
        _sendCodeBtn.titleLabel.font = XZFS_S_FONT(12);
//        [_sendCodeBtn addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
        _sendCodeBtn.layer.masksToBounds = YES;
        _sendCodeBtn.layer.cornerRadius  = 5;
        _sendCodeBtn.layer.borderWidth = 1;
        _sendCodeBtn.layer.borderColor =XZFS_HEX_RGB(@"#eb6000") .CGColor;
        
    }
    return _sendCodeBtn;
    
}

-(UIButton *)registBtn{
    if (!_registBtn) {
        _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registBtn setTitleColor:XZFS_HEX_RGB(@"#ffffff") forState:UIControlStateNormal];
        _registBtn.backgroundColor = XZFS_HEX_RGB(@"#eb6000");
        _registBtn.titleLabel.font = XZFS_S_FONT(18);
        [_registBtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
        _registBtn.layer.masksToBounds = YES;
        _registBtn.layer.cornerRadius  = 5;
    }
    return _registBtn;
}

-(UIButton *)agreeProtocalBtn{
    if (!_agreeProtocalBtn) {
        _agreeProtocalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeProtocalBtn.backgroundColor = [UIColor redColor];
        [_agreeProtocalBtn addTarget:self action:@selector(agreeProtocal) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _agreeProtocalBtn;
}

-(UIButton *)protocalBtn{
    if (!_protocalBtn) {
        _protocalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_protocalBtn setTitle:@"先知用户协议" forState:UIControlStateNormal];
        _protocalBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        
        [_protocalBtn setTitleColor:XZFS_HEX_RGB(@"#eb6000") forState:UIControlStateNormal];
        _protocalBtn.titleLabel.font = XZFS_S_FONT(11);
        [_protocalBtn addTarget:self action:@selector(showProtocal) forControlEvents:UIControlEventTouchUpInside];
    }
    return _protocalBtn;
}

-(UILabel *)agreeProtocalLab{
    if (!_agreeProtocalLab) {
        _agreeProtocalLab = [[UILabel alloc]init];
        _agreeProtocalLab.text = @"我已阅读并同意";
        _agreeProtocalLab.backgroundColor = [UIColor clearColor];
        _agreeProtocalLab.textColor =  XZFS_HEX_RGB(@"#9F9FA0");
        _agreeProtocalLab.textAlignment =NSTextAlignmentLeft;
        _agreeProtocalLab.font = XZFS_S_FONT(11);
    }
    return _agreeProtocalLab;
    
}


#pragma mark ..

-(void)dealloc{
    NSLog(@"dealloc====");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
