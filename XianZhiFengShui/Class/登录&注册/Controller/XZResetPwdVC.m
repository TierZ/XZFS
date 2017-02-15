//
//  XZResetPwdVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/1.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZResetPwdVC.h"
#import "ValidateRule.h"
#import "ValidateTextField.h"
#import "XZLoginRegistService.h"

@interface XZResetPwdVC ()
@property (nonatomic,strong)ValidateTextField * phoneTf;//手机号
@property (nonatomic,strong)ValidateTextField * pwdTf;//密码
@property (nonatomic,strong)ValidateTextField * codeTf;//验证码
@property (nonatomic,strong)UIButton * resetPwdBtn;//重置密码
@property (nonatomic,strong)UIButton * sendCodeBtn;//发送验证码
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic,copy)NSString * securityCode;
@end

@implementation XZResetPwdVC{
    UIView * _resetView;
    int _countDownInt;
    NSTimeInterval clickTIme ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"忘记密码";
    [self setupResetView];
    [self setupResetBtn];
    _countDownInt = 59;
    // Do any additional setup after loading the view.
}

-(void)setupResetView{
    _resetView = [UIView new];
    _resetView.frame = CGRectMake(0, 8, SCREENWIDTH, 135);
    _resetView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:_resetView];
    
    NSArray * titles = @[@"手机号码",@"验证码",@"新密码"];
    
    for (int i = 0; i<titles.count; i++) {
        UILabel * titleLab = [UILabel new];
        titleLab.frame = CGRectMake(20, 16+i*45, 100, 13);
        titleLab.font = XZFS_S_FONT(13);
        titleLab.text = titles[i];
        titleLab.textColor = XZFS_TEXTBLACKCOLOR;
        [titleLab sizeToFit];
        [_resetView addSubview:titleLab];
        
        if (i!=titles.count-1) {
            UIView * line = [UIView new];
            line.backgroundColor = XZFS_HEX_RGB(@"#F3F4F4");
            line.frame = CGRectMake(20, 44.5+i*45, _resetView.width-40, 0.5);
            [_resetView addSubview:line];
        }
    }
    
    self.sendCodeBtn.frame = CGRectMake(_resetView.width-85-20, 11, 85, 23);
    self. phoneTf.frame = CGRectMake(90, 15, self.sendCodeBtn.left-90, 15);
    self.codeTf.frame = CGRectMake(90, 60, _resetView.width-90-20, 15);
    self.pwdTf.frame = CGRectMake(90, 105, _resetView.width-90-20, 15);
    [_resetView addSubview:self.sendCodeBtn];
    [_resetView addSubview:self.phoneTf];
    [_resetView addSubview:self.pwdTf];
    [_resetView addSubview:self.codeTf];
}

-(void)setupResetBtn{
    self.resetPwdBtn.frame = CGRectMake(20, _resetView.bottom+45, _resetView.width-40, 45);
    [self.mainView addSubview:self.resetPwdBtn];
}

#pragma mark action
-(void)sendCode{
    ValidateRule * rule = [[ValidateRule alloc]init];
    BOOL isvalidate = [rule isValidateMobile:self.phoneTf.text];
    if (isvalidate) {
        [self.sendCodeBtn setEnabled:NO];
      clickTIme =   [[NSDate date] timeIntervalSince1970];
        NSLog(@"clickTime = %f",clickTIme);
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
        [self sendSecurityCode];
        NSLog(@"发送验证码");
    }else{
        [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:NO message:@"手机号格式不正确"];
    }
 
}
-(void)resetPwd{
    ValidateRule * rule = [[ValidateRule alloc]init];
    BOOL isvalidate = [rule validateResultWithView:_resetView];
    if (isvalidate) {
        if ([self.securityCode isEqualToString:self.codeTf.text]) {
            [self requestResetPwd];
            NSLog(@"重置");
        }else{
            [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:NO message:@"验证码不正确，请重新输入"];
        }
    }
    
}
#pragma mark private
- (void)onTimer {
    NSTimeInterval currentTime = [[NSDate date]timeIntervalSince1970];
    NSLog(@"timespace = %f",currentTime-clickTIme);
    
    if (_countDownInt > 0) {
        _countDownInt =59-(currentTime-clickTIme);
        NSLog(@"_countDownInt = %d",_countDownInt);
        [self.sendCodeBtn setTitleColor:XZFS_TEXTLIGHTGRAYCOLOR forState:UIControlStateNormal];
        self.sendCodeBtn.layer.borderColor = XZFS_TEXTLIGHTGRAYCOLOR.CGColor;
        [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%d秒重新获取",_countDownInt ] forState:UIControlStateDisabled];
//        _countDownInt--;
    } else {
        _countDownInt = 60;
        [_timer invalidate];
        _timer = nil;
        [self.sendCodeBtn setTitle:@"60秒重新获取" forState:UIControlStateDisabled];
        [self.sendCodeBtn setTitle:@"重发验证码" forState:UIControlStateNormal];
        [self.sendCodeBtn setEnabled:YES];
         [self.sendCodeBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
        self.sendCodeBtn.layer.borderColor = XZFS_TEXTORANGECOLOR.CGColor;
    }
}

#pragma mark 网络
/**
 发送验证码
 */
-(void)sendSecurityCode{
    XZLoginRegistService * sendCodeService = [[XZLoginRegistService alloc]initWithServiceTag:XZGetResetSecurityTag];
    sendCodeService.delegate = self;
    [sendCodeService requestSecurityCodeWithPhoneNo:self.phoneTf.text cityCode:@"110000" type:@"2" view:self.view];
    
    
}

-(void)requestResetPwd{
    XZLoginRegistService * resetPwdService = [[XZLoginRegistService alloc]initWithServiceTag:XZResetPwdTag];
    resetPwdService.delegate = self;
    [resetPwdService resetPwdWithMobilePhone:self.phoneTf.text pwd:self.pwdTf.text cityCode:@"110000" view:self.view];
}

-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    XZLoginRegistService * resetService = (XZLoginRegistService*)service;
    NSDictionary * dic = (NSDictionary*)succeedHandle;
    switch (resetService.serviceTag) {
        case XZGetResetSecurityTag:{
            NSDictionary * dic = (NSDictionary*)succeedHandle;
            NSDictionary * data = [dic objectForKey:@"data"];
            self.securityCode = [data objectForKey:@"vcode"];
            NSLog(@"successHandle1 = %@",succeedHandle);
        }
            break;
        case XZResetPwdTag:{
            if ([[dic objectForKey:@"statusCode"]integerValue] ==200) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            }
            NSLog(@"successHandle2 = %@",succeedHandle);
        }
            break;
            
        default:
            break;
    }
}

