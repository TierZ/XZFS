//
//  XZYYYCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/6.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZYYYCell.h"

#define FirstBtnWidth 50
#define SecondBtnWidth 65
#define ThirdBtnWidth  65
#define FourthBtnWidth 65

@implementation XZYYYCell{
    UILabel * _price;
    UILabel * _appointTime;
    UIView * _secondLine;
    
    UIButton * _sendMsg;
    UIButton* _modifyAppointTime;
    UIButton* _cancelAppoint;
    UIButton * _appointSucceed;

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupYYYCell];
        [self layoutYYYCell];
    }
    return self;
}

-(void)setupYYYCell{
    _price = [self setupLabelWithFont:12 textColor:XZFS_TEXTBLACKCOLOR text:@"--" isBold:NO];
    _appointTime = [self setupLabelWithFont:12 textColor:XZFS_TEXTBLACKCOLOR text:@"--" isBold:NO];

    _secondLine = [UIView new];
    _secondLine.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
    
    _sendMsg = [self setupBtnWithTitle:@"发消息" font:8 textColor:XZFS_TEXTORANGECOLOR selector:@selector(sendMsg:)];
    _modifyAppointTime = [self setupBtnWithTitle:@"修改约见时间" font:8 textColor:XZFS_TEXTORANGECOLOR selector:@selector(modifyAppointTime:)];
    _cancelAppoint = [self setupBtnWithTitle:@"取消约见" font:8 textColor:XZFS_TEXTORANGECOLOR selector:@selector(cancelAppoint:)];
    _appointSucceed = [self setupBtnWithTitle:@"完成约见" font:8 textColor:XZFS_TEXTORANGECOLOR selector:@selector(appointSucceed:)];
    
    [self.contentView sd_addSubviews:@[ _price,_appointTime,_secondLine,_sendMsg,_modifyAppointTime,_cancelAppoint,_appointSucceed]];
}

-(void)layoutYYYCell{
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
    
    float space = (SCREENWIDTH-FirstBtnWidth-SecondBtnWidth-ThirdBtnWidth-FourthBtnWidth)/5;
    
    _sendMsg.sd_layout
    .leftSpaceToView(self.contentView,space)
    .topSpaceToView(_secondLine,8)
    .widthIs(FirstBtnWidth)
    .heightIs(15);
    
    _modifyAppointTime.sd_layout
    .leftSpaceToView(_sendMsg,space)
    .topEqualToView(_sendMsg)
    .heightIs(15)
    .widthIs(SecondBtnWidth);
    
    _cancelAppoint.sd_layout
    .leftSpaceToView(_modifyAppointTime,space)
    .topEqualToView(_sendMsg)
    .heightIs(15)
    .widthIs(ThirdBtnWidth);
    
    _appointSucceed.sd_layout
    .leftSpaceToView(_cancelAppoint,space)
    .topEqualToView(_sendMsg)
    .heightIs(15)
    .widthIs(FourthBtnWidth);
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
    .topSpaceToView(_sendMsg,8)
    .leftEqualToView(self.contentView)
    .widthIs(SCREENWIDTH)
    .heightIs(3);
    
    [self setupAutoHeightWithBottomView:self.bottomV bottomMargin:0.5];
}

-(void)sendMsg:(UIButton*)sender{
    NSLog(@"发消息");
    if (self.block) {
        self.block(self.model,self.indexPath,YYYCellBtnSendMsg);
    }
}
-(void)modifyAppointTime:(UIButton*)sender{
    NSLog(@"修改约见时间");
    if (self.block) {
        self.block(self.model,self.indexPath,YYYCellBtnModify);
    }
}
-(void)cancelAppoint:(UIButton*)sender{
    NSLog(@"取消约见");
    if (self.block) {
        self.block(self.model,self.indexPath,YYYCellBtnCancel);
    }
}
-(void)appointSucceed:(UIButton*)sender{
    NSLog(@"约见成功");
    if (self.block) {
        self.block(self.model,self.indexPath,YYYCellBtnOk);
    }
}
-(void)yyycellBtnClickWithBlock:(YYYCellBtnActionBlock)block{
    self.block = block;
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
