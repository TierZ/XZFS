//
//  XZLoginVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/9.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZLoginVC.h"
#import "ValidateTextField.h"
#import "ValidateRule.h"
#import "XZRegistVC.h"
#import "XZLoginRegistService.h"
#import "JMessage.framework/Headers/JMessage.h"
#import "MBProgressHUD+Add.h"
#import "JCHATStringUtils.h"
#import "XZResetPwdVC.h"
#import "UIButton+XZImageTitleSpacing.h"
#import "WTThirdPartyLoginManager.h"
#import "XZBindingPhoneVC.h"

@interface XZLoginVC ()<DataReturnDelegate>
@property (nonatomic,strong)UIButton * leftArrow;
@property (nonatomic,strong)UILabel * loginTitle;
@property (nonatomic,strong)UIImageView * userNoIv;
@property (nonatomic,strong)UIImageView * userPwdIv;
@property (nonatomic,strong)ValidateTextField * userNoTf;
@property (nonatomic,strong)ValidateTextField  * userPwdTf;
@property (nonatomic,strong)UIButton * loginBtn;
@property (nonatomic,strong)UIButton * forgetPwdBtn;
@property (nonatomic,strong)UIButton * registBtn;
@property (nonatomic,strong)UIScrollView * scroll;
@end

@implementation XZLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self layoutView];
    [self setupOtherLogin];
    
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
//        [self.userNoTf resignFirstResponder];
//        [self.userPwdTf resignFirstResponder];
//    }];
//    [self.view addGestureRecognizer:tap];
  
    
}
-(void)layoutView{
    
    self.scroll = [[UIScrollView alloc]initWithFrame:self.view.frame];
    self.scroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scroll];
    
    [self.scroll addSubview:self.leftArrow];
    [self.scroll addSubview:self.loginTitle];
    [self.scroll addSubview:self.userNoIv];
    [self.scroll addSubview:self.userPwdIv];
    [self.scroll addSubview:self.userNoTf];
    [self.scroll addSubview:self.userPwdTf];
    [self.scroll addSubview:self.loginBtn];
    [self.scroll addSubview:self.forgetPwdBtn];
    [self.scroll addSubview:self.registBtn];
    
    self.leftArrow.frame = CGRectMake(20, 70, 80, 24);
    self.userNoIv.frame = CGRectMake(33, self.leftArrow.bottom+105, 16, 20);
    self.userPwdIv.frame =CGRectMake(33, self.userNoIv.bottom+40, 16, 20);
    self.userNoTf.frame = CGRectMake(self.userNoIv.right+17, self.userNoIv.top-2, SCREENWIDTH-self.userNoIv.right-17-20, 20);
     self.userPwdTf.frame = CGRectMake(self.userPwdIv.right+17, self.userPwdIv.top-2, SCREENWIDTH-self.userNoIv.right-17-20, 20);
    
    self.loginBtn.frame = CGRectMake(20, self.userPwdTf.bottom+30, SCREENWIDTH-40, 45);
    self.forgetPwdBtn.frame = CGRectMake(25, self.loginBtn.bottom+12, 80, 13);
    self.registBtn.frame = CGRectMake(SCREENWIDTH-25-80, self.loginBtn.bottom+12, 80, 13);
    for (int i = 0; i<2; i++) {
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, self.userNoIv.bottom+5+i*60, SCREENWIDTH-40, 0.5)];
        line.backgroundColor = XZFS_HEX_RGB(@"#C9C9CA");
        [self.scroll addSubview:line];
    }
}


