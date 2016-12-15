//
//  XZMyMasterFinishedCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/16.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyMasterFinishedCell.h"
@interface XZMyMasterFinishedCell ()
@property (nonatomic,strong)UIButton * commentBtn;
@end
@implementation XZMyMasterFinishedCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubCell];
    }
    return self;
}
-(void)setupSubCell{
    [self.contentView addSubview:self.commentBtn];
    
    self.timeLab.hidden = YES;
    self.timeIv.hidden = YES;
    
    self.service.sd_layout
    .leftEqualToView(self.name)
    .topSpaceToView(self.name,17)
    .autoHeightRatio(0)
    .widthIs(SCREENWIDTH-93-20-20);
    
    self.price.sd_layout
    .leftEqualToView(self.name)
    .topSpaceToView(self.service,20)
    .heightIs(12);
    [self.price setSingleLineAutoResizeWithMaxWidth:(150)];
    
    self.commentBtn.sd_layout
    .topEqualToView(self.price)
    .rightSpaceToView(self.contentView,20)
    .widthIs(70)
    .heightIs(12);
    
}
#pragma mark action
-(void)commentMaster:(UIButton*)sender{
    if (self.block) {
        self.block(self.model);
    }
    NSLog(@"去评价大师");
}

-(void)evaluateMasterWithBlock:(EvaluateMasterBlock)block{
    self.block = block;
}

#pragma mark getter

-(UIButton *)commentBtn{
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setTitle:@"去评价大师" forState:UIControlStateNormal];
        [_commentBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = XZFS_S_FONT(12);
        [_commentBtn addTarget:self action:@selector(commentMaster:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}

-(void)setModel:(XZTheMasterModel *)model{
    _model = model;
    [self.photo setImageWithURL:[NSURL URLWithString:model.icon] placeholder:[UIImage imageNamed:@""] ];
    self.name.text = model.name;
    self.levelLab.text = model.level;
    self.service.text = model.service;
    self.price.text = model.price;
    
    [self setupAutoHeightWithBottomViewsArray:@[self.photo,self.commentBtn] bottomMargin:10];

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
