//
//  XZMasterServiceCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/4.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterServiceCell.h"

@implementation XZMasterServiceCell{
    UIImageView * _icon;
    UILabel * _name;
    UIImageView * _level;
    UILabel * _state;
    UILabel * _priceLab;
    UILabel * _appointCountLab;
    UILabel * _serviceSummaryLab;
    UILabel * _price;
    UILabel * _appointCount;
    UILabel * _serviceSummary;
    UIView * _firstLine;
    UIView * _secondLine;
    UIButton * _modifyBtn;
    UIButton * _deleteBtn;
    UIView * _bottomV;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        [self layoutCell];
    }
    
    return self;
}

-(void)setupCell{
    _icon = [[UIImageView alloc]init];
    _icon.backgroundColor = [UIColor redColor];
    
    _name = [self setupLabelWithFont:12 textColor:XZFS_TEXTBLACKCOLOR text:@"--" isBold:YES];
    
    _level = [[UIImageView alloc]init];
    _level.backgroundColor = [UIColor yellowColor];
    
    _state = [self setupLabelWithFont:11.5 textColor:XZFS_TEXTORANGECOLOR text:@"--" isBold:NO];
    _state.textAlignment = NSTextAlignmentRight;
    
    _firstLine = [UIView new];
    _firstLine.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
    
    _priceLab = [self setupLabelWithFont:11 textColor:XZFS_TEXTBLACKCOLOR text:@"服务项目:" isBold:NO];
    _appointCountLab = [self setupLabelWithFont:11 textColor:XZFS_TEXTBLACKCOLOR text:@"完成约见:" isBold:NO];
    _serviceSummaryLab = [self setupLabelWithFont:11 textColor:XZFS_TEXTBLACKCOLOR text:@"项目介绍:" isBold:NO];
    
    _price = [self setupLabelWithFont:11 textColor:XZFS_HEX_RGB(@"#898989") text:@"--" isBold:NO];
    _appointCount = [self setupLabelWithFont:11 textColor:XZFS_HEX_RGB(@"#898989") text:@"--" isBold:NO];
    _serviceSummary = [self setupLabelWithFont:11 textColor:XZFS_HEX_RGB(@"#898989") text:@"--" isBold:NO];
    _serviceSummary.numberOfLines = 0;
    
    _secondLine = [UIView new];
    _secondLine.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
    
    _modifyBtn = [self setupBtnWithTitle:@"修改" font:9 textColor:XZFS_TEXTORANGECOLOR selector:@selector(modefyService:)];
    _deleteBtn = [self setupBtnWithTitle:@"删除" font:9 textColor:XZFS_TEXTORANGECOLOR selector:@selector(deleteService:)];
    
    _bottomV = [UIView new];
    _bottomV.backgroundColor = XZFS_HEX_RGB(@"#F0EEEF");
    
    [self.contentView sd_addSubviews:@[ _icon,_name,_level,_state,_firstLine,_priceLab,_appointCountLab,_serviceSummaryLab,_price,_appointCount,_serviceSummary,_secondLine,_modifyBtn,_deleteBtn,_bottomV]];
}

