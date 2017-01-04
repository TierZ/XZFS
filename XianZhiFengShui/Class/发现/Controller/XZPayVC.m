//
//  XZPayVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/3.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZPayVC.h"

#import "XZPayMiddleView.h"
#import "XZPayView.h"

#define BottomHeight 45
@interface XZPayVC ()
@property (nonatomic,strong)XZPayTopView * topView;
@property (nonatomic,strong)XZPayMiddleView * middleView;
@property (nonatomic,strong)XZPayView * payView;
@property (nonatomic,assign) int paySelect;
@end

@implementation XZPayVC{
    XZPayTopStyle _payStyle;
   
}

- (instancetype)initWithPayStyle:(XZPayTopStyle)style
{
    self = [super init];
    if (self) {
        _payStyle = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"支付";
    _paySelect = 10;
    [self setupView];
    
    [self setupBottomView];
}

-(void)setupView{
    
    UIScrollView * scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, XZFS_MainView_H-BottomHeight)];
    [self.mainView addSubview:scroll];
    
    self.topView = [[XZPayTopView alloc]initWithFrame:CGRectMake(0, 10, SCREENWIDTH, 140) topStyle:_payStyle];
    self.topView.backgroundColor = [UIColor whiteColor];
    [scroll addSubview:self.topView];
    
    self.middleView = [[XZPayMiddleView alloc]initWithFrame:CGRectMake(0, self.topView.bottom+10, SCREENWIDTH, 80) couponStyle:XZHaveCoupon];
    self.middleView.backgroundColor = [UIColor whiteColor];
    [scroll addSubview:self.middleView];
    
    self.payView =  [[XZPayView alloc]initWithFrame:CGRectMake(0, self.middleView.bottom, SCREENWIDTH, 200)];
    [scroll addSubview:self.payView];
    __weak typeof(self)weakSelf = self;
   [self.payView selectPayWithBlock:^(SelectPay pay) {
       weakSelf.paySelect = (int)pay;
   }];
    
    scroll.contentSize = self.payView.bottom>(XZFS_MainView_H-BottomHeight)?CGSizeMake(SCREENWIDTH, self.payView.bottom+10):CGSizeMake(SCREENWIDTH, (XZFS_MainView_H-BottomHeight));
}

-(void)setupBottomView{
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, XZFS_MainView_H-BottomHeight, SCREENWIDTH, BottomHeight)];
    bottomView.layer.masksToBounds = YES;
    bottomView.layer.borderColor = XZFS_HEX_RGB(@"#FE4300").CGColor;
    bottomView.layer.borderWidth = 1;
    [self.mainView addSubview:bottomView];
    
    
    UILabel * _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bottomView.width/2, BottomHeight)];
    _priceLab.font = XZFS_S_FONT(15);
    _priceLab.textColor = XZFS_HEX_RGB(@"#FE4300");
    _priceLab.text = @"总价：￥8888";
    _priceLab.textAlignment = NSTextAlignmentCenter;
    [bottomView addSubview:_priceLab];
    
    UIButton * payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(bottomView.width/2, 0, bottomView.width/2, BottomHeight);
    [payBtn setTitle:@"去支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    payBtn.backgroundColor = XZFS_HEX_RGB(@"#FE4300");
    payBtn.titleLabel.font = XZFS_S_BOLD_FONT(15);
    [payBtn addTarget:self action:@selector(goPay) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:payBtn];
}

-(void)goPay{

    NSLog(@"去支付，调用支付接口  %d",self.paySelect);
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
