//
//  XZYQXCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/6.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZYQXCell.h"

@implementation XZYQXCell{
    UILabel * _price;
    UILabel * _cancelReason;
    UILabel * _cancelTime;
    UILabel * _cancelPerson;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupYQXCell];
        [self layoutYQXCell];
    }
    return self;
}

-(void)setupYQXCell{
    _price = [self setupLabelWithFont:12 textColor:XZFS_TEXTBLACKCOLOR text:@"--" isBold:NO];
    _cancelTime = [self setupLabelWithFont:12 textColor:XZFS_TEXTBLACKCOLOR text:@"--" isBold:NO];
    _cancelReason = [self setupLabelWithFont:12 textColor:XZFS_TEXTBLACKCOLOR text:@"--" isBold:NO];
    _cancelPerson = [self setupLabelWithFont:12 textColor:XZFS_TEXTBLACKCOLOR text:@"--" isBold:NO];

    
    [self.contentView sd_addSubviews:@[ _price,_cancelTime,_cancelReason,_cancelPerson]];
}

-(void)layoutYQXCell{
    _price.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(self.line,11)
    .heightIs(12);
    [_price setSingleLineAutoResizeWithMaxWidth:(SCREENWIDTH-20*2)];
    
    _cancelReason.sd_layout
    .leftEqualToView(_price)
    .topSpaceToView(_price,15)
    .heightIs(12);
    [_cancelReason setSingleLineAutoResizeWithMaxWidth:(SCREENWIDTH-20*2)];
    
    _cancelTime.sd_layout
    .leftEqualToView(_cancelReason)
    .topSpaceToView(_cancelReason,15)
    .heightIs(12);
    [_cancelTime setSingleLineAutoResizeWithMaxWidth:(SCREENWIDTH-20*2)];
    
    _cancelPerson.sd_layout
    .leftEqualToView(_price)
    .topSpaceToView(_cancelTime,15)
    .heightIs(12);
    [_cancelPerson setSingleLineAutoResizeWithMaxWidth:(SCREENWIDTH-20*2)];
    
  }

-(void)setModel:(XZMasterOrderModel *)model{
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
    
    NSString * cancelTimeStr = model.cancelTime?:@"--";
    _cancelTime.text = [NSString stringWithFormat:@"取消时间:   %@",cancelTimeStr];
    
    NSString * cancelReasonStr = model.cancelReason?:@"--";
    _cancelReason.text = [NSString stringWithFormat:@"取消原因:   %@",cancelReasonStr];
    
    NSString * cancelPersonStr = model.cancelPerson?:@"--";
    _cancelPerson.text = [NSString stringWithFormat:@"取消人:   %@",cancelPersonStr];
    
    self.bottomV.sd_layout
    .topSpaceToView(_cancelPerson,8)
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
