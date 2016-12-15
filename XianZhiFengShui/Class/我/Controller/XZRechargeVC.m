//
//  XZRechargeVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

typedef enum : NSUInteger {
    RechargeAliPay,
    RechargeWeiXinPay,
} rechargeSelects;

#import "XZRechargeVC.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "WTPayManager.h"

@interface XZRechargeVC ()
@property (nonatomic,assign)rechargeSelects rechargeSelect;
@end

@implementation XZRechargeVC{
    UILabel * balance;//余额
    UITextField * inputMoneyTf;//输入金额
    UILabel * inputedMoneyLab;//到账
    UIView * moneyView;
    
    UIView * rechargeStyle;//
    
    UIButton * rechargeMoney;
    UILabel * bottomLab ;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = RandomColor(1);
    self.titelLab.text  =@"充值";
    [self setupInput];
    [self setupRechargeStyle];
    [self setupRechargeMoneyBtn];
    [self setupBottomLab];
    self.rechargeSelect = RechargeAliPay;
    // Do any additional setup after loading the view.
}

-(void)setupInput{
    moneyView = [[UIView alloc]initWithFrame:CGRectMake(0, 7, SCREENWIDTH, 101)];
    moneyView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:moneyView];
    
    NSArray * leftTitleArr = @[ @"账户余额",@"充值金额",@"到账" ];
    for (int i = 0; i<leftTitleArr.count; i++) {
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 12+i*32, 50, 12)];
        lab.text = leftTitleArr[i];
        lab.textColor = XZFS_TEXTBLACKCOLOR;
        lab.font = XZFS_S_FONT(12);
        [moneyView addSubview:lab];
        [lab sizeToFit];
        if (i==0) {
            balance = [[UILabel alloc]initWithFrame:CGRectMake(lab.right, lab.top,moneyView.width-lab.right-20, 12)];
            balance.text = @"--";
            balance.textColor = lab.textColor;
            balance.font = lab.font;
            balance.textAlignment = NSTextAlignmentRight;
            [moneyView addSubview:balance];
        }else if (i==1) {
            UIView * line = [[UIView alloc]initWithFrame:CGRectMake(lab.right+12, lab.bottom, moneyView.width-lab.right-12-70, 0.5)];
            line.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
            [moneyView addSubview:line];
            UILabel * yuanLab = [[UILabel alloc]initWithFrame:CGRectMake(line.right, 12+i*32, moneyView.width-line.right-20, 12)];
            yuanLab.text = @"元";
            yuanLab.textAlignment = NSTextAlignmentRight;
            yuanLab.textColor = lab.textColor;
            yuanLab.font = lab.font;
            [moneyView addSubview:yuanLab];
            
            inputMoneyTf = [[UITextField alloc]initWithFrame:CGRectMake(line.left, lab.top, line.width, lab.height-0.5)];
            inputMoneyTf.placeholder = @"请输入充值的金额";
            inputMoneyTf.textColor = lab.textColor;
            inputMoneyTf.font = XZFS_S_FONT(11);
            [moneyView addSubview:inputMoneyTf];
            
        }else if (i==2){
            inputedMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(lab.right, lab.top,moneyView.width-lab.right-20, 12)];
            inputedMoneyLab.text = @"--";
            inputedMoneyLab.textColor = lab.textColor;
            inputedMoneyLab.font = XZFS_S_BOLD_FONT(12);
            inputedMoneyLab.textAlignment = NSTextAlignmentRight;
            [moneyView addSubview:inputedMoneyLab];
        }
    }
 }


/**
 充值方式
 */
-(void)setupRechargeStyle{
    NSArray * rechargeStyleArr = @[ @"支付宝",@"微信支付"];
    NSArray * rechargeIcons = @[@"zhifubaochongzhi",@"weixinchongzhi"];
    rechargeStyle  = [[UIView alloc]initWithFrame:CGRectMake(0, moneyView.bottom+7, SCREENWIDTH, rechargeStyleArr.count*40+40)];
    rechargeStyle.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:rechargeStyle];
    
  
    
    for ( int i = 0; i<rechargeStyleArr.count; i++) {
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(65, 40+i*40, rechargeStyle.width-65-20, 0.5)];
        line.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
        [rechargeStyle addSubview:line];
        if (i==0) {
            line.frame =CGRectMake(20, 40+i*40, rechargeStyle.width-20-20, 0.5);
            UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(20, 13, 100, 14)];
            title.text = @"充值方式";
            title.textColor = XZFS_TEXTBLACKCOLOR;
            title.font = XZFS_S_BOLD_FONT(14);
            [rechargeStyle addSubview:title];
        }
        
        UIButton * rechargeStyleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rechargeStyleBtn.frame = CGRectMake(0, line.bottom, rechargeStyle.width, 40);
        [rechargeStyleBtn addTarget:self action:@selector(selectStyle:) forControlEvents:UIControlEventTouchUpInside];
        rechargeStyleBtn.tag = 100+i;
        rechargeStyleBtn.selected = NO;
        if (i==0) {
            rechargeStyleBtn.selected = YES;
        }
        [rechargeStyle addSubview:rechargeStyleBtn];
        
        UIButton * selectIvBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectIvBtn.frame = CGRectMake(40, 15, 10, 10);
        [selectIvBtn setImage:XZFS_IMAGE_NAMED(@"chongzhi_unselect") forState:UIControlStateNormal];
          [selectIvBtn setImage:XZFS_IMAGE_NAMED(@"chongzhi_select") forState:UIControlStateSelected];
        selectIvBtn.tag = 10;
        [rechargeStyleBtn addSubview:selectIvBtn];
        selectIvBtn.selected = rechargeStyleBtn.selected;
        
        UIImageView * iconIv = [[UIImageView alloc]initWithFrame:CGRectMake(selectIvBtn.right+15, 7.5, 25, 25)];
        iconIv.image = XZFS_IMAGE_NAMED(rechargeIcons[i]);
        iconIv.tag = 11;
        [rechargeStyleBtn addSubview:iconIv];
        
        UILabel * nameLab = [[UILabel alloc]initWithFrame:CGRectMake(iconIv.right+15, 14, 100, 12)];
        nameLab.text = rechargeStyleArr[i];
        nameLab.font = XZFS_S_FONT(12);
        nameLab.textColor = XZFS_TEXTBLACKCOLOR;
        nameLab.tag = 12;
        [rechargeStyleBtn addSubview:nameLab];
    }
}

