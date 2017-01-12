//
//  XZMasterOrderCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/6.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterOrderCell.h"

@implementation XZMasterOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        [self layoutCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setupCell{
    _icon = [[UIImageView alloc]init];
    _icon.backgroundColor = [UIColor redColor];

    
    _service = [self setupLabelWithFont:12 textColor:XZFS_TEXTBLACKCOLOR text:@"--" isBold:NO];
    _time = [self setupLabelWithFont:11 textColor:XZFS_HEX_RGB(@"#C9CACA") text:@"--" isBold:NO];
    _address = [self setupLabelWithFont:9 textColor:XZFS_HEX_RGB(@"#898989") text:@"--" isBold:NO];
    _time.textAlignment = NSTextAlignmentRight;
    
    _line = [UIView new];
    _line.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
    
    _bottomV = [UIView new];
    _bottomV.backgroundColor = XZFS_HEX_RGB(@"#F6F7F7");
    
    [self.contentView sd_addSubviews:@[ _icon,_service,_time,_address,_line,_bottomV ]];
}

-(void)layoutCell{
    _icon.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(self.contentView,8)
    .widthIs(35)
    .heightIs(35);
    [_icon.layer addSublayer:[Tool drawCornerWithRect:_icon.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(35/2, 35/2) borderWidth:0 strokeColor:[UIColor clearColor] fillColor:[UIColor clearColor]]];
    
    _service.sd_layout
    .leftSpaceToView(_icon,18)
    .topSpaceToView(self.contentView,8)
    .heightIs(12);
    [_service setSingleLineAutoResizeWithMaxWidth:100];
    
    _time.sd_layout
    .rightSpaceToView(self.contentView,20)
    .topSpaceToView(self.contentView,18)
    .heightIs(12);
    [_time setSingleLineAutoResizeWithMaxWidth:200];
    
    _address.sd_layout
    .leftEqualToView(_service)
    .topSpaceToView(_service,11)
    .heightIs(10);
    [_address setSingleLineAutoResizeWithMaxWidth:(SCREENWIDTH-20*2-35-18)];
    
    _line.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(_icon,7)
    .widthIs(SCREENWIDTH-20*2)
    .heightIs(0.5);
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
