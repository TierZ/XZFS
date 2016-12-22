//
//  XZThemeCommentCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/27.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZThemeCommentCell.h"

#define THEMELIST_TITLECOLOR XZFS_HEX_RGB(@"#BABBBB")//内容颜色

@interface XZThemeCommentCell ()
@property (nonatomic,strong)UIImageView * avatar;
@property (nonatomic,strong)UILabel * name;
@property (nonatomic,strong)UILabel * time;
@property (nonatomic,strong)UIButton * comment;
@property (nonatomic,strong)UIButton * agree;
@property (nonatomic,strong)UILabel * content;
@end

@implementation XZThemeCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark setup

-(void)setupCell{
    NSArray *views = @[ self.avatar, self.name, self.time, self.comment,self.agree, self.content ];
    [self.contentView sd_addSubviews:views];

    UIView *contentView = self.contentView;
    self.avatar.sd_layout
    .leftSpaceToView(contentView, 20)
    .topSpaceToView(contentView, 8)
    .widthIs(34)
    .heightIs(34);
    
    _name.sd_layout
    .leftSpaceToView(self.avatar, 16)
    .topEqualToView(self.avatar)
    .heightIs(12);
    [_name setSingleLineAutoResizeWithMaxWidth:100];
    
    _time.sd_layout
    .leftEqualToView(_name)
    .topSpaceToView(_name,9)
    .heightIs(10);
    [_time setSingleLineAutoResizeWithMaxWidth:100];
    
    _content.sd_layout
    .leftEqualToView(_name)
    .topSpaceToView(_time,12)
    .rightSpaceToView(contentView, 20)
    .autoHeightRatio(0);
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.avatar.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.avatar.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.avatar.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.avatar.layer.mask = maskLayer;
    
}

-(void)setModel:(XZThemeCommentModel *)model{
    _model = model;
    [_avatar setImageWithURL:[NSURL URLWithString:model.avatar] placeholder:[UIImage imageNamed:@""]];
    _name.text = model.commenter;
    _time.text = model.time;
    _content.text = model.content;
    
    [self setupAutoHeightWithBottomView:_content bottomMargin:6];
}

#pragma mark action
-(void)agree:(UIButton*)sender{
    NSLog(@"点赞")
}

-(void)comment:(UIButton*)sender{
        NSLog(@"评论")
}

#pragma mark getter
-(UIImageView *)avatar{
    if (!_avatar) {
        _avatar = [[UIImageView alloc]init];
    }
    return _avatar;
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.backgroundColor = [UIColor clearColor];
        _name.textColor =  XZFS_TEXTBLACKCOLOR;
        _name.textAlignment =NSTextAlignmentLeft;
        _name.font = XZFS_S_FONT(12);
    }
    return _name;
}

-(UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc]init];
        _time.backgroundColor = [UIColor clearColor];
        _time.textColor =  THEMELIST_TITLECOLOR;
        _time.textAlignment =NSTextAlignmentLeft;
        _time.font = XZFS_S_FONT(10);
    }
    return _time;
}

-(UIButton *)comment{
    if (!_comment) {
        _comment = [UIButton buttonWithType:UIButtonTypeCustom];
        [_comment setTitle:@"99" forState:UIControlStateNormal];
        [_comment setTitleColor:THEMELIST_TITLECOLOR forState:UIControlStateNormal];
        [_comment setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _comment.titleLabel.font = XZFS_S_FONT(12);
        [_comment addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _comment;

}

-(UIButton *)agree{
    if (!_agree) {
        _agree = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agree setTitle:@"99" forState:UIControlStateNormal];
        [_agree setTitleColor:THEMELIST_TITLECOLOR forState:UIControlStateNormal];
        [_agree setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateSelected];
        [_agree setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _agree.titleLabel.font = XZFS_S_FONT(12);
        [_agree addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agree;
}

-(UILabel *)content{
    if (!_content) {
        _content = [[UILabel alloc]init];
        _content.backgroundColor = [UIColor clearColor];
        _content.textColor = THEMELIST_TITLECOLOR;
        _content.textAlignment =NSTextAlignmentLeft;
        _content.font = XZFS_S_FONT(12);
        _content.numberOfLines = 0;
    }
    return _content;
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
