//
//  XZMyAccountVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/20.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyAccountVC.h"
#import "XZRechargeVC.h"
#import "XZMyBankCardVC.h"
#import "XZMyAccountBillVC.h"
#import "XZWithdrawVC.h"
#import "UIButton+XZImageTitleSpacing.h"

@interface XZMyAccountVC ()
@property (nonatomic,strong)UILabel * myBalance;
@end

@implementation XZMyAccountVC{
    UIView * _accountV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainView.backgroundColor = XZFS_HEX_RGB(@"#F0EEEF");
    
    [self drawMyAccount];
    [self drawList];
}



-(void)drawMyAccount{
    _accountV = [[UIView alloc]initWithFrame:CGRectMake(0, 8, SCREENWIDTH, 158)];
    _accountV.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:_accountV];
    
    UILabel * myBalanceLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, _accountV.width, 12)];
    myBalanceLab.text = @"账户余额（知币）";
    myBalanceLab.font = XZFS_S_FONT(12);
    myBalanceLab.textColor = XZFS_TEXTGRAYCOLOR;
    myBalanceLab.textAlignment = NSTextAlignmentCenter;
    [_accountV addSubview:myBalanceLab];
    
    self.myBalance .frame = CGRectMake(0, myBalanceLab.bottom+18, _accountV.width, 25);
    [_accountV addSubview:self.myBalance];
    
    self.myBalance.text = [Tool standardNumStringWithString:@"12312312413"];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(24, self.myBalance.bottom+26, _accountV.width-48, 0.5)];
    line.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
    [_accountV addSubview:line];
    
    NSArray * images = @[@"zhanghuchongzhi",@"zhanghutixian"];
    NSArray * titles = @[@"充值",@"提现"];
    for (int i = 0; i<images.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(_accountV.width/2), line.bottom, _accountV.width/2-0.5, 58);
        
        [btn setImage:XZFS_IMAGE_NAMED(images[i]) forState:UIControlStateNormal];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = XZFS_S_FONT(14);
        
        [btn setTitleColor:XZFS_TEXTBLACKCOLOR forState:UIControlStateNormal];
        btn .tag = i;
     [btn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_accountV addSubview:btn];
    }
    UIView * shortLine = [[UIView alloc]initWithFrame:CGRectMake(_accountV.width/2-0.5, line.bottom+16, 0.5, 27)];
    shortLine.backgroundColor = line.backgroundColor;
    [_accountV addSubview:shortLine];

}

-(void)drawList{
    NSArray * images = @[@"wodezhangdan"];
    NSArray * titles = @[@"我的账单"];
    for (int i = 0; i<titles.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, _accountV.bottom+14+i*52, SCREENWIDTH, 45);
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag =10+i;
        [btn addTarget:self action:@selector(listClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:btn];
        
        UIImageView * iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 12.5, 17, 20)];
        iv1.image = XZFS_IMAGE_NAMED(images[i]);
        [btn addSubview:iv1];
        
        UIImageView * iv2 = [[UIImageView alloc]initWithFrame:CGRectMake(btn.width-15-21, 15, 8, 15)];
        iv2.image = XZFS_IMAGE_NAMED(@"youjiantou_hui");
        [btn addSubview:iv2];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(iv1.right+14, 15.5, 200, 14)];
        label.text = titles[i];
        label.textColor = XZFS_TEXTBLACKCOLOR;
        label.font = XZFS_S_FONT(14);
        [btn addSubview:label];
  
    }

}


#pragma mark action
//充值 提现
-(void)btnClick:(UIButton*)sender{
    switch (sender.tag) {
        case 0:
            [self.navigationController pushViewController:[[XZRechargeVC alloc]init] animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:[[XZWithdrawVC alloc]init] animated:YES];
            break;
            
        default:
            break;
    }
    NSLog(@"sender.title = %@",sender.titleLabel.text);
}

-(void)listClick:(UIButton*)sender{
    NSLog(@"btn.tag = %ld",(long)sender.tag);
    if (sender.tag==11) {
        XZMyBankCardVC  * myBankCard = [[XZMyBankCardVC alloc]init];
        [self.navigationController pushViewController:myBankCard animated:YES];
    }else{
        XZMyAccountBillVC  * myBill = [[XZMyAccountBillVC alloc]init];
        [self.navigationController pushViewController:myBill animated:YES];
    }
}
#pragma mark getter

-(UILabel *)myBalance{
    if (!_myBalance) {
        _myBalance = [[UILabel alloc]init];
        _myBalance.backgroundColor = [UIColor clearColor];
        _myBalance.textColor =  XZFS_TEXTBLACKCOLOR;
        _myBalance.textAlignment =NSTextAlignmentCenter;
        _myBalance.font = XZFS_S_FONT(24);
    }
    return _myBalance;
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
