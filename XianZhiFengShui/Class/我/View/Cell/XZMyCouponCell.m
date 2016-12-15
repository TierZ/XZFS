//
//  XZMyCouponCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/21.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyCouponCell.h"
@interface XZMyCouponCell ()
@property (nonatomic,strong)UIImageView * bgIv;
@property (nonatomic,strong)UILabel * priceLab;//价格
@property (nonatomic,strong)UILabel * validDateLab;//有效期
@property (nonatomic,strong)UILabel * canUseLab;//可用人群
@property (nonatomic,strong)UILabel * useRangeLab;//使用范围
@end
@implementation XZMyCouponCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        [self layoutCell];
        [self setupBaseItmes];
    }
    return  self;
}

-(void)setupCell{
    self.contentView.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
    [self.contentView addSubview:self.bgIv];
    [self.bgIv addSubview:self.priceLab];
    [self.bgIv addSubview:self.validDateLab];
    [self.bgIv addSubview:self.canUseLab];
    [self.bgIv addSubview:self.useRangeLab];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)layoutCell{
    self.bgIv.frame = CGRectMake(19, 7, SCREENWIDTH-38, 80);
    self.priceLab.frame = CGRectMake(20, 35, 68, 17);
    self.validDateLab.frame =CGRectMake(114, 14,self.bgIv.width-120, 10);
    self.canUseLab.frame =CGRectMake(114, self.validDateLab.bottom+13,self.bgIv.width-120, 10);
    self.useRangeLab.frame =CGRectMake(114,self.canUseLab.bottom+13,self.bgIv.width-120, 10);
}

-(void)setupBaseItmes{
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(88, 18, 0.5, 50)];
    line.backgroundColor = XZFS_HEX_RGB(@"#EFEFEF");
    [self.bgIv addSubview:line];
    
    for (int i = 0; i<3; i++) {
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(line.right+13, 17+i*23, 4.5, 4.5)];
        iv.tag = 10+i;
        iv.backgroundColor = [UIColor blackColor];
        [self.bgIv addSubview:iv];
    }
}

-(void)outOfData:(BOOL)isOut{
    _priceLab.textColor = isOut?XZFS_HEX_RGB(@"#B5B6B6"):XZFS_TEXTORANGECOLOR;
    _validDateLab.textColor = isOut?XZFS_HEX_RGB(@"#B5B6B6"):XZFS_TEXTBLACKCOLOR;
    _canUseLab.textColor = isOut?XZFS_HEX_RGB(@"#B5B6B6"):XZFS_TEXTBLACKCOLOR;
_useRangeLab.textColor = isOut?XZFS_HEX_RGB(@"#B5B6B6"):XZFS_TEXTBLACKCOLOR;
    for (int i = 0; i<3; i++) {
        UIImageView * iv = (UIImageView*)[self.bgIv viewWithTag:(10+i)];
        iv.backgroundColor =  isOut?XZFS_HEX_RGB(@"#B5B6B6"):XZFS_TEXTBLACKCOLOR;

    }
    
}

#pragma mark refresh
-(void)refreshCellWithModel:(MyCouponModel*)model{
    if (model) {
        self.priceLab.text = [NSString stringWithFormat:@"%@元",model.price];
        self.validDateLab.text = [NSString stringWithFormat:@"有效期%@",model.time];
        self.canUseLab.text = model.warn;
        self.useRangeLab.text = model.useRange;
    }
}

#pragma mark getter
-(UIImageView *)bgIv{
    if (!_bgIv) {
        _bgIv = [[UIImageView alloc]init];
        _bgIv.image = XZFS_IMAGE_NAMED(@"youhuiquanbeijing");
    }
    return _bgIv;
}

-(UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.backgroundColor = [UIColor clearColor];
        _priceLab.textColor =  XZFS_TEXTORANGECOLOR;
        _priceLab.textAlignment =NSTextAlignmentLeft;
      
        _priceLab.font = XZFS_S_FONT(16);
    }
    return _priceLab;
}

-(UILabel *)validDateLab{
    if (!_validDateLab) {
        _validDateLab = [[UILabel alloc]init];
        _validDateLab.backgroundColor = [UIColor clearColor];
        _validDateLab.textColor =  XZFS_TEXTBLACKCOLOR;
        _validDateLab.textAlignment =NSTextAlignmentLeft;
        _validDateLab.font = XZFS_S_FONT(10);
    }
    return _validDateLab;
}

-(UILabel *)canUseLab{
    if (!_canUseLab) {
        _canUseLab = [[UILabel alloc]init];
        _canUseLab.backgroundColor = [UIColor clearColor];
        _canUseLab.textColor =  XZFS_TEXTBLACKCOLOR;
        _canUseLab.textAlignment =NSTextAlignmentLeft;
        _canUseLab.font = XZFS_S_FONT(10);
    }
    return _canUseLab;
}

-(UILabel *)useRangeLab{
    if (!_useRangeLab) {
        _useRangeLab = [[UILabel alloc]init];
        _useRangeLab.backgroundColor = [UIColor clearColor];
        _useRangeLab.textColor =  XZFS_TEXTBLACKCOLOR;
        _useRangeLab.textAlignment =NSTextAlignmentLeft;
        _useRangeLab.font = XZFS_S_FONT(10);
    }
    return _useRangeLab;
}

#pragma mark..
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
