//
//  XZMyAccountBillCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/17.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyAccountBillCell.h"

@interface XZMyAccountBillCell ()
@property (nonatomic,strong)UILabel * title;
@property (nonatomic,strong)UILabel * subTitle;
@property (nonatomic,strong)UILabel * price;
@end
@implementation XZMyAccountBillCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}

-(void)setupCell{
    [self.contentView sd_addSubviews:@[ self.title,self.subTitle,self.price ]];
    self.title.sd_layout
    .leftSpaceToView(self.contentView,22)
    .topSpaceToView(self.contentView,12)
    .heightIs(14);
    [self.title setSingleLineAutoResizeWithMaxWidth:SCREENWIDTH*0.65];
    
    self.subTitle.sd_layout
    .leftEqualToView(self.title)
    .topSpaceToView(self.title,11)
    .heightIs(8);
    [self.subTitle setSingleLineAutoResizeWithMaxWidth:200];
    
    self.price.sd_layout
    .topSpaceToView(self.contentView,22)
    .heightIs(14)
    .rightSpaceToView(self.contentView,47);
    [self.price setSingleLineAutoResizeWithMaxWidth:100];
}

-(void)setModel:(XZMyAccountBillModel *)model{
    _model = model;
    self.title.text = model.title;
    self.subTitle.text = model.subTitle;
    float priceFloat = model.price.floatValue;
    NSString * priceColor = priceFloat>=0?@"#FD0000":@"#009D1A";
    self.price.text = model.price;
    self.price.textColor = XZFS_HEX_RGB(priceColor);
    

}

#pragma mark getter
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

-(UILabel *)subTitle{
    if (!_subTitle) {
        _subTitle = [[UILabel alloc]init];
        _subTitle.backgroundColor = [UIColor clearColor];
        _subTitle.textColor =  XZFS_TEXTBLACKCOLOR;
        _subTitle.textAlignment =NSTextAlignmentLeft;
        _subTitle.font = XZFS_S_FONT(8);
    }
    return _subTitle;
}

-(UILabel *)price{
    if (!_price) {
        _price = [[UILabel alloc]init];
        _price.backgroundColor = [UIColor clearColor];
        _price.textColor =  XZFS_HEX_RGB(@"#FD0000");
        _price.textAlignment =NSTextAlignmentLeft;
        _price.font = XZFS_S_FONT(14);
    }
    return _price;
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
