//
//  XZOrderFooterView.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/12.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZOrderFooterView.h"

@implementation XZOrderFooterView{
    UILabel * _priceLab;
    UIButton * _payBtn;//去支付
    UIButton * _cancelBtn;//取消订单
    UIButton * _certionReceiveBtn;//确认收货
    UIButton * _delectOrderBtn;//删除订单
    UIButton * _reBuyBtn;//再次购买
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier: reuseIdentifier];
    if (self) {
        [self initOrderFooter];
    }
    return self;
}

-(void)initOrderFooter{
    self.contentView.backgroundColor = XZFS_HEX_RGB(@"#F2EEED");
    
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 84)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 14, SCREENWIDTH-40, 12)];
    _priceLab.textColor = XZFS_TEXTBLACKCOLOR;
    _priceLab.font = XZFS_S_FONT(12);
    [bgView addSubview:_priceLab];
    
    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(20, _priceLab.bottom+14, SCREENWIDTH-40, 0.5)];
    line1.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
    [bgView addSubview:line1];
    
    _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _payBtn.frame = CGRectMake(135, line1.bottom+8, 70, 25);
    _payBtn.hidden = NO;
    [_payBtn setTitle:@"去支付" forState:UIControlStateNormal];
    [_payBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
    _payBtn.titleLabel.font = XZFS_S_FONT(14);
    [_payBtn addTarget:self action:@selector(payOrder:) forControlEvents:UIControlEventTouchUpInside];
    [_payBtn.layer addSublayer: [Tool drawCornerWithRect:_payBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(2, 2) borderWidth:0.5 strokeColor:XZFS_TEXTORANGECOLOR fillColor:[UIColor clearColor]]];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(SCREENWIDTH-70-20, line1.bottom+8, 70, 25);
     _cancelBtn.hidden = NO;
    [_cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = XZFS_S_FONT(14);
    [_cancelBtn addTarget:self action:@selector(cancelOrder:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn.layer addSublayer: [Tool drawCornerWithRect:_cancelBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(2, 2) borderWidth:0.5 strokeColor:XZFS_TEXTORANGECOLOR fillColor:[UIColor clearColor]]];
    
    _certionReceiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _certionReceiveBtn.frame = CGRectMake(135, line1.bottom+8, 70, 25);
     _certionReceiveBtn.hidden = YES;
    [_certionReceiveBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    [_certionReceiveBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
    _certionReceiveBtn.titleLabel.font = XZFS_S_FONT(14);
    [_certionReceiveBtn addTarget:self action:@selector(certainOrder:) forControlEvents:UIControlEventTouchUpInside];
    [_certionReceiveBtn.layer addSublayer:  [Tool drawCornerWithRect:_certionReceiveBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(2, 2) borderWidth:0.5 strokeColor:XZFS_TEXTORANGECOLOR fillColor:[UIColor clearColor]]];
    
    _delectOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _delectOrderBtn.frame = CGRectMake(SCREENWIDTH-70-20, line1.bottom+8, 70, 25);
     _delectOrderBtn.hidden = YES;
    [_delectOrderBtn setTitle:@"删除订单" forState:UIControlStateNormal];
    [_delectOrderBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
    _delectOrderBtn.titleLabel.font = XZFS_S_FONT(14);
    [_delectOrderBtn addTarget:self action:@selector(deleteOrder:) forControlEvents:UIControlEventTouchUpInside];
    [_delectOrderBtn.layer addSublayer: [Tool drawCornerWithRect:_delectOrderBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(2, 2) borderWidth:0.5 strokeColor:XZFS_TEXTORANGECOLOR fillColor:[UIColor clearColor]]];
    
    _reBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _reBuyBtn.frame = CGRectMake(135, line1.bottom+8, 70, 25);
    _reBuyBtn.hidden = YES;
    [_reBuyBtn setTitle:@"再次购买" forState:UIControlStateNormal];
    [_reBuyBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
    _reBuyBtn.titleLabel.font = XZFS_S_FONT(14);
     [_reBuyBtn addTarget:self action:@selector(rebuyOrder:) forControlEvents:UIControlEventTouchUpInside];
    [_reBuyBtn.layer addSublayer:[Tool drawCornerWithRect:_reBuyBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(2, 2) borderWidth:0.5 strokeColor:XZFS_TEXTORANGECOLOR fillColor:[UIColor clearColor]]];

    
    [bgView sd_addSubviews:@[_payBtn,_cancelBtn,_certionReceiveBtn,_delectOrderBtn,_reBuyBtn]];
}

-(void)setModel:(XZGoodsModel *)model{
    _model = model;
    switch (model.state) {
        case orderWaitPay:{
            _payBtn.hidden = NO;
            _cancelBtn.hidden = NO;
            _certionReceiveBtn.hidden = YES;
            _delectOrderBtn.hidden = YES;
            _reBuyBtn.hidden = YES;
        }
            break;
        case orderSendOutGoods:{
            _payBtn.hidden = YES;
            _cancelBtn.hidden = YES;
            _certionReceiveBtn.hidden = NO;
            _delectOrderBtn.hidden = NO;
            _reBuyBtn.hidden = YES;
        }
            break;
        case orderSuccess:{
            _payBtn.hidden = YES;
            _cancelBtn.hidden = YES;
            _certionReceiveBtn.hidden = YES;
            _delectOrderBtn.hidden = NO;
            _reBuyBtn.hidden = NO;
        }
            break;
        case orderCancel:{
            _payBtn.hidden = YES;
            _cancelBtn.hidden = YES;
            _certionReceiveBtn.hidden = YES;
            _delectOrderBtn.hidden = NO;
            _reBuyBtn.hidden = NO;
        }
            break;
            
        default:
            break;
    }
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]init];
    
    NSMutableAttributedString * att1 = [[NSMutableAttributedString alloc]initWithString:@"共3件商品 合计:￥162.00元 "];
    [att1 addAttribute:NSFontAttributeName value:XZFS_S_FONT(12) range:NSMakeRange(0, att1.length)];
    [att appendAttributedString:att1];
     NSMutableAttributedString * att2 = [[NSMutableAttributedString alloc]initWithString:@"（含邮费￥0.00元）"];
     [att2 addAttribute:NSFontAttributeName value:XZFS_S_FONT(9) range:NSMakeRange(0, att2.length)];
    [att appendAttributedString:att2];
    
    [att addAttribute:NSForegroundColorAttributeName value:XZFS_HEX_RGB(@"#333333") range:NSMakeRange(0, att.length)];
    _priceLab.attributedText = att;
    

}

#pragma mark action
-(void)payOrder:(UIButton*)sender{
    NSLog(@"去支付");
}
-(void)cancelOrder:(UIButton*)sender{
    NSLog(@"取消订单");
}
-(void)certainOrder:(UIButton*)sender{
    NSLog(@"确认收货")
}
-(void)deleteOrder:(UIButton*)sender{
    NSLog(@"删除订单");
}
-(void)rebuyOrder:(UIButton*)sender{
    NSLog(@"再次购买");
}
@end
