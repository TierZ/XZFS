//
//  XZThemeListCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/20.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZThemeListCell.h"
#import "XZImageContainerView.h"
#import "UIButton+XZImageTitleSpacing.h"


#define THEMELIST_TITLECOLOR XZFS_HEX_RGB(@"#BABBBB")//内容颜色
@implementation XZThemeListCell{
    UIImageView *_photoView;//头像
    UILabel *_nameLable;//名字
      UILabel *_timeLabel;//时间
    UILabel * _titleLabel;//标题
    UILabel *_contentLabel;//内容
    XZImageContainerView *_picContainerView;//图片
  
    UIButton *_agreeButton;//点赞
    UIButton *_commentButton;//评论
    
    UIView * _bottomView;
    
    UIButton * _editBtn;//编辑图标
    UIButton * _deleteBtn;//删除图标
    
    

}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCell];
        [self hideEditBtn:NO];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}



- (void)setupCell
{
      _photoView = [UIImageView new];
    _photoView.backgroundColor = [UIColor orangeColor];
    
    _nameLable = [UILabel new];
    _nameLable.font = XZFS_S_FONT(12);
    _nameLable.textColor = XZFS_TEXTORANGECOLOR;
    
    _timeLabel = [UILabel new];
    _timeLabel.font = XZFS_S_FONT(10);
    _timeLabel.textColor = THEMELIST_TITLECOLOR;
    
    
    _titleLabel = [UILabel new];
    _titleLabel.font = XZFS_S_FONT(14);
    _titleLabel.textColor = XZFS_TEXTBLACKCOLOR;
    
    _editBtn = [UIButton new];
    [_editBtn setImage:XZFS_IMAGE_NAMED(@"huatibianji") forState:UIControlStateNormal];
    [_editBtn addTarget:self action:@selector(editTheme:) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteBtn = [UIButton new];
    [_deleteBtn setImage:XZFS_IMAGE_NAMED(@"huatishanchu") forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteTheme:) forControlEvents:UIControlEventTouchUpInside];
    
    _contentLabel = [UILabel new];
    _contentLabel.font = XZFS_S_FONT(12);
    _contentLabel.textColor = THEMELIST_TITLECOLOR;
    _contentLabel.numberOfLines = 0;
 
    
    _agreeButton = [UIButton new];
    [_agreeButton setTitle:@"99" forState:UIControlStateNormal];
    [_agreeButton setImage:XZFS_IMAGE_NAMED(@"yidianzan") forState:UIControlStateNormal];
    [_agreeButton setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
    [_agreeButton addTarget:self action:@selector(agreeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _agreeButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [_agreeButton layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    
    _commentButton = [UIButton new];
    [_commentButton setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
      [_commentButton setTitle:@"99" forState:UIControlStateNormal];
     [_commentButton setTitleColor:THEMELIST_TITLECOLOR forState:UIControlStateNormal];
     _commentButton.titleLabel.font = [UIFont systemFontOfSize:10];
     [_commentButton layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [_commentButton addTarget:self action:@selector(commentButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _picContainerView = [XZImageContainerView new];
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
    
    
    NSArray *views = @[_photoView, _nameLable, _timeLabel, _titleLabel,_editBtn,_deleteBtn,_contentLabel, _picContainerView, _agreeButton, _commentButton,_bottomView];
    
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    
    _photoView.sd_layout
    .leftSpaceToView(contentView, 20)
    .topSpaceToView(contentView, 8)
    .widthIs(34)
    .heightIs(34);
    
    _nameLable.sd_layout
    .leftSpaceToView(_photoView, 16)
    .topEqualToView(_photoView)
    .heightIs(12);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
    
    _timeLabel.sd_layout
    .leftEqualToView(_nameLable)
    .topSpaceToView(_nameLable,9)
    .heightIs(10);
     [_timeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _titleLabel.sd_layout
    .leftEqualToView(_photoView)
    .topSpaceToView(_photoView,13)
    .heightIs(14)
    .widthIs(200);
    
    _deleteBtn.sd_layout
    .topSpaceToView(_photoView,7)
    .rightSpaceToView(self.contentView,30)
    .widthIs(20)
    .heightIs(20);
    
    
    _editBtn.sd_layout
    .topSpaceToView(_photoView,7)
    .rightSpaceToView(_deleteBtn,20)
    .widthIs(20)
    .heightIs(20);

    
    _contentLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel, 10)
    .rightSpaceToView(contentView, 20)
    .autoHeightRatio(0);
    
      _picContainerView.sd_layout
    .leftEqualToView(_contentLabel); // 已经在内部实现宽度和高度自适应所以不需要再设置宽度高度，top值是具体有无图片在setModel方法中设置
    
    _agreeButton.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView, SCREENWIDTH/2)
    .heightIs(31);
    
    _commentButton.sd_layout
    .leftSpaceToView(self.contentView,SCREENWIDTH/2)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(31);
    
    _bottomView.sd_layout
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0)
    .heightIs(4)
    .topSpaceToView(_agreeButton,0);
}

#pragma mark 刷新cell


-(void)setModel:(XZThemeListModel *)model{
    _model = model;
    [_photoView setImageWithURL:[NSURL URLWithString:model.icon] placeholder:[UIImage imageNamed:@""]];
    _nameLable.text = model.issuer;
    _timeLabel.text = model.issueTime;
    
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
    _picContainerView.picPathStringsArray = model.photo;
    
    
    CGFloat picContainerTopMargin = 0;
    if (model.photo.count) {
        picContainerTopMargin = 10;
    }
    _picContainerView.sd_layout.topSpaceToView(_contentLabel, picContainerTopMargin);
    
    _agreeButton.sd_layout.topSpaceToView(_picContainerView,10);
    _commentButton.sd_layout.topSpaceToView(_picContainerView,10);
    
    [_agreeButton setTitle:model.pointOfPraise forState:UIControlStateNormal];
    [_commentButton setTitle:model.commentCount forState:UIControlStateNormal];
    _agreeButton.selected = model.isAgree;
    _commentButton.selected = model.isComment;
 
    [self setupAutoHeightWithBottomView:_bottomView bottomMargin:0];

}


#pragma mark action
-(void)hideEditBtn:(BOOL)isHide{
    _editBtn.hidden = isHide;
    _deleteBtn.hidden = isHide;
    if (isHide) {
        [_titleLabel setSingleLineAutoResizeWithMaxWidth:SCREENWIDTH-40];
    }else{
        _titleLabel.sd_layout.widthIs(SCREENWIDTH-120);
    }
}

-(void)agreeButtonClicked{
    NSLog(@"点赞");
    if (self.agreeBlock) {
        self.agreeBlock(self.model,self.indexPath);
    }
}

-(void)commentButtonClicked{
    NSLog(@"评论");
    if (self.commentBlock) {
        self.commentBlock(self.model,self.indexPath);
    }
}

-(void)deleteTheme:(UIButton*)sender{
    NSLog(@"删除");
    if (self.deleteBlock) {
        self.deleteBlock(self.model,self.indexPath);
    }
}
-(void)editTheme:(UIButton*)sender{
    NSLog(@"编辑");
    if (self.editBlock) {
        self.editBlock(self.model,self.indexPath);
    }
}

-(void)editThemeWithBlock:(EditThemeBlock)block{
    self.editBlock = block;
}
-(void)deleteThemeWithBlock:(DeleteThemeBlock)block{
    self.deleteBlock = block;
}
-(void)agreeThemeWithBlock:(AgreeThemeBlock)block{
    self.agreeBlock = block;
}
-(void)commentThemeWithBlock:(CommentThemeBlock)block{
    self.commentBlock = block;
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
