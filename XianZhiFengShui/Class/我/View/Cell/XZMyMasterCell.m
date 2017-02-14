//
//  XZMyMasterCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/16.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyMasterCell.h"
@interface XZMyMasterCell ()
@end
@implementation XZMyMasterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}

-(void)setupCell{
    
    [self.contentView sd_addSubviews:@[ self.photo,self.name,self.levelIv,self.timeIv,self.timeLab,self.service,self.price]];
     float photoWidth = XZFS_IS_IPHONE6_PLUS?94:84;
    self.photo.sd_layout
    .leftSpaceToView(self.contentView,20)
    .topSpaceToView(self.contentView,8)
    .widthIs(photoWidth)
    .heightIs(photoWidth);
    
    self.name.sd_layout
    .leftSpaceToView(self.photo,15)
    .topSpaceToView(self.contentView,20)
    .heightIs(14);
    [self.name setSingleLineAutoResizeWithMaxWidth:100];
    
    
    float levelSpace = XZFS_IS_IPHONE6_PLUS?25:12;
    self.levelIv.sd_layout
    .leftSpaceToView(self.name,levelSpace)
    .topSpaceToView(self.contentView,21)
    .widthIs(19)
    .heightIs(12);
    
//    self.levelLab.sd_layout
//    .leftSpaceToView(self.levelIv,1)
//    .topEqualToView(self.levelIv)
//    .heightIs(10);
//    [self.levelLab setSingleLineAutoResizeWithMaxWidth:30];
    
    self.timeIv.sd_layout
    .leftSpaceToView(self.levelIv,levelSpace)
    .topSpaceToView(self.contentView,21)
    .widthIs(10)
    .heightIs(10);
    
    self.timeLab.sd_layout
    .leftSpaceToView(self.timeIv,2)
    .topEqualToView(self.timeIv)
    .heightIs(10);
    [self.timeLab setSingleLineAutoResizeWithMaxWidth:100];


}

#pragma mark getter
-(UIImageView *)photo{
    if (!_photo) {
        _photo = [[UIImageView alloc]init];
    }
    return _photo;
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.backgroundColor = [UIColor clearColor];
        _name.textColor =  XZFS_TEXTBLACKCOLOR;
        _name.textAlignment =NSTextAlignmentLeft;
        _name.font = XZFS_S_FONT(14);
    }
    return _name;
}

-(UIImageView *)levelIv{
    if (!_levelIv) {
        _levelIv = [[UIImageView alloc]init];
        _levelIv.image = XZFS_IMAGE_NAMED(@"level1");
    }
    return _levelIv;
}
-(UILabel *)levelLab{
    if (!_levelLab) {
        _levelLab = [[UILabel alloc]init];
        _levelLab.backgroundColor = [UIColor clearColor];
        _levelLab.textColor =  XZFS_HEX_RGB(@"#F7CE00");
        _levelLab.textAlignment =NSTextAlignmentLeft;
        _levelLab.font = XZFS_S_FONT(10);
    }
    return _levelLab;
}

-(UIImageView *)timeIv{
    if (!_timeIv) {
        _timeIv = [[UIImageView alloc]init];
        _timeIv.image = XZFS_IMAGE_NAMED(@"shijian");
    }
    return _timeIv;
}
-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]init];
        _timeLab.backgroundColor = [UIColor clearColor];
        _timeLab.textColor =  XZFS_HEX_RGB(@"#BABBBB");
        _timeLab.textAlignment =NSTextAlignmentLeft;
        _timeLab.font = XZFS_S_FONT(10);
    }
    return _timeLab;
}

-(UILabel *)service{
    if (!_service) {
        _service = [[UILabel alloc]init];
        _service.backgroundColor = [UIColor clearColor];
        _service.textColor =  XZFS_HEX_RGB(@"#898989");
        _service.textAlignment =NSTextAlignmentLeft;
        _service.font = XZFS_S_FONT(9);
    }
    return _service;
}

-(UILabel *)price{
    if (!_price) {
        _price = [[UILabel alloc]init];
        _price.backgroundColor = [UIColor clearColor];
        _price.textColor =  XZFS_HEX_RGB(@"#FF6100");
        _price.textAlignment =NSTextAlignmentLeft;
        _price.font = XZFS_S_FONT(12);
    }
    return _price;
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
