//
//  XZMyFocusThemeCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/14.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyFocusThemeCell.h"
@interface XZMyFocusThemeCell ()
@property (nonatomic,strong)UILabel * title;
@property (nonatomic,strong)UIView * contentBg;
@property (nonatomic,strong)UILabel * contentLab;
@property (nonatomic,strong)UILabel * contentTitle;
@end
@implementation XZMyFocusThemeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}

-(void)setupCell{
    
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.contentBg];
    [self.contentBg addSubview:self.contentTitle];
    [self.contentBg addSubview:self.contentLab];
//    [self.contentBg sd_addSubviews:@[ _contentTitle,_contentLab ]];
//    [self.contentView sd_addSubviews:@[ _title,_contentBg ]];
  
    _title.sd_layout
    .leftSpaceToView(self.contentView,17)
    .topSpaceToView(self.contentView,19)
    .heightIs(12);
    [_title setSingleLineAutoResizeWithMaxWidth:SCREENWIDTH-34];
    
    _contentBg.sd_layout
    .leftEqualToView(self.title)
    .topSpaceToView(self.title,8)
    .widthIs(SCREENWIDTH-34);
    
    _contentTitle.sd_layout
    .leftSpaceToView(self.contentBg,2)
    .topSpaceToView(self.contentBg,10)
    .heightIs(14);
    [_contentTitle setSingleLineAutoResizeWithMaxWidth:self.contentBg.width-4];
    
    _contentLab.sd_layout
    .leftEqualToView(self.contentTitle)
    .topSpaceToView(self.contentTitle,11.5)
    .widthIs(self.contentBg.width-4)
    .autoHeightRatio(0);
    
    [self.contentBg setupAutoHeightWithBottomView:_contentLab bottomMargin:12];
    
   
    
}

-(void)setModel:(XZThemeListModel *)model{
    self.title.text = [NSString stringWithFormat:@"%@  发表了新话题",model.issuer];
    self.contentTitle.text = model.title;
    self.contentLab.text = model.content;
     [self setupAutoHeightWithBottomView:self.contentBg bottomMargin:0];
}

#pragma mark getter
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.backgroundColor = [UIColor clearColor];
        _title.textColor =  XZFS_HEX_RGB(@"#C5C5C6");
        _title.textAlignment =NSTextAlignmentLeft;
        _title.font = XZFS_S_FONT(12);
    }
    return _title;
}

-(UIView *)contentBg{
    if (!_contentBg) {
        _contentBg = [[UIView alloc]init];
        _contentBg.backgroundColor = XZFS_HEX_RGB(@"#eeefef");
    }
    return _contentBg;
}

-(UILabel *)contentTitle{
    if (!_contentTitle) {
        _contentTitle = [[UILabel alloc]init];
        _contentTitle.backgroundColor = [UIColor clearColor];
        _contentTitle.textColor =  XZFS_TEXTBLACKCOLOR;
        _contentTitle.textAlignment =NSTextAlignmentLeft;
        _contentTitle.font = XZFS_S_FONT(14);
    }
    return _contentTitle;
}

-(UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.backgroundColor = [UIColor clearColor];
        _contentLab.textColor =  XZFS_HEX_RGB(@"#8F8F8F");
        _contentLab.textAlignment =NSTextAlignmentLeft;
        _contentLab.font = XZFS_S_FONT(13);
    }
    return _contentLab;
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
