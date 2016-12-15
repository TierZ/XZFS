//
//  XZAddressCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/12.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZAddressCell.h"
#import "UIButton+XZImageTitleSpacing.h"

@implementation XZAddressCell{
    UILabel * _consigneeLab;//收货人
    UILabel * _phone;//手机号
    UILabel * _addressLab;//地址
    UIImageView * _addressIv;//地址
    UIView * _line;//
    UIButton * _defaultAddressBtn;//设置默认地址
    UIButton * _editBtn;//编辑
    UIButton * _deleteBtn;//删除
    UIView * _bottomV;
    BOOL _editBarHide;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupCell];
        [self layoutCell];
    }
    return self;
}

-(void)setupCell{
    _consigneeLab = [[UILabel alloc]init];
    _consigneeLab.font = XZFS_S_FONT(15);
    _consigneeLab.textColor = XZFS_TEXTBLACKCOLOR;
    
    _phone = [[UILabel alloc]init];
    _phone.font = XZFS_S_FONT(15);
    _phone.textColor = XZFS_TEXTBLACKCOLOR;
    _phone.textAlignment = NSTextAlignmentRight;
    
    _addressIv = [[UIImageView alloc]init];//19*21
    _addressIv.image = XZFS_IMAGE_NAMED(@"weizhi");
    
    _addressLab = [[UILabel alloc]init];
    _addressLab.font = XZFS_S_FONT(12);
    _addressLab.textColor = XZFS_TEXTBLACKCOLOR;
    _addressLab.numberOfLines = 0;
    
    _line = [UIView new];
    _line.backgroundColor = XZFS_HEX_RGB(@"#F6F7F7");
    
    _defaultAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_defaultAddressBtn setImage:XZFS_IMAGE_NAMED(@"xuanzhong") forState:UIControlStateSelected];
    [_defaultAddressBtn setTitle:@"默认地址" forState:UIControlStateSelected];
    
    [_defaultAddressBtn setImage:XZFS_IMAGE_NAMED(@"weixuanzhong") forState:UIControlStateNormal];
    [_defaultAddressBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
    
    [_defaultAddressBtn setTitleColor:XZFS_TEXTLIGHTGRAYCOLOR forState:UIControlStateNormal];
    [_defaultAddressBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateSelected];
    _defaultAddressBtn.titleLabel.font = XZFS_S_FONT(12);
    [_defaultAddressBtn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:3];
    [_defaultAddressBtn addTarget:self action:@selector(selectDefaultAddress:) forControlEvents:UIControlEventTouchUpInside];
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_editBtn setTitleColor:XZFS_TEXTLIGHTGRAYCOLOR forState:UIControlStateNormal];
    [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    _editBtn.titleLabel.font = XZFS_S_FONT(12);
    [_editBtn setImage:XZFS_IMAGE_NAMED(@"huatibianji") forState:UIControlStateNormal];
    [_editBtn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:3];
    [_editBtn addTarget:self action:@selector(editAddress:) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setTitleColor:XZFS_TEXTLIGHTGRAYCOLOR forState:UIControlStateNormal];
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    _deleteBtn.titleLabel.font = XZFS_S_FONT(12);
    [_deleteBtn setImage:XZFS_IMAGE_NAMED(@"huatishanchu") forState:UIControlStateNormal];
    [_deleteBtn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:3];
    [_deleteBtn addTarget:self action:@selector(deleteAddress:) forControlEvents:UIControlEventTouchUpInside];
    
    _bottomV = [UIView new];
    _bottomV.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
    
    [self.contentView sd_addSubviews:@[_consigneeLab,_phone,_addressIv,_addressLab,_line,_defaultAddressBtn,_editBtn,_deleteBtn,_bottomV]];
}

-(void)layoutCell{
    _consigneeLab.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(self.contentView,23)
    .heightIs(15);
    [_consigneeLab setSingleLineAutoResizeWithMaxWidth:200];
    
    _phone.sd_layout
    .rightSpaceToView(self.contentView,20)
    .topSpaceToView(self.contentView,23)
    .heightIs(15);
    
    _addressIv.sd_layout
    .leftEqualToView(_consigneeLab)
    .topSpaceToView(_consigneeLab,17)
    .heightIs(21)
    .widthIs(19);
    
    _addressLab.sd_layout
    .leftSpaceToView(_addressIv,15)
    .topSpaceToView(_consigneeLab,19)
    .rightSpaceToView(self.contentView,20)
    .autoHeightRatio(0);
    _addressLab.isAttributedContent = YES;
    
    _line.sd_layout
    .leftEqualToView(_consigneeLab)
    .topSpaceToView(_addressLab,15)
    .widthIs(SCREENWIDTH-40)
    .heightIs(0.5);
//
    _defaultAddressBtn.sd_layout
    .leftSpaceToView(self.contentView,35)
    .topSpaceToView(_line,10)
    .widthIs(95)
    .heightIs(14);
    
    _deleteBtn.sd_layout
    .topEqualToView(_defaultAddressBtn)
    .rightSpaceToView(self.contentView,20)
    .widthIs(42)
    .heightIs(16);
    
    _editBtn.sd_layout
    .topEqualToView(_defaultAddressBtn)
    .rightSpaceToView(_deleteBtn,23)
    .widthIs(42)
    .heightIs(16);
    
    _bottomV.sd_layout
    .leftEqualToView(self.contentView)
    .topSpaceToView(_defaultAddressBtn,10)
    .widthIs(SCREENWIDTH)
    .heightIs(4);
}

-(void)hideEditBar:(BOOL)isHide{
    _editBarHide = isHide;
    
    _line.hidden = isHide;
    _defaultAddressBtn.hidden = isHide;
    _deleteBtn.hidden = isHide;
    _editBtn.hidden = isHide;
    _bottomV.hidden = isHide;
}

-(void)setModel:(XZAddressModel *)model{
    NSMutableAttributedString * address = [[NSMutableAttributedString alloc]initWithString:model.address];
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 5;
    [address addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, address.length)];
    
    _addressLab.attributedText = address;
    _addressLab.sd_layout.autoHeightRatio(0);
    
    _consigneeLab.text = [NSString stringWithFormat:@"收件人:%@",model.consignee];
    _phone.text = model.phone;

    [self hideEditBar:model.isHideEditBar];
    if (model.isHideEditBar) {
         [self setupAutoHeightWithBottomView:_addressLab bottomMargin:5];
    }else{
         [self setupAutoHeightWithBottomView:_bottomV bottomMargin:5];
    }
   

}


#pragma mark action
-(void)selectDefaultAddress:(UIButton*)sender{
    NSLog(@"设为默认地址");
    sender.selected = YES;
}

-(void)editAddress:(UIButton*)sender{
    NSLog(@"编辑地址");
}
-(void)deleteAddress:(UIButton*)sender{
    NSLog(@"删除地址");
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
