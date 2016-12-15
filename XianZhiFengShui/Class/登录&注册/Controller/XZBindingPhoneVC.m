//
//  XZBindingPhoneVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/7.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZBindingPhoneVC.h"
#import "ValidateRule.h"
#import "ValidateTextField.h"
#import "XZLoginRegistService.h"
@interface XZBindingPhoneVC ()
@property (nonatomic,strong)ValidateTextField * phoneTf;
@property (nonatomic,strong)ValidateTextField * codeTf;
@property (nonatomic,strong)UIButton * sendCodeBtn;
@property (nonatomic,strong)UIButton * bindBtn;
@property (nonatomic,strong)NSTimer * timer;
@end

@implementation XZBindingPhoneVC{
    int _countDownInt;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _countDownInt = 59;
    self.titelLab.text = @"绑定手机号";
    [self setupBindingPhone];
    // Do any additional setup after loading the view.
}
-(void)setupBindingPhone{
    UIView * bindView = [UIView new];
    bindView.backgroundColor = [UIColor whiteColor];
    bindView.frame = CGRectMake(0, 8, SCREENWIDTH, 92);
    [self.mainView addSubview:bindView];
    
    NSArray * titleArr = @[@"手机号码",@"验证码"];
    for (int i = 0; i<titleArr.count; i++) {
        UILabel * lab = [UILabel new];
        lab.textColor = XZFS_HEX_RGB(@"#333333");
        lab.font = XZFS_S_FONT(14);
        lab.text = titleArr[i];
        [bindView addSubview:lab];
        lab.frame = CGRectMake(20, 16+i*46, 100, 14);
    }
    UIView * line = [UIView new];
    line.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
    line.frame = CGRectMake(20, bindView.height/2-0.5, bindView.width-40, 1);
    [bindView addSubview:line];
    
    self.sendCodeBtn.frame = CGRectMake(SCREENWIDTH-85-20, 17, 85, 24);
    [self.mainView addSubview:self.sendCodeBtn];

    
    self.phoneTf.frame = CGRectMake(95, 24, self.sendCodeBtn.left-95, 15);
    [self.mainView addSubview:self.phoneTf];
    
    self.codeTf.frame = CGRectMake(95, self.phoneTf.bottom+31, SCREENWIDTH-95-20, 15);
    [self.mainView addSubview:self.codeTf];
    
    
    self.bindBtn.frame = CGRectMake(20, bindView.bottom+33, SCREENWIDTH-40, 45);
    [self.mainView addSubview:self.bindBtn];
}

#pragma mark action
-(void)sendCode{
    
    ValidateRule * rule = [[ValidateRule alloc]init];
    BOOL isvalidate = [rule isValidateMobile:self.phoneTf.text];
    if (isvalidate) {
        [self.phoneTf resignFirstResponder];
        [self.sendCodeBtn setEnabled:NO];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
        [self sendSecurityCode];
        NSLog(@"发送验证码");
    }else{
        [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:NO message:@"手机号格式不正确"];
    }

}
-(void)bindPhone{
    [self.phoneTf resignFirstResponder];
    [self.codeTf resignFirstResponder];
    ValidateRule * rule = [[ValidateRule alloc]init];
    BOOL isvalidate = [rule validateResultWithView:self.mainView];
    if (isvalidate) {
        NSLog(@"绑定手机号");
    }
    
}

#pragma mark private
- (void)onTimer {
    if (_countDownInt > 0) {
        [self.sendCodeBtn setTitleColor:XZFS_TEXTLIGHTGRAYCOLOR forState:UIControlStateNormal];
        self.sendCodeBtn.layer.borderColor = XZFS_TEXTLIGHTGRAYCOLOR.CGColor;
        [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%d秒重新获取",_countDownInt ] forState:UIControlStateDisabled];
        _countDownInt--;
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


#pragma mark getter
-(ValidateTextField *)phoneTf{
    if (!_phoneTf) {
        _phoneTf = [[ValidateTextField alloc]initWithFrame:CGRectMake(14, 15, SCREENWIDTH-14, 15)];
        _phoneTf.placeholder = @"+86";
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

-(ValidateTextField *)codeTf{
    if (!_codeTf) {
        _codeTf = [[ValidateTextField alloc]initWithFrame:CGRectMake(14, 15, SCREENWIDTH-14, 15)];
        _codeTf.placeholder = @"请输入验证码";
        _codeTf.errorMsg = @"验证码格式不正确";
        _codeTf.emptyMsg = @"验证码不能为空";
        _codeTf.valldataRuleStr = XZFS_VerifyRule;
        _codeTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTf.font = XZFS_S_FONT(15);
        _codeTf.textColor = XZFS_RGB(149, 149, 149);
        _codeTf.textAlignment = NSTextAlignmentLeft;
        _codeTf.keyboardType = UIKeyboardTypeNumberPad;
        //        [_userPhoneTf becomeFirstResponder];
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


-(UIButton *)bindBtn{
    if (!_bindBtn) {
        _bindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bindBtn setTitle:@"绑定" forState:UIControlStateNormal];
        [_bindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _bindBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
        _bindBtn.titleLabel.font = XZFS_S_FONT(19);
        [_bindBtn addTarget:self action:@selector(bindPhone) forControlEvents:UIControlEventTouchUpInside];
        _bindBtn.layer.masksToBounds = YES;
        _bindBtn.layer.cornerRadius  =5;
    }
    return _bindBtn;
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
