//
//  XZShoppingCartCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/9.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZShoppingCartCell.h"

@interface XZShoppingCartCell ()
@property (nonatomic,strong)UIButton* selectBtn;
@property (nonatomic,strong)UIImageView * picIv;
@property (nonatomic,strong)UILabel * nameLab;
@property (nonatomic,strong)UILabel * priceLab;
@property (nonatomic,strong)UIButton * minusBtn;
@property (nonatomic,strong)UIButton * plusBtn;
@property (nonatomic,strong)UILabel * countLab;
@end
@implementation XZShoppingCartCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setupCell{
    [self.contentView sd_addSubviews:@[self.selectBtn,self.picIv,self.nameLab,self.priceLab,self.minusBtn,self.countLab,self.plusBtn]];
    self.selectBtn.frame = CGRectMake(25, 45, 17, 17);
    self.picIv.frame = CGRectMake(self.selectBtn.right+14, 1, 105, 105);
    self.nameLab.frame = CGRectMake(self.picIv.right+15, 20, 200, 13);
    self.priceLab.frame = CGRectMake(self.nameLab.left, 97, 100, 11);
    self.plusBtn.frame = CGRectMake(SCREENWIDTH-20-14, 93, 14, 14);
    
     self.countLab.frame = CGRectMake(self.plusBtn.left-35 , 96, 35, 10);
    self.minusBtn.frame = CGRectMake(self.countLab.left-14, self.plusBtn.top, 14, 14);
}

-(void)setModel:(XZGoodsModel *)model{
    _model = model;
    [self.picIv setImageWithURL:[NSURL URLWithString:model.image] options:YYWebImageOptionProgressive];
    self.nameLab.text = model.name;
    self.priceLab.text = model.price;
    self.countLab.text = model.selectCount;
}

#pragma mark action
-(void)selectGoods:(UIButton*)sender{
    sender.selected  =!sender.selected;
}
-(void)minusCount:(UIButton*)sender{
    NSLog(@"减一");
}

-(void)plusCount:(UIButton*)sender{
    NSLog(@"加一");
}
#pragma mark getter
-(UIButton *)selectBtn{//17*17
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:XZFS_IMAGE_NAMED(@"weixuanzhong") forState:UIControlStateNormal];
        [_selectBtn setImage:XZFS_IMAGE_NAMED(@"xuanzhong") forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectGoods:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}

-(UIImageView *)picIv{
    if (!_picIv) {
        _picIv = [[UIImageView alloc]init];
        _picIv.backgroundColor = [UIColor redColor];
    }
    return _picIv;
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
        _priceLab.font = XZFS_S_FONT(11);
    }
    return _priceLab;
}

-(UIButton *)minusBtn{
    if (!_minusBtn) {
        _minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_minusBtn setImage:XZFS_IMAGE_NAMED(@"minus") forState:UIControlStateNormal];
        [_minusBtn addTarget:self action:@selector(minusCount:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minusBtn;
}

-(UIButton *)plusBtn{
    if (!_plusBtn) {
        _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusBtn setImage:XZFS_IMAGE_NAMED(@"plus") forState:UIControlStateNormal];
        [_plusBtn addTarget:self action:@selector(plusCount:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusBtn;
}

-(UILabel *)countLab{
    if (!_countLab) {
        _countLab = [[UILabel alloc]init];
        _countLab.backgroundColor = [UIColor clearColor];
        _countLab.textColor =  XZFS_TEXTBLACKCOLOR;
        _countLab.textAlignment =NSTextAlignmentCenter;
        _countLab.font = XZFS_S_FONT(9);
    }
    return _countLab;
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
