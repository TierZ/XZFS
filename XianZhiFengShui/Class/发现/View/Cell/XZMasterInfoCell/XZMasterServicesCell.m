//
//  XZMasterServicesCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterServicesCell.h"
@interface XZMasterServicesCell ()
@property (nonatomic,strong)UILabel * titleLab;//标题
@property (nonatomic,strong)UILabel * detailLab;//内容介绍
@property (nonatomic,strong)UIButton * priceBtn;
@property (nonatomic,strong)UIImageView * priceIv;//价格
@property (nonatomic,strong)UILabel * priceLab;//价格
@property (nonatomic,strong)UIButton * appointmentBtn;//预约
@end
@implementation XZMasterServicesCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}

-(void)setupCell{
    [self.contentView sd_addSubviews:@[self.titleLab,self.detailLab,self.priceIv,self.priceLab,self.appointmentBtn]];
    
    self.titleLab.sd_layout
    .leftSpaceToView(self.contentView,22)
    .topSpaceToView(self.contentView,12)
    .heightIs(12);
    [self.titleLab setSingleLineAutoResizeWithMaxWidth:200];
    
//    self.priceBtn.sd_layout
//    .topSpaceToView(self.contentView,35)
//    .leftSpaceToView(self.contentView,SCREENWIDTH-80)
//    .heightIs(14);
    self.priceIv.sd_layout
    .topSpaceToView(self.contentView,35)
    .leftSpaceToView(self.contentView,SCREENWIDTH-80)
    .widthIs(11)
    .heightIs(14);
    
    self.priceLab.sd_layout
    .topSpaceToView(self.contentView,38)
    .leftSpaceToView(self.priceIv,5)
    .rightSpaceToView(self.contentView,10)
    .heightIs(9);
    
    
    self.detailLab.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(self.titleLab,8)
    .rightSpaceToView(self.priceIv,22)
    .autoHeightRatio(0);
    
    self.appointmentBtn.sd_layout
    .rightSpaceToView(self.contentView,28)
    .topSpaceToView(self.priceLab,11)
    .widthIs(40)
    .heightIs(14);
    
     [self.appointmentBtn.layer addSublayer:[Tool drawCornerWithRect:self.appointmentBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(2, 2) borderWidth:0.5 strokeColor:XZFS_TEXTORANGECOLOR fillColor:[UIColor clearColor]]];
}

-(void)setModel:(XZMasterInfoServiceModel *)model{
    _model = model;
    self.titleLab.text = model.serviceName;
    self.detailLab.text = model.serviceContent;
    self.priceLab.text = [NSString stringWithFormat:@"%@知币",model.servicePrice];
    self.appointmentBtn.selected = model.isAppointment;
    
    [self setupAutoHeightWithBottomViewsArray:@[self.appointmentBtn,self.detailLab] bottomMargin:6];
}


#pragma mark action
-(void)appointMaster:(UIButton*)sender{
    sender.selected = !sender.selected;
    NSLog(@"预约");
}

#pragma mark getter
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.backgroundColor = [UIColor clearColor];
        _titleLab.textColor =  XZFS_TEXTBLACKCOLOR;
        _titleLab.textAlignment =NSTextAlignmentLeft;
        _titleLab.font = XZFS_S_FONT(12);
    }
    return _titleLab;
}

-(UILabel *)detailLab{
    if (!_detailLab) {
        _detailLab = [[UILabel alloc]init];
        _detailLab.backgroundColor = [UIColor clearColor];
        _detailLab.textColor =  XZFS_HEX_RGB(@"#A6A7A7");
        _detailLab.textAlignment =NSTextAlignmentLeft;
        _detailLab.font = XZFS_S_FONT(10);
    }
    return _detailLab;
}

-(UIButton *)priceBtn{
    if (!_priceBtn) {
        _priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_priceBtn setTitle:@"--知币" forState:UIControlStateNormal];
        [_priceBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
        [_priceBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _priceBtn.titleLabel.font = XZFS_S_FONT(9);
    }
    return _priceBtn;
}

-(UIImageView *)priceIv{
    if (!_priceIv) {
        _priceIv = [[UIImageView alloc]init];
        _priceIv.backgroundColor = [UIColor redColor];
    }
    return _priceIv;
}

-(UILabel *)priceLab{
    if (!_priceLab) {
        _priceLab = [[UILabel alloc]init];
        _priceLab.backgroundColor = [UIColor clearColor];
        _priceLab.textColor =  XZFS_TEXTORANGECOLOR;
        _priceLab.textAlignment =NSTextAlignmentLeft;
        _priceLab.font = XZFS_S_FONT(9);
    }
    return _priceLab;
}

-(UIButton *)appointmentBtn{
    if (!_appointmentBtn) {
        _appointmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_appointmentBtn setTitle:@"预约" forState:UIControlStateNormal];
        [_appointmentBtn setTitle:@"已预约" forState:UIControlStateSelected];

        [_appointmentBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
        
        _appointmentBtn.titleLabel.font = XZFS_S_FONT(12);
        [_appointmentBtn addTarget:self action:@selector(appointMaster:) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _appointmentBtn;
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
