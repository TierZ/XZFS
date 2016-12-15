//
//  XZOrderCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/9.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZOrderCell.h"

@implementation XZOrderCell{
    UIImageView * _picIv;
    UILabel * _nameLab;
    UILabel * _priceLab;
    UILabel * _countLab;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)setupCell{
    _picIv = [[UIImageView alloc]initWithFrame:CGRectMake(20, 1, 105, 105)];
    _picIv.backgroundColor = RandomColor(1);
    
    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(_picIv.right+18, 18, 200, 13)];
    _nameLab.textColor = XZFS_TEXTBLACKCOLOR;
    _nameLab.font = XZFS_S_FONT(13);
    
    _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(_nameLab.left, _nameLab.bottom+60, 200, 13)];
    _priceLab.textColor = XZFS_TEXTORANGECOLOR;
    _priceLab.font = XZFS_S_FONT(11);
    
    _countLab = [[UILabel alloc]initWithFrame:CGRectMake(20, _nameLab.bottom+62, SCREENWIDTH-40, 13)];
    _countLab.textAlignment =NSTextAlignmentRight;
    _countLab.textColor = XZFS_HEX_RGB(@"#C9CACA");
    _countLab.font = XZFS_S_FONT(8);
    
    [self.contentView sd_addSubviews:@[_picIv,_nameLab,_priceLab,_countLab]];
    
}

-(void)setModel:(XZGoodsModel *)model{
    _model = model;
    [_picIv setImageWithURL:[NSURL URLWithString:model.image] options:YYWebImageOptionProgressive];
    _nameLab.text = model.name;
    _priceLab.text = model.price;
    
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"X%@",model.counts]];
    [att addAttribute:NSFontAttributeName value:XZFS_S_FONT(8) range:[[att string]rangeOfString:@"X"]];
      [att addAttribute:NSFontAttributeName value:XZFS_S_FONT(7) range:[[att string]rangeOfString:model.counts]];
    
    [att addAttribute:NSForegroundColorAttributeName value:XZFS_HEX_RGB(@"#C9CACA") range:NSMakeRange(0, att.length)];
    _countLab.attributedText = att;
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
