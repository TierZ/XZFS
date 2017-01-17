//
//  XZPayPwdVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/17.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZPayPwdVC.h"
#import "XZDrawView.h"
#define kDotSize CGSizeMake (10, 10) //密码点的大小
#define kDotCount 6  //密码个数

@interface XZPayPwdVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *dotArray; //用于存放黑色的点点
@property (nonatomic,strong)UILabel * textLab;
@property (nonatomic,strong)UIButton * setupBtn;
@property (nonatomic,strong)UIButton * nextBtn;
@end

@implementation XZPayPwdVC{
    NSString * firstPwdStr;
    NSString * secondPwdStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"设置支付密码";
     firstPwdStr = @"";
    secondPwdStr = @"";
    [self.mainView addSubview:self.textField];
    //页面出现时让键盘弹出
    [self.textField becomeFirstResponder];
    [self initPwdTextField];
}

- (void)initPwdTextField
{
    UIView * pwdView = [[UIView alloc]initWithFrame:CGRectMake(0, 7, SCREENWIDTH, XZFS_MainView_H-7)];
    pwdView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:pwdView];
    
    self.textLab.frame = CGRectMake(0, 45, SCREENWIDTH, 14);
    self.textLab.text = @"请设置支付密码";
    [pwdView addSubview:self.textLab];
    
    self.textField.frame = CGRectMake(60, 85, SCREENWIDTH-60*2, 30);
    [pwdView addSubview:self.textField];
    
    //每个密码输入框的宽度
    CGFloat width = 30;
    CGFloat space = (SCREENWIDTH-60*2-width*kDotCount)/(kDotCount-1);
     self.dotArray = [[NSMutableArray alloc] init];
    //生成分割线
    for (int i = 0; i < kDotCount ; i++) {
        XZDrawView * kuangV = [[XZDrawView alloc]initWithFrame:CGRectMake(i*(space+width), 0, width, width)];
        kuangV.backgroundColor = [UIColor clearColor];
        [self.textField addSubview:kuangV];
        
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(60,10, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.center = kuangV.center;
        dotView.layer.cornerRadius = kDotSize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //先隐藏
        [self.textField addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.dotArray addObject:dotView];
    }
    
    self.nextBtn.frame = CGRectMake(22, self.textField.bottom+70, SCREENWIDTH-22*2, 45);
    self.setupBtn.frame = self.nextBtn.frame;
    [pwdView addSubview:self.nextBtn];
    [pwdView addSubview:self.setupBtn];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"变化%@", string);
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    }
    else if(textField.text.length >= kDotCount) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
}

/**
 *  重置显示的点
 */
- (void)textFieldDidChange:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    for (UIView *dotView in self.dotArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i++) {
        ((UIView *)[self.dotArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == kDotCount) {
        NSLog(@"输入完毕");
    }
}

#pragma mark action
-(void)reInputPwd{
    if (self.textField.text.length>=kDotCount) {
        self.nextBtn.hidden= YES;
        self.setupBtn.hidden = NO;
        self.textLab.text = @"请再次输入以确认";
        firstPwdStr = self.textField.text;
        self.textField.text = @"";
        for (int i = 0; i < self.dotArray.count; i++) {
            ((UIView *)[self.dotArray objectAtIndex:i]).hidden = YES;
        }
    }else{
        [ToastManager showToastOnView:self.mainView position:CSToastPositionCenter flag:NO message:@"请输入6位数支付密码"];
    }
}
-(void)setupPwd{
    if (self.textField.text.length>=kDotCount) {
        secondPwdStr = self.textField.text;
        if ([firstPwdStr isEqualToString:secondPwdStr]) {
            NSLog(@"设置支付密码，网络请求");
            [self.textField resignFirstResponder];
        }else{
             [ToastManager showToastOnView:self.mainView position:CSToastPositionCenter flag:NO message:@"两次输入不一致，请重新输入"];
            firstPwdStr = @"";
            secondPwdStr = @"";
            self.nextBtn.hidden= NO;
            self.setupBtn.hidden = YES;
            self.textLab.text = @"请设置先知支付密码";
            self.textField.text = @"";
            for (int i = 0; i < self.dotArray.count; i++) {
                ((UIView *)[self.dotArray objectAtIndex:i]).hidden = YES;
            }
        }
    }else{
        [ToastManager showToastOnView:self.mainView position:CSToastPositionCenter flag:NO message:@"请输入6位数支付密码"];
    }

}
#pragma mark - init

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        _textField.textColor = [UIColor clearColor];
        //输入框光标的颜色为白色
        _textField.tintColor = [UIColor clearColor];
        _textField.delegate = self;
//        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
//        _textField.layer.borderColor = [[UIColor grayColor] CGColor];
//        _textField.layer.borderWidth = 1;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

-(UILabel *)textLab{
    if (!_textLab) {
        _textLab = [[UILabel alloc]init];
        _textLab.backgroundColor = [UIColor clearColor];
        _textLab.textColor =  XZFS_TEXTBLACKCOLOR;
        _textLab.textAlignment =NSTextAlignmentCenter;
        _textLab.font = XZFS_S_FONT(14);
    }
    return _textLab;
}

-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.layer.cornerRadius = 5;
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = XZFS_S_FONT(18);
        [_nextBtn addTarget:self action:@selector(reInputPwd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;

}

-(UIButton *)setupBtn{
    if (!_setupBtn) {
        _setupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_setupBtn setTitle:@"完成" forState:UIControlStateNormal];
        _setupBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
        _setupBtn.layer.masksToBounds = YES;
        _setupBtn.layer.cornerRadius = 5;
        [_setupBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _setupBtn.titleLabel.font = XZFS_S_FONT(18);
        [_setupBtn addTarget:self action:@selector(setupPwd) forControlEvents:UIControlEventTouchUpInside];
        _setupBtn.hidden = YES;
    }
    return _setupBtn;
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