-(void)setupOtherLogin{
    
    UIView * lines = [[UIView alloc]initWithFrame:CGRectMake(0, self.forgetPwdBtn.bottom+71, SCREENWIDTH, 1)];
    lines.backgroundColor = XZFS_HEX_RGB(@"#F2F2F2");
    [self.scroll addSubview:lines];
    
    UILabel * otherLoginLab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.forgetPwdBtn.bottom+66, 150, 12)];
    otherLoginLab.backgroundColor = [UIColor whiteColor];
    otherLoginLab.text = @"第三方账号登录";
    otherLoginLab.textColor = XZFS_TEXTLIGHTGRAYCOLOR;
    otherLoginLab.font = XZFS_S_FONT(12);
    otherLoginLab.textAlignment = NSTextAlignmentCenter;
     otherLoginLab.centerX = self.scroll.centerX;
    [self.scroll addSubview:otherLoginLab];
    
    NSArray * otherLogins = @[@"新浪微博",@"微信"];
    NSArray * otherIcons = @[@"weibodenglu",@"weixindenglu"];
    for (int i = 0; i<otherLogins.count; i++) {
        UIButton * otherLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i==0) {
            otherLoginBtn.frame = CGRectMake(self.scroll.width/2-110, otherLoginLab.bottom+30, 65, 60);
        }else if (i==1){
            otherLoginBtn.frame = CGRectMake(self.scroll.width/2+45, otherLoginLab.bottom+30, 65, 60);
        }
        
        [otherLoginBtn setTitle:otherLogins[i] forState:UIControlStateNormal];
        [otherLoginBtn setTitleColor:XZFS_TEXTLIGHTGRAYCOLOR forState:UIControlStateNormal];
        otherLoginBtn.titleLabel.font = XZFS_S_FONT(15);
        [otherLoginBtn setImage:[UIImage imageNamed:otherIcons[i]] forState:UIControlStateNormal];
        [otherLoginBtn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleTop imageTitleSpace:20];
        otherLoginBtn.tag = i;
        [otherLoginBtn addTarget:self action:@selector(otherLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self.scroll addSubview:otherLoginBtn];

    }
    
    UIView * horiLine = [[UIView alloc]initWithFrame:CGRectMake(self.scroll.width/2-0.5, otherLoginLab.bottom+42, 1, 35)];
    horiLine.backgroundColor = XZFS_TEXTLIGHTGRAYCOLOR;
    [self.scroll addSubview:horiLine];
    
    if (horiLine.bottom+100>SCREENHEIGHT) {
        self.scroll.contentSize = CGSizeMake(SCREENWIDTH, horiLine.bottom+100);
    }
    
}



#pragma mark action
-(void)clickLeft:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)login{
    [self.userNoTf resignFirstResponder];
    [self.userPwdTf resignFirstResponder];
    ValidateRule * rule = [[ValidateRule alloc]init];
    BOOL isValidate = [rule validateResultWithView:self.view];
    if (isValidate) {
        XZLoginRegistService * login = [[XZLoginRegistService alloc]init];
        login.delegate = self;
        [login requestLoginWithPhoneNo:self.userNoTf.text password:self.userPwdTf.text view:self.view];
    }
       NSLog(@"登录");
    
}
-(void)forgetPwd{
    [self.navigationController pushViewController:[[XZResetPwdVC alloc]init] animated:YES];
    NSLog(@"忘记密码");
}
-(void)registNow{
    NSLog(@"注册");
    [self.navigationController pushViewController:[[XZRegistVC alloc]init] animated:YES];
}

-(void)otherLogin:(UIButton*)sender{
    WTLoginType loginType;
    if (sender.tag == WTLoginTypeWeiBo) {
        loginType = WTLoginTypeWeiBo;
    }else if (sender.tag == WTLoginTypeTencent){
        loginType = WTLoginTypeTencent;
    }else if (sender.tag == WTLoginTypeWeiXin){
        loginType = WTLoginTypeWeiXin;
    }
    
    
    [WTThirdPartyLoginManager getUserInfoWithWTLoginType:loginType result:^(NSDictionary *LoginResult, NSString *error) {
        
        
        NSLog(@"%@",[NSThread currentThread]);
        
        if (LoginResult) {
            
            NSLog(@"🐒🐒🐒🐒🐒🐒🐒🐒-----%@", LoginResult);
                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:LoginResult[@"third_image"]]];
//            self.userIcon.image = [UIImage imageWithData:data];
            [self.navigationController pushViewController:[[XZBindingPhoneVC alloc]init] animated:YES];
            
        }else{
            NSLog(@"%@",error);
        }
        
    }];
        
    NSLog(@"三方登录--%ld",(long)sender.tag);
}

