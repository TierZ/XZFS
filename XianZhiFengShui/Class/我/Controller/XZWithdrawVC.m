//
//  XZWithdrawVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/3.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZWithdrawVC.h"

@interface XZWithdrawVC ()
@end

@implementation XZWithdrawVC{
    UIView * _withdrawView;
    UIView * _moneyView;
    UITextField * _moneyTf;
    UIButton* _withdrawBtn;
    UILabel * _receiveMoneyTimeLab;
    UIButton * aliPayBtn;
    UIButton * wechatPayBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"提现";
    [self setupWithdrawInfo];
    [self setupMoney];
    [self setupBottom];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [_moneyTf resignFirstResponder];
    }];
    [self.mainView addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
}

-(void)setupWithdrawInfo{
    _withdrawView = [[UIView alloc]initWithFrame:CGRectMake(0, 9, SCREENWIDTH, 48)];
    _withdrawView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:_withdrawView];
    
    UILabel * withdrawLab = [[UILabel alloc]initWithFrame:CGRectMake(21, 16.5, 100, 15)];
    withdrawLab.text = @"提现方式";
    withdrawLab.textColor = XZFS_TEXTBLACKCOLOR;
    withdrawLab.font = XZFS_S_FONT(14);
    [withdrawLab sizeToFit];
    
    [_withdrawView addSubview:withdrawLab];
    
     aliPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [aliPayBtn setTitle:@"支付宝账户" forState:UIControlStateNormal];
    [aliPayBtn setTitleColor:XZFS_HEX_RGB(@"#D5D5D6") forState:UIControlStateNormal];
    [aliPayBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateSelected];
    aliPayBtn.titleLabel.font = XZFS_S_FONT(14);
    aliPayBtn.frame = CGRectMake(withdrawLab.right+33, 12.5, 94, 23);
    aliPayBtn.layer.masksToBounds = YES;
    aliPayBtn.layer.cornerRadius = 4;
    aliPayBtn.layer.borderWidth = 1;
    aliPayBtn.tag = 10;
    aliPayBtn.selected = YES;

        aliPayBtn.layer.borderColor = XZFS_TEXTORANGECOLOR.CGColor;


    [aliPayBtn addTarget:self action:@selector(payStyle:) forControlEvents:UIControlEventTouchUpInside];
    [_withdrawView addSubview:aliPayBtn];
    
    
   wechatPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wechatPayBtn setTitle:@"微信账户" forState:UIControlStateNormal];
    [wechatPayBtn setTitleColor:XZFS_HEX_RGB(@"#D5D5D6") forState:UIControlStateNormal];
    [wechatPayBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateSelected];
    wechatPayBtn.titleLabel.font = XZFS_S_FONT(14);
    wechatPayBtn.frame = CGRectMake(aliPayBtn.right+33, 12.5, 77, 23);
    wechatPayBtn.layer.masksToBounds = YES;
    wechatPayBtn.layer.cornerRadius = 4;
    wechatPayBtn.layer.borderWidth = 1;
    wechatPayBtn.tag = 11;

    wechatPayBtn.layer.borderColor = XZFS_HEX_RGB(@"#D5D5D6").CGColor;
    [wechatPayBtn addTarget:self action:@selector(payStyle:) forControlEvents:UIControlEventTouchUpInside];
    [_withdrawView addSubview:wechatPayBtn];
    
}

-(void)setupMoney{
    _moneyView = [[UIView alloc]initWithFrame:CGRectMake(0, _withdrawView.bottom+9, SCREENWIDTH, 48)];
    _moneyView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:_moneyView];
    
    UILabel * moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(21, 16.5, 100, 15)];
    moneyLab.text = @"金额（元）";
    moneyLab.textColor = XZFS_TEXTBLACKCOLOR;
    moneyLab.font = XZFS_S_FONT(14);
    [moneyLab sizeToFit];
    
    [_moneyView addSubview:moneyLab];
    
    _moneyTf = [[UITextField alloc]initWithFrame:CGRectMake(aliPayBtn.left, 12.5, _moneyView.width-aliPayBtn.left-21, 23)];
    _moneyTf.textColor = XZFS_TEXTBLACKCOLOR;
    _moneyTf.font = XZFS_S_FONT(14);
    _moneyTf.placeholder = @"最多可提现金额。。。";
    _moneyTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_moneyView addSubview:_moneyTf];
    
}

-(void)setupBottom{
    UILabel * tips = [[UILabel alloc]initWithFrame:CGRectMake(0, _moneyView.bottom+13, SCREENWIDTH, 11)];
    tips.font = XZFS_S_FONT(11);
    tips.textAlignment = NSTextAlignmentCenter;
    tips.textColor = XZFS_HEX_RGB(@"#FB5652");
    tips.text = @"提现金额大于5元时，可进行提现操作，不满200元，须扣除5元手续费";
    
    [self.mainView addSubview:tips];
    
    _withdrawBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _withdrawBtn.frame = CGRectMake(21, tips.bottom+30, SCREENWIDTH-42, 45);
    _withdrawBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
    [_withdrawBtn setTitle:@"提现" forState:UIControlStateNormal];
    [_withdrawBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _withdrawBtn.titleLabel.font = XZFS_S_FONT(18);
    [_withdrawBtn addTarget:self action:@selector(withdrawMoney:) forControlEvents:UIControlEventTouchUpInside];
    _withdrawBtn.layer.masksToBounds = YES;
    _withdrawBtn.layer.cornerRadius = 5;
    [self.mainView addSubview:_withdrawBtn];
    
    
    _receiveMoneyTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _withdrawBtn.bottom+20, SCREENWIDTH, 14)];
    _receiveMoneyTimeLab.font = XZFS_S_FONT(14);
    _receiveMoneyTimeLab.textAlignment = NSTextAlignmentCenter;
    _receiveMoneyTimeLab.textColor = XZFS_HEX_RGB(@"#FB5652");
    _receiveMoneyTimeLab.text = @"最晚到账时间：2016-11-10 13:20";
    
    [self.mainView addSubview:_receiveMoneyTimeLab];
}


-(void)payStyle:(UIButton*)sender{
    NSLog(@"pay 方式：%ld",(long)sender.tag);
    sender.selected = YES;
    sender.layer.borderColor = XZFS_TEXTORANGECOLOR.CGColor;
    
  
    if (sender==aliPayBtn) {
        wechatPayBtn.selected = NO;
          wechatPayBtn.layer.borderColor = XZFS_HEX_RGB(@"#D5D5D6").CGColor;
    }else{
        aliPayBtn.selected = NO;
          aliPayBtn.layer.borderColor = XZFS_HEX_RGB(@"#D5D5D6").CGColor;
    }
}

-(void)withdrawMoney:(UIButton*)sender{
    NSLog(@"withdraw money = %@",_moneyTf.text);
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
