//
//  XZOrderHeaderView.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/12.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZOrderHeaderView.h"

@implementation XZOrderHeaderView{
    UILabel * _nameLab;
    UILabel * _stateLab;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initOrderHeader];
    }
    return self;
}

-(void)initOrderHeader{
        _nameLab = [[UILabel alloc]init];
        _nameLab.backgroundColor = [UIColor clearColor];
        _nameLab.textColor =  XZFS_TEXTBLACKCOLOR;
        _nameLab.textAlignment =NSTextAlignmentLeft;
        _nameLab.font = XZFS_S_FONT(14);
    _nameLab.frame = CGRectMake(20, 10, 100, 14);
    
    
    _stateLab = [[UILabel alloc]init];
    _stateLab.backgroundColor = [UIColor clearColor];
    _stateLab.textColor =  XZFS_TEXTORANGECOLOR;
    _stateLab.textAlignment =NSTextAlignmentRight;
    _stateLab.font = XZFS_S_FONT(14);
    _stateLab.frame = CGRectMake(20, 10, SCREENWIDTH-40, 14);
  
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, _stateLab.bottom+9, SCREENWIDTH-40, 0.5)];
    line.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
   
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_nameLab];
    [self.contentView addSubview:_stateLab];
     [self.contentView addSubview:line];
}

-(void)setModel:(XZGoodsModel *)model{
    _model = model;
    _nameLab.text = model.storeName;
    [_nameLab sizeToFit];
    
    switch (model.state) {
        case orderWaitPay:
            _stateLab.text = @"等待支付";
            break;
        case orderSendOutGoods:
            _stateLab.text = @"卖家已发货";
            break;
        case orderSuccess:
            _stateLab.text = @"交易成功";
            break;
        case orderCancel:
            _stateLab.text = @"交易取消";
            break;
        default:
            break;
    }
}
@end
