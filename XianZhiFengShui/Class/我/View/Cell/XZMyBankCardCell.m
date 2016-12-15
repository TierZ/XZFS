//
//  XZMyBankCardCell.m
//  XianZhiFengShui
//
//  Created by 左晓东 on 16/11/17.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyBankCardCell.h"

@interface XZMyBankCardCell ()
@property (nonatomic,strong)UIImageView * bankImage;//卡图片
@property (nonatomic,strong)UILabel * cardName;//卡名 类型
@property (nonatomic,strong)UILabel * cardNum;//卡末位
@property (nonatomic,strong)UIView * contentBg;
@property (nonatomic,strong)UIImageView * arrow;

@end
@implementation XZMyBankCardCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        self.contentView.backgroundColor = XZFS_HEX_RGB(@"#F0EEEF");
    }
    return self;
}

-(void)setupCell{
    [self.contentBg sd_addSubviews:@[ self.bankImage,self.cardName,self.cardNum,self.arrow]];
    [self.contentView addSubview:self.contentBg];
    
    _contentBg.sd_layout
    .leftEqualToView(self.contentView)
    .topSpaceToView(self.contentView,7)
    .widthIs(SCREENWIDTH)
    .heightIs(71);
    
    _bankImage.sd_layout
    .leftSpaceToView(_contentBg,32)
    .topSpaceToView(_contentBg,15)
    .widthIs(39)
    .heightIs(39);
    
    _cardName.sd_layout
    .leftSpaceToView(_bankImage,24)
    .topSpaceToView(_contentBg,18)
    .heightIs(15);
    [_cardName setSingleLineAutoResizeWithMaxWidth:200];
    
    _cardNum.sd_layout
    .leftEqualToView(_cardName)
    .topSpaceToView(_cardName,10)
    .heightIs(12);
    [_cardNum setSingleLineAutoResizeWithMaxWidth:200];

    _arrow.sd_layout
    .rightSpaceToView(_contentBg,21)
    .topSpaceToView(_contentBg,31.5)
    .widthIs(8)
    .heightIs(15);

}

-(void)setModel:(XZBankCardModel *)model{
    _model = model;
    [_bankImage setImageWithURL:[NSURL URLWithString:model.bankCardUrl] placeholder:[UIImage imageNamed:@""]];
    _cardName.text = model.cardName;
    _cardNum.text = model.cardNum;
}

#pragma mark getter

-(UIView *)contentBg{
    if (!_contentBg) {
        _contentBg = [UIView new];
        _contentBg.backgroundColor = [UIColor whiteColor];
    }
    return _contentBg;
}
-(UIImageView *)bankImage{
    if (!_bankImage) {
        _bankImage = [[UIImageView alloc]init];
        _bankImage.backgroundColor = [UIColor redColor];
    }
    return _bankImage;
}

-(UILabel *)cardName{
    if (!_cardName) {
        _cardName = [[UILabel alloc]init];
        _cardName.backgroundColor = [UIColor clearColor];
        _cardName.textColor = XZFS_TEXTBLACKCOLOR;
        _cardName.font = XZFS_S_FONT(15);
        
    }
    return _cardName;
}

-(UILabel *)cardNum{
    if (!_cardNum) {
        _cardNum = [[UILabel alloc]init];
        _cardNum.backgroundColor = [UIColor clearColor];
        _cardNum.textColor = XZFS_TEXTBLACKCOLOR;
        _cardNum.font = XZFS_S_FONT(12);
        
    }
    return _cardNum;

}

-(UIImageView *)arrow{
    if (!_arrow) {
        _arrow = [[UIImageView alloc]init];
        _arrow.backgroundColor = [UIColor orangeColor];
    }
    return _arrow;
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
