//
//  XZGoodsCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/8.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZGoodsCell.h"

@interface XZGoodsCell ()
@property (nonatomic,strong)UIImageView * goodsIv;//图片
@property (nonatomic,strong)UILabel * nameLab;//名称
@property (nonatomic,strong)UILabel * priceLab;//价格
@property (nonatomic,strong)UILabel * expressPriceLab;//快递
@property (nonatomic,strong)UILabel * commentLab;//评价数
@property (nonatomic,strong)UIButton * addGoodsBtn;//加入购物车
@end
@implementation XZGoodsCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCell];
    }
    return self;
}
-(void)setupCell{
    
    [self.contentView.layer addSublayer: [Tool drawCornerWithRect:self.contentView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(2, 2) borderWidth:0.5 strokeColor:XZFS_HEX_RGB(@"#C9CACA") fillColor:[UIColor clearColor]]];

    
    
    [self.contentView sd_addSubviews:@[self.goodsIv,self.nameLab,self.priceLab,self.expressPriceLab,self.commentLab,self.addGoodsBtn]];
    
    self.goodsIv.sd_layout
    .leftSpaceToView(self.contentView,8)
    .topSpaceToView(self.contentView,5)
    .widthIs(self.contentView.width-16)
    .heightIs(self.contentView.width-16);
    
    self.nameLab.sd_layout
    .leftEqualToView(self.goodsIv)
    .topSpaceToView(self.goodsIv,11)
    .heightIs(13)
    .widthIs(self.contentView.width);
    
    self.priceLab.sd_layout
    .leftEqualToView(self.goodsIv)
    .topSpaceToView(self.nameLab,10)
    .heightIs(10)
    .widthIs(self.contentView.width);
    
    self.expressPriceLab.sd_layout
    .rightSpaceToView(self.contentView,8)
    .topSpaceToView(self.nameLab,10)
    .heightIs(8)
    .widthIs(self.contentView.width);
    
    self.commentLab.sd_layout
    .leftEqualToView(self.nameLab)
    .topSpaceToView(self.priceLab,12)
    .heightIs(9)
    .widthIs(self.contentView.width);
    
    
    self.addGoodsBtn.sd_layout
    .rightSpaceToView(self.contentView,15)
    .bottomSpaceToView(self.contentView,7)
    .widthIs(20)
    .heightIs(20);
    
}

-(void)refreshCellWithModel:(XZGoodsModel*)model{
    [self.goodsIv setImageWithURL:[NSURL URLWithString:model.image] options:YYWebImageOptionProgressive];
    self.nameLab.text = model.name;
    self.priceLab.text = [NSString stringWithFormat:@"￥%@",model.price];
    self.expressPriceLab.text = [NSString stringWithFormat:@"快递：%@",model.expressPrice];
    self.commentLab.text = [NSString stringWithFormat:@"%@条评论 %@好评",model.comment,model.wellComment];
}

//-(void)setModel:(XZGoodsModel *)model{
//    _model = model;
//    [self.goodsIv setImageWithURL:[NSURL URLWithString:model.image] options:YYWebImageOptionProgressive];
//    self.nameLab.text = model.name;
//    self.priceLab.text = [NSString stringWithFormat:@"￥%@",model.price];
//    self.expressPriceLab.text = [NSString stringWithFormat:@"快递：%@",model.expressPrice];
//    self.commentLab.text = [NSString stringWithFormat:@"%@条评论 %@好评",model.comment,model.wellComment];
//}

-(void)hideExpress:(BOOL)isHide{
    self.expressPriceLab.hidden = isHide;
    self.addGoodsBtn.hidden = !isHide;
}

#pragma mark action
-(void)addGoods:(UIButton*)sender{
    NSLog(@"添加到购物车");
}

#pragma mark getter
-(UIImageView *)goodsIv{
    if (!_goodsIv) {
        _goodsIv = [[UIImageView alloc]init];
        _goodsIv.backgroundColor = [UIColor redColor];
    }
    return _goodsIv;
}

-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.backgroundColor = [UIColor clearColor];
        _nameLab.textColor =  XZFS_TEXTBLACKCOLOR;
        _nameLab.textAlignment =NSTextAlignmentLeft;
        _nameLab.font = XZFS_S_FONT(13);
    }
    return _nameLab;
}

-(UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.backgroundColor = [UIColor clearColor];
        _priceLab.textColor =  XZFS_TEXTORANGECOLOR;
        _priceLab.textAlignment =NSTextAlignmentLeft;
        _priceLab.font = XZFS_S_FONT(10);
    }
    return _priceLab;
}

-(UILabel *)expressPriceLab{
    if (!_expressPriceLab) {
        _expressPriceLab = [[UILabel alloc]init];
        _expressPriceLab.backgroundColor = [UIColor clearColor];
        _expressPriceLab.textColor =  XZFS_TEXTLIGHTGRAYCOLOR;
        _expressPriceLab.textAlignment =NSTextAlignmentRight;
        _expressPriceLab.font = XZFS_S_FONT(8);
    }
    return _expressPriceLab;
}

-(UILabel *)commentLab{
    if (!_commentLab) {
        _commentLab = [[UILabel alloc]init];
        _commentLab.backgroundColor = [UIColor clearColor];
        _commentLab.textColor =  XZFS_TEXTLIGHTGRAYCOLOR;
        _commentLab.textAlignment =NSTextAlignmentLeft;
        _commentLab.font = XZFS_S_FONT(9);
    }
    return _commentLab;
}

-(UIButton *)addGoodsBtn{
    if (!_addGoodsBtn) {
        _addGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addGoodsBtn setImage:XZFS_IMAGE_NAMED(@"gouwuche_small") forState:UIControlStateSelected];
        [_addGoodsBtn setImage:XZFS_IMAGE_NAMED(@"gouwuche_small_unselect") forState:UIControlStateNormal];
        [_addGoodsBtn addTarget:self action:@selector(addGoods:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addGoodsBtn;
}
@end
