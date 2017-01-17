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
#import "XZMyAccountService.h"

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
            [self RequestRechargeInfoWithType:@"A"];
//            WTPayOrderItem * item = [[WTPayOrderItem alloc]init];
//            item.orderName = @"哇哈哈八宝粥一瓶";
//            item.orderPrice = @"0.01";//一分钱
//            item.orderOutTradeNO = @"452AFAD3423432";
//            item.orderBody = @"喝了以后爽歪歪";
//            [WTPayManager wtPayOrderItem:item payType:WTPayTypeAli result:^(NSDictionary *payResult, NSString *error) {
//                
//                if (payResult) {
//                    NSLog(@"%@", payResult[@"result"]);
//                }else{
//                    NSLog(@"%@", error);
//                }
//            }];
        }
            break;
        case 1:{
            [self RequestRechargeInfoWithType:@"W"];
//            WTPayOrderItem * item = [[WTPayOrderItem alloc]init];
//            item.orderName = @"哇哈哈八宝粥一瓶";
//            item.orderPrice = @"1";//一分钱
//            item.orderOutTradeNO = @"L2017011616513700000000000000005";
//            item.orderBody = @"喝了以后爽歪歪";
//            [WTPayManager wtPayOrderItem:item payType:WTPayTypeWeixin result:^(NSDictionary *payResult, NSString *error) {
//                
//                if (payResult) {
//                    NSLog(@"%@", payResult[@"result"]);
//                }else{
//                    NSLog(@"%@", error);
//                }
//            }];
        }
            break;
            
        default:
            break;
    }
    NSLog(@"去充值--%@钱",inputMoneyTf.text);
}

#pragma mark 网络
-(void)RequestRechargeInfoWithType:(NSString*)type{
    XZMyAccountService * rechargeService = [[XZMyAccountService alloc]initWithServiceTag:XZAccountRechargeTag];
    rechargeService.delegate = self;
    NSDictionary * dic = GETUserdefault(@"userInfos");
    NSString * userCode = [dic objectForKey:@"bizCode"]?:@"";
   NSString * ipStr =  [Tool getIPAddress:YES];
    int moneyCount = inputMoneyTf.text.intValue;
    [rechargeService accountRechargeWithUserCode:userCode ip:ipStr totalFee:moneyCount*100 totalCoin:moneyCount payType:type view:self.mainView];

}

-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    NSLog(@"支付信息 = %@",succeedHandle);
}
-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
