//
//  XZMessageListCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/1.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#define LIGHTGRAYCOLOR @"#D3D3D4"

#import "XZMessageListCell.h"
@interface XZMessageListCell ()
@property (nonatomic,strong)UIImageView * icon;
@property (nonatomic,strong)UILabel * title;
@property (nonatomic,strong)UILabel * time;
@property (nonatomic,strong)UILabel * detail;
@property (nonatomic,strong)UIView * bottomLine;
@end
@implementation XZMessageListCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark layotCell
-(void)setupCell{
    [self.contentView sd_addSubviews:@[ self.icon,self.title,self.time,self.detail,self.bottomLine ]];
    
    self.icon.sd_layout
    .leftSpaceToView(self.contentView,27)
    .topSpaceToView(self.contentView,12)
    .widthIs(35)
    .heightIs(35);
    
    self.title.sd_layout
    .leftSpaceToView(self.icon,9)
    .topEqualToView(self.icon)
    .heightIs(14);
    [self.title setSingleLineAutoResizeWithMaxWidth:200];
    
    self.time.sd_layout
    .rightSpaceToView(self.contentView,21)
    .topEqualToView(self.icon)
    .heightIs(14);
    [self.time setSingleLineAutoResizeWithMaxWidth:200];

    self.detail.sd_layout
    .leftEqualToView(self.title)
    .topSpaceToView(self.title,9)
    .rightSpaceToView(self.contentView,20)
    .autoHeightRatio(0);
    
    self.bottomLine.sd_layout
    .leftSpaceToView(self.contentView,11.5)
    .rightSpaceToView(self.contentView,11.5)
    .heightIs(0.5)
    .topSpaceToView(self.detail,11.5);
}

#pragma mark  data
-(void)setModel:(XZMessageModel *)model{
    _model = model;
    self.icon.image = [UIImage imageNamed:model.icon];
    self.title.text = model.title;
    self.time.text = model.time;
    self.detail.text = model.detail;
    
    [self setupAutoHeightWithBottomView:self.bottomLine bottomMargin:0];
}

-(void)hideBottomLine{
    self.bottomLine.hidden = YES;
}

#pragma mark getter
-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.backgroundColor = [UIColor clearColor];
        _title.textColor =  XZFS_TEXTBLACKCOLOR;
        _title.textAlignment =NSTextAlignmentLeft;
        _title.font = XZFS_S_FONT(14);
    }
    return _title;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.backgroundColor = [UIColor clearColor];
        _time.textColor =  XZFS_HEX_RGB(LIGHTGRAYCOLOR);
        _time.font = XZFS_S_FONT(14);
    }
    return _time;
}
-(UILabel *)detail{
    if (!_detail) {
        _detail = [[UILabel alloc]init];
        _detail.backgroundColor = [UIColor clearColor];
        _detail.textColor =  XZFS_HEX_RGB(LIGHTGRAYCOLOR);
        _detail.textAlignment =NSTextAlignmentLeft;
        _detail.font = XZFS_S_FONT(13);
    }
    return _detail;
}
-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = XZFS_HEX_RGB(LIGHTGRAYCOLOR);
    }
    return _bottomLine;
}

#pragma mark ..
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
