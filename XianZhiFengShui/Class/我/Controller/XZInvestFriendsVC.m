//
//  XZInvestFriendsVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/5.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZInvestFriendsVC.h"

@interface XZInvestFriendsVC ()

@end

@implementation XZInvestFriendsVC{
    UIScrollView * _mainScroll;
    UIImageView * _topIv;
    UILabel * _investLab;
    UILabel * _investCount;
    UILabel * _investMoney;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"邀请好友赢大礼";
    [self setupView];
    // Do any additional setup after loading the view.
}
-(void)setupView{
    _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, XZFS_MainView_H)];
    _mainScroll.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:_mainScroll];
    [self setupTop];
    [self setupMiddele];
    [self setupCount];
    [self setupBottom];
}
-(void)setupTop{
    _topIv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 190)];
    _topIv.backgroundColor = [UIColor redColor];
    [_mainScroll addSubview:_topIv];

}

-(void)setupMiddele{
    _investLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _topIv.bottom+25, SCREENWIDTH, 100)];
    _investLab.numberOfLines = 0;
    _investLab.textColor = XZFS_HEX_RGB(@"#252323");
    _investLab.font = XZFS_S_FONT(12);
    [_mainScroll addSubview:_investLab];
    
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:@"邀请好友注册先知\n你可以获得50元优惠券大礼\n你的好友也将获得50元优惠券\n赶快邀请吧~"];
    [att addAttribute:NSFontAttributeName value:XZFS_S_FONT(12) range:NSMakeRange(0, att.length)];
    [att addAttribute:NSForegroundColorAttributeName value:XZFS_HEX_RGB(@"#252323") range:NSMakeRange(0, att.length)];
    
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 15;
    [att addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, att.length)];
    _investLab.attributedText = att;
    _investLab.textAlignment =NSTextAlignmentCenter;
}

-(void)setupCount{
    UILabel * investCountLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _investLab.bottom+45, SCREENWIDTH/2, 11)];
    investCountLab.text = @"已邀请";
    investCountLab.textColor = XZFS_TEXTBLACKCOLOR;
    investCountLab.font = XZFS_S_FONT(11);
    investCountLab.textAlignment =NSTextAlignmentCenter;
    [_mainScroll addSubview:investCountLab];
    
    UILabel * investMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/2, _investLab.bottom+45, SCREENWIDTH/2, 11)];
    investMoneyLab.text = @"已获得";
    investMoneyLab.textColor = XZFS_TEXTBLACKCOLOR;
    investMoneyLab.font = XZFS_S_FONT(11);
    investMoneyLab.textAlignment =NSTextAlignmentCenter;
    [_mainScroll addSubview:investMoneyLab];
    
    _investCount = [[UILabel alloc]initWithFrame:CGRectMake(0, investCountLab.bottom+10, SCREENWIDTH/2, 11)];
    _investCount.text = @"--位";
    _investCount.textColor = XZFS_TEXTBLACKCOLOR;
    _investCount.font = XZFS_S_FONT(11);
   _investCount.textAlignment =NSTextAlignmentCenter;
    [_mainScroll addSubview:_investCount];
    
    _investMoney = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/2, investMoneyLab.bottom+10, SCREENWIDTH/2, 11)];
    _investMoney.text = @"--元";
    _investMoney.textColor = XZFS_TEXTBLACKCOLOR;
    _investMoney.font = XZFS_S_FONT(11);
     _investMoney.textAlignment =NSTextAlignmentCenter;
    [_mainScroll addSubview:_investMoney];
    
 }
-(void)setupBottom{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, _investCount.bottom+20, SCREENWIDTH-20*2, 45);
    [btn setTitle:@"立即邀请" forState:UIControlStateNormal];
    btn.backgroundColor = XZFS_TEXTORANGECOLOR;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = XZFS_S_FONT(18);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(investFriend) forControlEvents:UIControlEventTouchUpInside];
    [_mainScroll addSubview:btn];

    _mainScroll.contentSize = btn.bottom>XZFS_MainView_H?CGSizeMake(SCREENWIDTH, btn.bottom+30):CGSizeMake(SCREENWIDTH, XZFS_MainView_H);
}

-(void)investFriend{
    NSLog(@"邀请好友");
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
