//
//  XZMyEvaluateCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/17.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyEvaluateCell.h"

@implementation XZMyEvaluateCell{
    UIImageView * _photo;
    UILabel * _name;
    UILabel * _time;
    UILabel * _service;
    UILabel * _evaluate;
}

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
    _photo = [[UIImageView alloc]init];
    _photo.backgroundColor = RandomColor(1);
    
    _name = [UILabel new];
    _name.textColor = XZFS_TEXTBLACKCOLOR;
    _name.font = XZFS_S_FONT(14);
    
    _time = [UILabel new];
    _time.textColor = XZFS_HEX_RGB(@"#252323");
    _time.font = XZFS_S_FONT(9);
    _time.textAlignment = NSTextAlignmentRight;
    
    _service = [UILabel new];
    _service.textColor = XZFS_HEX_RGB(@"#898989");
    _service.font = XZFS_S_FONT(9);
    
    _evaluate = [UILabel new];
    _evaluate.textColor = _time.textColor;
    _evaluate.font = XZFS_S_FONT(11);
    _evaluate.numberOfLines = 0;
    
    [self.contentView sd_addSubviews: @[ _photo,_name,_time,_service,_evaluate]];
    
}
-(void)layoutCell{
    _photo.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(self.contentView,5)
    .widthIs(48)
    .heightIs(48);
    
    _name.sd_layout
    .leftSpaceToView(_photo,20)
    .topSpaceToView(self.contentView,8)
    .heightIs(14);
    [_name setSingleLineAutoResizeWithMaxWidth:200];
    
    _time.sd_layout
    .topSpaceToView(self.contentView,11)
    .heightIs(9)
    .widthIs(100)
   .rightSpaceToView(self.contentView,20);
    
    _service.sd_layout
    .leftEqualToView(_name)
    .topSpaceToView(_name,20)
    .heightIs(9);
    [_service setSingleLineAutoResizeWithMaxWidth:SCREENWIDTH-20*2-48-20];
    
    _evaluate.sd_layout
    .leftEqualToView(_photo)
    .topSpaceToView(_photo,8)
    .widthIs(SCREENWIDTH-20*2)
    .autoHeightRatio(0);

}

-(void)setModel:(XZMyEvaluateModel *)model{
    _model = model;
    
    [_photo setImageWithURL:[NSURL URLWithString:model.photo] options:YYWebImageOptionProgressive];
    _name.text = model.name;
    _time.text = model.time;
    _service.text = model.service;
    _evaluate.text = model.evaluate;
    
    [self setupAutoHeightWithBottomView:_evaluate bottomMargin:12];

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
