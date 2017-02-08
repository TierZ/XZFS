//
//  XZDYYCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/6.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZDYYCell.h"

@implementation XZDYYCell{

    
    UILabel * _price;
    UIView * _secondLine;
    UIButton * _appoint;
    UIButton * _submitTime;
   
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupDYYCell];
        [self layoutDYYCell];
    }
    return self;
}

-(void)setupDYYCell{
    _price = [self setupLabelWithFont:12 textColor:XZFS_TEXTBLACKCOLOR text:@"--" isBold:NO];
    _secondLine = [UIView new];
    _secondLine.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
    
    _appoint = [self setupBtnWithTitle:@"立即预约" font:8 textColor:XZFS_TEXTORANGECOLOR selector:@selector(appointNow:)];
    _submitTime = [self setupBtnWithTitle:@"提交约见时间" font:8 textColor:XZFS_TEXTORANGECOLOR selector:@selector(submitTime:)];
    
    [self.contentView sd_addSubviews:@[ _price,_secondLine,_appoint,_submitTime]];
}

-(void)layoutDYYCell{
    _price.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(self.line,11)
    .heightIs(12);
    [_price setSingleLineAutoResizeWithMaxWidth:(SCREENWIDTH-20*2)];
    
    _secondLine.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(_price,11)
    .widthIs(SCREENWIDTH-20*2)
    .heightIs(0.5);
    
    _submitTime.sd_layout
    .rightSpaceToView(self.contentView,20)
    .topSpaceToView(_secondLine,8)
    .widthIs(65)
    .heightIs(15);
    
    _appoint.sd_layout
    .rightSpaceToView(_submitTime,34)
    .topEqualToView(_submitTime)
    .heightIs(15)
    .widthIs(50);
}

-(void)setModel:(XZMasterOrderModel *)model{
    _model = model;
    [self.icon setImageWithURL:[NSURL URLWithString:model.icon] options:YYWebImageOptionProgressiveBlur];
    self.service.text = model.service?:@"";
    self.time.text = model.time?:@"";
    self.address.text = model.location?:@"";
    NSString * priceStr = model.price?:@"";
    
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"预约项目:   %@-%@", self.service.text,priceStr]];
    [att addAttribute:NSFontAttributeName value:XZFS_S_FONT(12) range:NSMakeRange(0, att.length)];
    [att addAttribute:NSForegroundColorAttributeName value:XZFS_TEXTBLACKCOLOR range:NSMakeRange(0, att.length)];
    [att addAttribute:NSForegroundColorAttributeName value:XZFS_TEXTORANGECOLOR range:[[att string]rangeOfString:[NSString stringWithFormat:@"%@-%@",self.service.text,priceStr]]];
    _price.attributedText = att;
    
    self.bottomV.sd_layout
    .topSpaceToView(_submitTime,8)
    .leftEqualToView(self.contentView)
    .widthIs(SCREENWIDTH)
    .heightIs(3);
    
    [self setupAutoHeightWithBottomView:self.bottomV bottomMargin:0.5];
}

-(void)appointNow:(UIButton*)sender{
    NSLog(@"立即约见");
    if (self.appointNowBlock) {
        self.appointNowBlock(self.model,self.indexPath);
    }
}
-(void)submitTime:(UIButton*)sender{
    NSLog(@"提交约见时间");
    if (self.submitAppointTimeBlock) {
        self.submitAppointTimeBlock(self.model,self.indexPath);
    }
}

-(void)appointNowWithBlock:(AppointNowBlock)block{
    self.appointNowBlock = block;
}
-(void)submitAppointTimeWithBlock:(SubmitAppointTimeBlock)block{
    self.submitAppointTimeBlock = block;
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