-(void)setupRechargeMoneyBtn{
    rechargeMoney = [UIButton buttonWithType:UIButtonTypeCustom];
    rechargeMoney.frame = CGRectMake(20, rechargeStyle.bottom+35, SCREENWIDTH-40, 45);
    rechargeMoney.backgroundColor = XZFS_TEXTORANGECOLOR;
    [rechargeMoney setTitle:@"付款" forState:UIControlStateNormal];
    [rechargeMoney setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rechargeMoney.titleLabel.font = XZFS_S_BOLD_FONT(19);
    [rechargeMoney addTarget:self action:@selector(recharge:) forControlEvents:UIControlEventTouchUpInside];
    rechargeMoney.layer.masksToBounds = YES;
    rechargeMoney.layer.cornerRadius = 5;
    [self.mainView addSubview:rechargeMoney];
}

-(void)setupBottomLab{
    bottomLab = [[UILabel alloc]initWithFrame:CGRectMake(0, rechargeMoney.bottom+50, SCREENWIDTH, 100)];
    bottomLab.numberOfLines = 0;
    bottomLab.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:@"即日起至2017.01.01，先知客户端用户充值即享\n充100送50\n特大优惠！"];
    [att addAttribute:NSForegroundColorAttributeName value:XZFS_HEX_RGB(@"#C3C3C3") range:NSMakeRange(0, att.length)];
    [att addAttribute:NSForegroundColorAttributeName value:XZFS_TEXTORANGECOLOR range:[[att string]rangeOfString:@"充100送50"]];
    [att addAttribute:NSFontAttributeName value:XZFS_S_FONT(10) range:NSMakeRange(0, att.length)];
     [att addAttribute:NSFontAttributeName value:XZFS_S_FONT(12) range:[[att string]rangeOfString:@"充100送50"]];
    
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing  =5;
    style.alignment = NSTextAlignmentCenter;
    [att addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, att.length)];
    

    bottomLab.attributedText = att;
    [self.mainView addSubview:bottomLab];
}

#pragma mark action
-(void)selectStyle:(UIButton*)sender{
    for (int i = 0; i<2; i++) {
        UIButton * btn = (UIButton*)[rechargeStyle viewWithTag:(100+i)];
        NSLog(@"btn = %@",btn);
        btn.selected = NO;
        
        UIButton * iconBtn = (UIButton*)[btn viewWithTag:10];
        iconBtn.selected = btn.selected;
    }
    sender.selected = YES;
    self.rechargeSelect = sender.tag-100;
    UIButton * btn = (UIButton*)[sender viewWithTag:10];
    btn.selected = sender.selected;
    NSLog(@"sender.tag = %ld",(long)sender.tag);
}
-(void)recharge:(UIButton*)sender{
    NSLog(@"self.rechargeSelect = %lu",(unsigned long)self.rechargeSelect);
    switch (self.rechargeSelect) {
        case 0:{
            WTPayOrderItem * item = [[WTPayOrderItem alloc]init];
            item.orderName = @"哇哈哈八宝粥一瓶";
            item.orderPrice = @"0.01";//一分钱
            item.orderOutTradeNO = @"452AFAD3423432";
            item.orderBody = @"喝了以后爽歪歪";
            [WTPayManager wtPayOrderItem:item payType:WTPayTypeAli result:^(NSDictionary *payResult, NSString *error) {
                
                if (payResult) {
                    NSLog(@"%@", payResult[@"result"]);
                }else{
                    NSLog(@"%@", error);
                }
            }];
        }
            break;
        case 1:{
            WTPayOrderItem * item = [[WTPayOrderItem alloc]init];
            item.orderName = @"哇哈哈八宝粥一瓶";
            item.orderPrice = @"1";//一分钱
            item.orderOutTradeNO = @"452AFAD3423432";
            item.orderBody = @"喝了以后爽歪歪";
            [WTPayManager wtPayOrderItem:item payType:WTPayTypeWeixin result:^(NSDictionary *payResult, NSString *error) {
                
                if (payResult) {
                    NSLog(@"%@", payResult[@"result"]);
                }else{
                    NSLog(@"%@", error);
                }
            }];
        }
            break;
            
        default:
            break;
    }
    NSLog(@"去充值--%@钱",inputMoneyTf.text);
}

- (void)doAlipayPay
{
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"";
    NSString *privateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no =@"12313123131"; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = inputMoneyTf.text; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderInfo];
    NSString *signedString ;
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
