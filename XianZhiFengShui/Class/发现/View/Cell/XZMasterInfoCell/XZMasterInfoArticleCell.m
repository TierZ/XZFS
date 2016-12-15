//
//  XZMasterInfoArticleCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterInfoArticleCell.h"
@interface XZMasterInfoArticleCell ()
@property (nonatomic,strong)UILabel * articleTitle;
@property (nonatomic,strong)UILabel * articleDetail;
@end
@implementation XZMasterInfoArticleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
    }
    return self;
}

-(void)setupCell{
    [self.contentView sd_addSubviews:@[self.articleTitle,self.articleDetail]];
    
    self.articleTitle.sd_layout
    .leftSpaceToView(self.contentView,22)
    .topSpaceToView(self.contentView,12)
    .heightIs(13);
    [self.articleTitle setSingleLineAutoResizeWithMaxWidth:SCREENWIDTH-44];
    
    self.articleDetail.sd_layout
    .leftEqualToView(self.articleTitle)
    .topSpaceToView(self.articleTitle,8)
    .rightSpaceToView(self.contentView,22)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:self.articleDetail bottomMargin:8];
}

#pragma mark getter
-(UILabel *)articleTitle{
    if (!_articleTitle) {
        _articleTitle = [[UILabel alloc]init];
        _articleTitle.backgroundColor = [UIColor clearColor];
        _articleTitle.textColor =  XZFS_TEXTBLACKCOLOR;
        _articleTitle.textAlignment =NSTextAlignmentLeft;
        _articleTitle.font = XZFS_S_FONT(12);
    }
    return _articleTitle;
}

-(UILabel *)articleDetail{
    if (!_articleDetail) {
        _articleDetail = [[UILabel alloc]init];
        _articleDetail.backgroundColor = [UIColor clearColor];
        _articleDetail.textColor =  XZFS_HEX_RGB(@"#ADAEAE");
        _articleDetail.textAlignment =NSTextAlignmentLeft;
        _articleDetail.font = XZFS_S_FONT(10);
    }
    return _articleDetail;
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
