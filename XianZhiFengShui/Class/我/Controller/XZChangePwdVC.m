//
//  XZChangePwdVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/17.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZChangePwdVC.h"
#import "ValidateRule.h"
#import "ValidateTextField.h"
#import "XZLoginRegistService.h"

@interface XZChangePwdVC ()
@property (nonatomic,strong)ValidateTextField * beforePwd;
@property (nonatomic,strong)ValidateTextField * nowPwd;
@property (nonatomic,strong)ValidateTextField * certainPwd;
@property (nonatomic,strong)UIButton * changePwdBtn;
@end

@implementation XZChangePwdVC{
    UIView * _pwdView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"修改密码";
    self.mainView.backgroundColor = XZFS_HEX_RGB(@"#F0EEEF");
    [self setupPwd];
    [self setupChangeBtn];
}

-(void)setupPwd{
    NSArray * leftTitleArray = @[@"原密码",@"新密码",@"确认密码"];
     _pwdView = [[UIView alloc]initWithFrame:CGRectMake(0, XZFS_STATUS_BAR_H+7, SCREENWIDTH, 44*3)];
    _pwdView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pwdView];
    
    for (int i = 0; i<leftTitleArray.count; i++) {
            UILabel * leftTitle = [[UILabel alloc]initWithFrame:CGRectMake(19, 14+i*44, 85, 15)];
            leftTitle.backgroundColor = [UIColor clearColor];
            leftTitle.textColor =  XZFS_TEXTBLACKCOLOR;
            leftTitle.textAlignment =NSTextAlignmentLeft;
            leftTitle.font = XZFS_S_FONT(14);
        leftTitle.text = leftTitleArray[i];
        [_pwdView addSubview:leftTitle];
        
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(19, 43.5+i*44, _pwdView.width-38, 0.5)];
        line.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
        if (i==leftTitleArray.count-1) {
            [line removeFromSuperview];
        }
        [_pwdView addSubview:line];
    }
    
    self.beforePwd.frame = CGRectMake(105, 14, _pwdView.width-110, 15);
    self.nowPwd.frame = CGRectMake(105, _beforePwd.top+44, _pwdView.width-110, 15);
    self.certainPwd.frame = CGRectMake(105, _nowPwd.top+44, _pwdView.width-110, 15);
    
    [_pwdView addSubview:self.beforePwd];
    [_pwdView addSubview:self.nowPwd];
    [_pwdView addSubview:self.certainPwd];
}

-(void)setupChangeBtn{
    [self.view  addSubview:self.changePwdBtn];
    _changePwdBtn.frame = CGRectMake(20, _pwdView.bottom+45, SCREENWIDTH-40, 45);
}


#pragma mark action
-(void)changePwd{
    for (ValidateTextField * tf in _pwdView.subviews) {
        [tf resignFirstResponder];
    }
    ValidateRule * rule = [[ValidateRule alloc]init];
    BOOL isValidate = [rule validateResultWithView:_pwdView];
    if (isValidate) {
        if ([_nowPwd.text isEqualToString:_certainPwd.text]) {
             NSLog(@"修改密码");
            [self updatePwd];
        }else{
            [ToastManager showToastOnView:_pwdView position:CSToastPositionCenter flag:NO message:@"两次密码输入不一致"];
        }
    }
//    NSLog(@"修改密码");
}

#pragma mark 网路
-(void)updatePwd{
    XZLoginRegistService * updatePwdService = [[XZLoginRegistService alloc]init];
    updatePwdService.delegate = self;
    NSDictionary * dic = GETUserdefault(@"userInfos");
    [updatePwdService updatePwdWithMobilePhone:[dic objectForKey:@"mobilePhone"] oldPwd:self.beforePwd.text newPwd:self.nowPwd.text cityCode:@"110000" view:self.view];
}
-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    NSLog(@"successHanderl = %@",succeedHandle);
}

#pragma mark getter

-(ValidateTextField *)beforePwd{
    if (!_beforePwd) {
        _beforePwd = [[ValidateTextField alloc]init];
        _beforePwd.placeholder = @"请输入原密码";
        _beforePwd.errorMsg = @"原密码格式不正确";
        _beforePwd.emptyMsg = @"原密码不能为空";
        _beforePwd.valldataRuleStr = XZFS_PwdRule;
        _beforePwd.clearButtonMode = UITextFieldViewModeWhileEditing;
        _beforePwd.secureTextEntry = YES;
        _beforePwd.font = XZFS_S_FONT(15);
        _beforePwd.textColor = XZFS_TEXTBLACKCOLOR;
        _beforePwd.textAlignment = NSTextAlignmentLeft;
    }
    return _beforePwd;
}

-(ValidateTextField *)nowPwd{
    if (!_nowPwd) {
        _nowPwd = [[ValidateTextField alloc]init];
        _nowPwd.placeholder = @"6-20位字符，区分大小写";
        _nowPwd.errorMsg = @"新密码格式不正确";
        _nowPwd.emptyMsg = @"新密码不能为空";
        _nowPwd.valldataRuleStr = XZFS_PwdRule;
        _nowPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nowPwd.font = XZFS_S_FONT(15);
        _nowPwd.textColor = XZFS_TEXTBLACKCOLOR;
        _nowPwd.secureTextEntry = YES;
        _nowPwd.textAlignment = NSTextAlignmentLeft;
    }
    return _nowPwd;
}

-(ValidateTextField *)certainPwd{
    if (!_certainPwd) {
        _certainPwd = [[ValidateTextField alloc]init];
        _certainPwd.placeholder = @"请再次输入密码";
        _certainPwd.errorMsg = @"密码格式不正确";
        _certainPwd.emptyMsg = @"密码不能为空";
        _certainPwd.valldataRuleStr = XZFS_PwdRule;
        _certainPwd.clearButtonMode = UITextFieldViewModeWhileEditing;
        _certainPwd.font = XZFS_S_FONT(15);
        _certainPwd.textColor = XZFS_TEXTBLACKCOLOR;
        _certainPwd.secureTextEntry = YES;
        _certainPwd.textAlignment = NSTextAlignmentLeft;
    }
    return _certainPwd;
}

-(UIButton *)changePwdBtn{
    if (!_changePwdBtn) {
        _changePwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changePwdBtn setTitle:@"确认修改密码" forState:UIControlStateNormal];
        [_changePwdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _changePwdBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
        _changePwdBtn.titleLabel.font = XZFS_S_FONT(19);
        [_changePwdBtn addTarget:self action:@selector(changePwd) forControlEvents:UIControlEventTouchUpInside];
        _changePwdBtn.layer.masksToBounds = YES;
        _changePwdBtn.layer.cornerRadius  =5;
    }
    return _changePwdBtn;
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
