//
//  XZMasterInfoEvaluateCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterInfoEvaluateCell.h"

@interface XZMasterInfoEvaluateCell ()
@property (nonatomic,strong)UIImageView * evaluateAvatar;
@property (nonatomic,strong)UILabel * evaluateName;
@property (nonatomic,strong)UILabel * evaluateTime;
@property (nonatomic,strong)UILabel * evaluateContent;
@end

@implementation XZMasterInfoEvaluateCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}

-(void)setupCell{
    [self.contentView sd_addSubviews:@[self.evaluateAvatar,self.evaluateName,self.evaluateTime,self.evaluateContent]];
    
    self.evaluateAvatar.sd_layout
    .leftSpaceToView(self.contentView,23)
    .topSpaceToView(self.contentView,5)
    .widthIs(35)
    .heightIs(35);
    
    self.evaluateName.sd_layout
    .leftSpaceToView(self.evaluateAvatar,10)
    .topSpaceToView(self.evaluateAvatar,18)
    .heightIs(13);
    [self.evaluateTime setSingleLineAutoResizeWithMaxWidth:200];
    
    self.evaluateTime.sd_layout
    .rightSpaceToView(self.contentView,20)
    .topEqualToView(self.evaluateName)
    .heightIs(13);
    
    self.evaluateContent.sd_layout
    .leftEqualToView(self.evaluateAvatar)
    .topSpaceToView(self.evaluateAvatar,2)
    .rightSpaceToView(self.contentView,20)
    .autoHeightRatio(0);
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.evaluateAvatar.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.evaluateAvatar.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.evaluateAvatar.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.evaluateAvatar.layer.mask = maskLayer;

}

-(void)setModel:(XZMasterInfoEvaluateModel *)model{
    _model = model;
    
    [self.evaluateAvatar setImageWithURL:[NSURL URLWithString:model.evaluateAvatar] placeholder:[UIImage imageNamed:@""]];
    
    self.evaluateName.text = model.evaluateName;
    self.evaluateTime.text = model.evaluateTime;
    self.evaluateContent.text = model.evaluateContent;
    
    [self setupAutoHeightWithBottomView:self.evaluateContent bottomMargin:8];
 }


#pragma mark getter
-(UIImageView *)evaluateAvatar{
    if (!_evaluateAvatar) {
        _evaluateAvatar = [[UIImageView alloc]init];
    }
    return _evaluateAvatar;
}

-(UILabel *)evaluateName{
    if (!_evaluateName) {
        _evaluateName = [[UILabel alloc]init];
        _evaluateName.backgroundColor = [UIColor clearColor];
        _evaluateName.textColor =  XZFS_TEXTBLACKCOLOR;
        _evaluateName.textAlignment =NSTextAlignmentLeft;
        _evaluateName.font = XZFS_S_FONT(12);
    }
    return _evaluateName;
}

-(UILabel *)evaluateTime{
    if (!_evaluateTime) {
        _evaluateTime = [[UILabel alloc]init];
        _evaluateTime.backgroundColor = [UIColor clearColor];
        _evaluateTime.textColor =  XZFS_TEXTBLACKCOLOR;
        _evaluateTime.textAlignment =NSTextAlignmentLeft;
        _evaluateTime.font = XZFS_S_FONT(12);
    }
    return _evaluateTime;
}

-(UILabel *)evaluateContent{
    if (!_evaluateContent) {
        _evaluateContent = [[UILabel alloc]init];
        _evaluateContent.backgroundColor = [UIColor clearColor];
        _evaluateContent.textColor =  XZFS_HEX_RGB(@"#ADAEAE");
        _evaluateContent.textAlignment =NSTextAlignmentLeft;
        _evaluateContent.font = XZFS_S_FONT(10);
        _evaluateContent.numberOfLines = 0;
    }
    return _evaluateContent;
}

#pragma mark ...
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