#pragma mark getter

-(ValidateTextField *)phoneTf{
    if (!_phoneTf) {
        _phoneTf = [[ValidateTextField alloc]init];
        _phoneTf.placeholder = @"请输入手机号";
        _phoneTf.errorMsg = @"账号格式不正确";
        _phoneTf.emptyMsg = @"账号不能为空";
        _phoneTf.valldataRuleStr = XZFS_LoginAccount;
        _phoneTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTf.font = XZFS_S_FONT(15);
        _phoneTf.textColor = XZFS_RGB(149, 149, 149);
        _phoneTf.textAlignment = NSTextAlignmentLeft;
        _phoneTf.keyboardType = UIKeyboardTypeNumberPad;
        //        [_userPhoneTf becomeFirstResponder];
    }
    return _phoneTf;
}

-(ValidateTextField *)pwdTf{
    if (!_pwdTf) {
        _pwdTf = [[ValidateTextField alloc]init];
        _pwdTf.placeholder = @"请输入密码";
        _pwdTf.errorMsg = @"密码格式不正确";
        _pwdTf.emptyMsg = @"密码不能为空";
        _pwdTf.valldataRuleStr = XZFS_PwdRule;
        _pwdTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwdTf.font = XZFS_S_FONT(15);
        _pwdTf.secureTextEntry = YES;
        _pwdTf.textColor = XZFS_RGB(149, 149, 149);
        _pwdTf.textAlignment = NSTextAlignmentLeft;
        //        _userPhoneTf.keyboardType = UIKeyboardTypeNumberPad;
        //        [_userPhoneTf becomeFirstResponder];
    }
    return _pwdTf;
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

-(UIButton *)sendCodeBtn{
    if (!_sendCodeBtn) {
        _sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_sendCodeBtn setTitleColor:XZFS_HEX_RGB(@"#eb6000") forState:UIControlStateNormal];
        _sendCodeBtn.backgroundColor = XZFS_HEX_RGB(@"#ffffff");
        _sendCodeBtn.titleLabel.font = XZFS_S_FONT(12);
        [_sendCodeBtn addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
        _sendCodeBtn.layer.masksToBounds = YES;
        _sendCodeBtn.layer.cornerRadius  = 5;
        _sendCodeBtn.layer.borderWidth = 1;
        _sendCodeBtn.layer.borderColor =XZFS_HEX_RGB(@"#eb6000") .CGColor;
        
    }
    return _sendCodeBtn;
    
}


-(UIButton *)resetPwdBtn{
    if (!_resetPwdBtn) {
        _resetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetPwdBtn setTitle:@"重置密码" forState:UIControlStateNormal];
        [_resetPwdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _resetPwdBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
        _resetPwdBtn.titleLabel.font = XZFS_S_FONT(19);
        [_resetPwdBtn addTarget:self action:@selector(resetPwd) forControlEvents:UIControlEventTouchUpInside];
        _resetPwdBtn.layer.masksToBounds = YES;
        _resetPwdBtn.layer.cornerRadius  =5;
    }
    return _resetPwdBtn;
}

-(void)dealloc{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
