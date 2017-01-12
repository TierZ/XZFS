//
//  XZYYJCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/6.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZYYJCell.h"

@implementation XZYYJCell{
    UILabel * _price;
    UILabel * _appointTime;
    UIView * _secondLine;
    
    UIButton * _evaluateBtn;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupYYJCell];
        [self layoutYYJCell];
    }
    return self;
}

-(void)setupYYJCell{
    _price = [self setupLabelWithFont:12 textColor:XZFS_TEXTBLACKCOLOR text:@"--" isBold:NO];
    _appointTime = [self setupLabelWithFont:12 textColor:XZFS_TEXTBLACKCOLOR text:@"--" isBold:NO];
    
    _secondLine = [UIView new];
    _secondLine.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
    
    _evaluateBtn = [self setupBtnWithTitle:@"完成约见要评价" font:8 textColor:XZFS_TEXTORANGECOLOR selector:@selector(evaluate:)];
    
    [self.contentView sd_addSubviews:@[ _price,_appointTime,_secondLine,_evaluateBtn]];
}

-(void)layoutYYJCell{
    _price.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(self.line,11)
    .heightIs(12);
    [_price setSingleLineAutoResizeWithMaxWidth:(SCREENWIDTH-20*2)];
    
    _appointTime.sd_layout
    .leftEqualToView(_price)
    .topSpaceToView(_price,15)
    .heightIs(12);
    [_appointTime setSingleLineAutoResizeWithMaxWidth:(SCREENWIDTH-20*2)];
    
    _secondLine.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(_appointTime,15)
    .widthIs(SCREENWIDTH-20*2)
    .heightIs(0.5);

    _evaluateBtn.sd_layout
    .rightSpaceToView(self.contentView,22)
    .topSpaceToView(_secondLine,9)
    .heightIs(15)
    .widthIs(70);
}

-(void)evaluate:(UIButton*)sender{
    NSLog(@"完成约见要评价");
}

-(void)setModel:(XZMasterOrderModel *)model{
    _model = model;
    [self.icon setImageWithURL:[NSURL URLWithString:model.icon] options:YYWebImageOptionProgressiveBlur];
    self.service.text = model.service?:@"--";
    self.time.text = model.time?:@"--";
    self.address.text = model.location?:@"--";
    NSString * priceStr = model.price?:@"--";
    
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"预约项目:   %@-%@知币", self.service.text,priceStr]];
    [att addAttribute:NSFontAttributeName value:XZFS_S_FONT(12) range:NSMakeRange(0, att.length)];
    [att addAttribute:NSForegroundColorAttributeName value:XZFS_TEXTBLACKCOLOR range:NSMakeRange(0, att.length)];
    [att addAttribute:NSForegroundColorAttributeName value:XZFS_TEXTORANGECOLOR range:[[att string]rangeOfString:[NSString stringWithFormat:@"%@-%@",self.service.text,priceStr]]];
    _price.attributedText = att;
    
    NSString * appointTimeStr = model.appointTime?:@"--";
    _appointTime.text = [NSString stringWithFormat:@"预约时间:   %@",appointTimeStr];
    
    self.bottomV.sd_layout
    .topSpaceToView(_evaluateBtn,8)
    .leftEqualToView(self.contentView)
    .widthIs(SCREENWIDTH)
    .heightIs(3);
    
    [self setupAutoHeightWithBottomView:self.bottomV bottomMargin:0.5];

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