#pragma mark 网络回调
-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    NSDictionary * dic = (NSDictionary*)succeedHandle;
    NSLog(@"dic = %@",dic);
    NSMutableDictionary * userInfo = [NSMutableDictionary dictionary];
    NSDictionary * userDic = [dic objectForKey:@"data"];
    [userInfo setObject:[userDic objectForKey:@"bizCode"] forKey:@"bizCode"];
    [userInfo setObject:[userDic objectForKey:@"mobilePhone"] forKey:@"mobilePhone"];
    [userInfo setObject:[userDic objectForKey:@"username"] forKey:@"username"];
    [userInfo setObject:@YES forKey:@"isLogin"];
    
    SETUserdefault(userInfo, @"userInfos");
    
    [JMSGUser loginWithUsername:self.userNoTf.text password:self.userPwdTf.text completionHandler:^(id resultObject, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            [MBProgressHUD showMessage:[JCHATStringUtils errorAlert:error] view:self.view];
        }else{
            [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:YES message:@"登陆成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self dismissViewControllerAnimated:YES completion:nil];
            });
            
        }
    }];
}

#pragma mark getter
-(UIButton *)leftArrow{
    if (!_leftArrow) {
        _leftArrow = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftArrow setImage:XZFS_IMAGE_NAMED(@"zuojiantou") forState:UIControlStateNormal];
        [_leftArrow setTitle:@"登录" forState:UIControlStateNormal];
        [_leftArrow setTitleColor:XZFS_HEX_RGB(@"#000000") forState:UIControlStateNormal];
        _leftArrow.titleLabel.font =  XZFS_S_FONT(18);
        [_leftArrow layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:20];
        [_leftArrow addTarget:self action:@selector(clickLeft:) forControlEvents:UIControlEventTouchUpInside];
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

-(ValidateTextField *)userNoTf{
    if (!_userNoTf) {
        _userNoTf = [[ValidateTextField alloc]init];
        _userNoTf.placeholder = @"请输入账号";
        _userNoTf.errorMsg = @"账号格式不正确";
        _userNoTf.emptyMsg = @"账号不能为空";
        _userNoTf.valldataRuleStr = XZFS_LoginAccount;
        _userNoTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNoTf.font =  XZFS_S_FONT(15);
        _userNoTf.textColor = XZFS_RGB(149, 149, 149);
        _userNoTf.textAlignment = NSTextAlignmentLeft;
        //        _userPhoneTf.keyboardType = UIKeyboardTypeNumberPad;
        //        [_userPhoneTf becomeFirstResponder];
    }
    return _userNoTf;
}

-(ValidateTextField *)userPwdTf{
    if (!_userPwdTf) {
        _userPwdTf = [[ValidateTextField alloc]init];
        _userPwdTf.placeholder = @"请输入密码";
        _userPwdTf.errorMsg = @"密码格式不正确";
        _userPwdTf.emptyMsg = @"密码不能为空";
        _userPwdTf.valldataRuleStr = XZFS_PwdRule;
        _userPwdTf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userPwdTf.font = XZFS_S_FONT(15);
        _userPwdTf.secureTextEntry = YES;
        _userPwdTf.textColor = XZFS_RGB(149, 149, 149);
        _userPwdTf.textAlignment = NSTextAlignmentLeft;
        //        _userPhoneTf.keyboardType = UIKeyboardTypeNumberPad;
        //        [_userPhoneTf becomeFirstResponder];
    }
    return _userPwdTf;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:XZFS_HEX_RGB(@"#ffffff") forState:UIControlStateNormal];
        _loginBtn.backgroundColor = XZFS_HEX_RGB(@"#eb6000");
        _loginBtn.titleLabel.font = XZFS_S_FONT(18);
        [_loginBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius  = 5;
    }
    return _loginBtn;
}

-(UIButton *)forgetPwdBtn{
    if (!_forgetPwdBtn) {
        _forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        _forgetPwdBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_forgetPwdBtn setTitleColor:XZFS_HEX_RGB(@"#eb6000") forState:UIControlStateNormal];
        _forgetPwdBtn.titleLabel.font = XZFS_S_FONT(12);
        [_forgetPwdBtn addTarget:self action:@selector(forgetPwd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPwdBtn;
}

-(UIButton *)registBtn{
    if (!_registBtn) {
        _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registBtn setTitle:@"快速注册" forState:UIControlStateNormal];
        _registBtn.titleLabel.textAlignment = NSTextAlignmentRight;

        [_registBtn setTitleColor:XZFS_HEX_RGB(@"#eb6000") forState:UIControlStateNormal];
        _registBtn.titleLabel.font = XZFS_S_FONT(12);
        [_registBtn addTarget:self action:@selector(registNow) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registBtn;
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
