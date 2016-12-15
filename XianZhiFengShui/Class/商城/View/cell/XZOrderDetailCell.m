//
//  XZOrderDetailCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZOrderDetailCell.h"

@implementation XZOrderDetailCell{
    UILabel * _storeNameLab;
    UIImageView * _goodsIv;
    UILabel * _goodsNameLab;
    UILabel * _goodsIntroduceLab;
    UILabel * _priceLab;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
        [self setupCell];
        [self layoutCell];
    }
    return self;
}

-(void)setupCell{
    _storeNameLab = [[UILabel alloc]init];
    _storeNameLab.textColor = XZFS_TEXTBLACKCOLOR;
    _storeNameLab.font = XZFS_S_FONT(15);
    
    _goodsIv = [[UIImageView alloc]init];
    _goodsIv.backgroundColor = [UIColor redColor];

    _goodsNameLab = [[UILabel alloc]init];
    _goodsNameLab.font = XZFS_S_FONT(13);
    _goodsNameLab.textColor = XZFS_TEXTBLACKCOLOR;
    
    _goodsIntroduceLab = [[UILabel alloc]init];
    _goodsIntroduceLab.font = XZFS_S_FONT(12);
    _goodsIntroduceLab.textColor = XZFS_TEXTBLACKCOLOR;
    _goodsIntroduceLab.numberOfLines = 0;
      _goodsNameLab.isAttributedContent = YES;
    
    _priceLab = [[UILabel alloc]init];
    _priceLab.font = XZFS_S_FONT(10);
    _priceLab.textColor = XZFS_TEXTORANGECOLOR;
    
    [self.contentView sd_addSubviews:@[_storeNameLab,_goodsIv,_goodsNameLab,_goodsIntroduceLab,_priceLab]];
}

-(void)layoutCell{
    _storeNameLab.sd_layout
    .leftSpaceToView(self.contentView,22)
    .topSpaceToView(self.contentView,10)
    .heightIs(15);
    [_storeNameLab setSingleLineAutoResizeWithMaxWidth:200];
    
    _goodsIv.sd_layout
    .leftEqualToView(_storeNameLab)
    .topSpaceToView(_storeNameLab,10)
    .widthIs(90)
    .heightIs(87);
    
    _goodsNameLab.sd_layout
    .leftSpaceToView(_goodsIv,8)
    .topSpaceToView(_storeNameLab,18)
    .heightIs(13);
    [_goodsNameLab setSingleLineAutoResizeWithMaxWidth:200];
    
    _goodsIntroduceLab.sd_layout
    .leftEqualToView(_goodsNameLab)
    .topSpaceToView(_goodsNameLab,12)
    .rightSpaceToView(self.contentView,22)
    .autoHeightRatio(0);
    _goodsIntroduceLab.isAttributedContent = YES;
  
    
    _priceLab.sd_layout
    .leftEqualToView(_goodsNameLab)
    .topSpaceToView(_goodsIntroduceLab,12)
    .heightIs(10);
    [_priceLab setSingleLineAutoResizeWithMaxWidth:100];
}

-(void)setModel:(XZGoodsModel *)model{
    _model = model;
    _storeNameLab.text = model.storeName;
    [_goodsIv setImageWithURL:[NSURL URLWithString:model.price] options:YYWebImageOptionProgressive];
    _goodsNameLab.text = model.name;
    
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:model.introduce];
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 3;
    
    [att addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, att.length)];
    
    _goodsIntroduceLab.attributedText = att;
    _goodsIntroduceLab.sd_layout.autoHeightRatio(0);
    _priceLab.text = [NSString stringWithFormat:@"￥ %@",model.price];
    
    [self setupAutoHeightWithBottomViewsArray:@[_priceLab,_goodsIv] bottomMargin:9];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