-(void)layoutCell{
    _icon.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(self.contentView,8)
    .widthIs(35)
    .heightIs(35);
    
    _name.sd_layout
    .leftSpaceToView(_icon,18)
    .topSpaceToView(self.contentView,8)
    .heightIs(12);
    [_name setSingleLineAutoResizeWithMaxWidth:200];
    
    _level.sd_layout
    .leftSpaceToView(_icon,23)
    .topSpaceToView(_name,10)
    .widthIs(23)
    .heightIs(12);
    
    _state.sd_layout
    .rightSpaceToView(self.contentView,24)
    .topSpaceToView(self.contentView,18)
    .heightIs(11.5);
    [_state setSingleLineAutoResizeWithMaxWidth:200];
    
    _firstLine.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topSpaceToView(_icon,7)
    .heightIs(0.5);
    
    _priceLab.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(_firstLine,9)
    .heightIs(11);
    [_priceLab setSingleLineAutoResizeWithMaxWidth:100];
    
    _appointCountLab.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(_priceLab,20)
    .heightIs(11);
    [_appointCountLab setSingleLineAutoResizeWithMaxWidth:100];
    
    _serviceSummaryLab.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(_appointCountLab,20)
    .heightIs(11);
    [_serviceSummaryLab setSingleLineAutoResizeWithMaxWidth:100];
    
    _price.sd_layout
    .leftSpaceToView(_priceLab,14)
    .topEqualToView(_priceLab)
    .widthIs(100)
    .heightIs(11);
    
    _appointCount.sd_layout
    .leftSpaceToView(_appointCountLab,14)
    .topEqualToView(_appointCountLab)
    .widthIs(100)
    .heightIs(11);
    
    _serviceSummary.sd_layout
    .leftSpaceToView(_serviceSummaryLab,14)
    .topSpaceToView(_appointCount,19)
    .widthIs(SCREENWIDTH-85-24)
    .autoHeightRatio(0);
    
    _secondLine.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topSpaceToView(_serviceSummary,12)
    .heightIs(0.5);
    
    
    _deleteBtn.sd_layout
    .rightSpaceToView(self.contentView,24)
    .topSpaceToView(_secondLine,10)
    .widthIs(50)
    .heightIs(15);
    
    _modifyBtn.sd_layout
    .rightSpaceToView(_deleteBtn,50)
    .topSpaceToView(_secondLine,10)
    .widthIs(50)
    .heightIs(15);
    
    _bottomV.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topSpaceToView(_modifyBtn,10)
    .heightIs(5);

    [_icon.layer addSublayer:[Tool drawCornerWithRect:_icon.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:_icon.size borderWidth:0 strokeColor:[UIColor clearColor] fillColor:[UIColor clearColor]]];
    
    [_deleteBtn.layer addSublayer:[Tool drawCornerWithRect:_deleteBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(3, 3) borderWidth:0.5 strokeColor:XZFS_TEXTORANGECOLOR fillColor:[UIColor clearColor]]];
    
     [_modifyBtn.layer addSublayer:[Tool drawCornerWithRect:_modifyBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(3, 3) borderWidth:0.5 strokeColor:XZFS_TEXTORANGECOLOR fillColor:[UIColor clearColor]]];
}

-(void)setModel:(XZMasterModel *)model{
    _model = model;
    [_icon setImageWithURL:[NSURL URLWithString:model.icon] options:YYWebImageOptionProgressiveBlur];
    _name.text = model.name;
    _state.text = model.state;
    
    _price.text = [NSString stringWithFormat:@"%ld元",model.price];
    _appointCount.text = [NSString stringWithFormat:@"%d次",model.appointCount];
    _serviceSummary.text = model.summary;
    
    [self setupAutoHeightWithBottomView:_bottomV bottomMargin:0];

}




#pragma mark action
-(void)modefyService:(UIButton*)sender{
    NSLog(@"修改");
    if (self.modifyBlock) {
        self.modifyBlock(self.model,self.indexPath);
    }
}

-(void)deleteService:(UIButton*)sender{
    NSLog(@"删除");
    if (self.deleteBlock) {
        self.deleteBlock(self.model,self.indexPath);
    }

}

-(void)modifyServiceWithBlock:(ModifyMasterServiceBlock)block{
    self.modifyBlock = block;
}
-(void)deleteServiceWithBlock:(DeleteMasterServiceBlock)block{
    self.deleteBlock = block;
}

#pragma mark private
-(UILabel*)setupLabelWithFont:(int)font textColor:(UIColor*)color text:(NSString*)text isBold:(BOOL)isBold{
    UILabel * label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    label.text = text;
    label.font = isBold?XZFS_S_BOLD_FONT(font):XZFS_S_FONT(font);
    return label;
}

-(UIButton*)setupBtnWithTitle:(NSString*)title font:(int)font textColor:(UIColor*)color selector:(SEL)selector{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font = XZFS_S_FONT(font);
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
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
