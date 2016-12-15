//
//  XZMessageDetailListCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/1.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMessageDetailListCell.h"
@interface XZMessageDetailListCell ()
@property (nonatomic,strong)UILabel * contentLab;
@end
@implementation XZMessageDetailListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setupCell{
    [self.contentView sd_addSubviews:@[ self.contentLab ]];
    
    self.contentLab.sd_layout
    .leftSpaceToView(self.contentView,25)
    .rightSpaceToView(self.contentView,25)
    .topSpaceToView(self.contentView,10)
    .autoHeightRatio(0);
    
}

-(void)setModel:(XZMessageModel *)model{
    _model = model;
    self.contentLab.text = model.content;
    
    [self setupAutoHeightWithBottomView:self.contentLab bottomMargin:10];
}

#pragma mark getter
-(UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc]init];
        _contentLab.backgroundColor = [UIColor clearColor];
        _contentLab.textColor =  XZFS_TEXTBLACKCOLOR;
        _contentLab.textAlignment =NSTextAlignmentLeft;
        _contentLab.font = XZFS_S_FONT(14);
    }
    return _contentLab;
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
