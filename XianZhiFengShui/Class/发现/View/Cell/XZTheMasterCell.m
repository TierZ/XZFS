//
//  XZTheMasterCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/10.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZTheMasterCell.h"
#import "XZTagView.h"
#import "UIButton+XZImageTitleSpacing.h"

@interface XZTheMasterCell ()
@property (nonatomic,strong)UIImageView * photo;
@property (nonatomic,strong)UILabel * name;
@property (nonatomic,strong)UIImageView * level;
@property (nonatomic,strong)UIImageView * successIv;
@property (nonatomic,strong)UILabel * successLab;
@property (nonatomic,strong)UIButton * agreeBtn;
@property (nonatomic,strong)UILabel * agreeLab;
@property (nonatomic,strong)UILabel * introduce;
@property (nonatomic,strong)XZTagView * tagView;
@end
@implementation XZTheMasterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCell];
        [self layoutCell];
    }
    return self;
}

#pragma mark layout
-(void)initCell{
    [self.contentView addSubview:self.photo];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.level];
//    [self.contentView addSubview:self.levelLab];
    [self.contentView addSubview:self.successIv];
    [self.contentView addSubview:self.successLab];
    [self.contentView addSubview:self.agreeBtn];
    [self.contentView addSubview:self.agreeLab];
    [self.contentView addSubview:self.introduce];
    
}

-(void)layoutCell{
    self.photo.frame = CGRectMake(20, 10, 94, 94);
    self.name.frame = CGRectMake(self.photo.right+17.5, 12.5, 50, 12);
    self.level.frame = CGRectMake(self.name.right+30, 12.5, 19, 12);
//    self.levelLab.frame = CGRectMake(self.level.right+2, 13.5, 22, 11);
    self.successIv.frame = CGRectMake(self.level.right+20, 12.5, 12, 10);
    self.successLab.frame = CGRectMake(self.successIv.right+2, 13.5, 33, 11);
    self.agreeBtn.frame = CGRectMake(self.successLab.right+20, 12.5, 80, 12);
//    self.agreeLab.frame = CGRectMake(self.agreeBtn.right+2, 13.5, 33, 11);
    self.tagView = [[XZTagView alloc]initWithFrame:CGRectMake(self.name.left, self.name.bottom+17.5, SCREENWIDTH-self.name.left-20 , 16) tagHeight:16];
    [self.contentView addSubview:self.tagView];
    
    self.introduce.frame = CGRectMake(self.tagView.left, self.tagView.bottom+15, self.tagView.width, 9);
}
#pragma mark action
-(void)agree:(UIButton*)sender{
    sender.selected = !sender.selected;
}

#pragma mark refresh
-(void)refreshMasterCellWithModel:(XZTheMasterModel *)model{
    if (model) {
        [self.photo setImageWithURL:[NSURL URLWithString:model.icon] placeholder:[UIImage imageNamed:@""] ];
        self.name.text = model.name;
        self.successLab.text = model.singleVolume;
        [self.agreeBtn setTitle:model.pointOfPraise forState:UIControlStateNormal];
        [self.agreeBtn sizeToFit];
        self.tagView.tagsArray = model.type;
        [self.tagView setupTags];
    
       
         self.introduce.text = model.summary;
        [self.introduce sizeToFitWidth:self.tagView.width];
        CGRect frame = self.introduce.frame;
        frame.origin.y = self.tagView.bottom+15;
        self.introduce.frame = frame;
        
        self.height = self.introduce.bottom>self.photo.bottom?self.introduce.bottom+10:self.photo.bottom+10;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

#pragma mark getter

-(UIImageView *)photo{
    if (!_photo) {
        _photo = [[UIImageView alloc]init];
        _photo.backgroundColor = [UIColor clearColor];
    }
    return _photo;
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.backgroundColor = [UIColor clearColor];
        _name.textColor =  XZFS_TEXTBLACKCOLOR;
        _name.textAlignment =NSTextAlignmentLeft;
        _name.font = XZFS_S_FONT(11);
    }
    return _name;
}

-(UIImageView *)level{
    if (!_level) {
        _level = [[UIImageView alloc]init];
        _level.image = XZFS_IMAGE_NAMED(@"level1");
    }
    return _level;
}

-(UIImageView *)successIv{
    if (!_successIv) {
        _successIv = [[UIImageView alloc]init];
        _successIv.image = XZFS_IMAGE_NAMED(@"chengdanshu");
    }
    return _successIv;
}

-(UILabel *)successLab{
    if (!_successLab) {
        _successLab = [[UILabel alloc]init];
        _successLab.backgroundColor = [UIColor clearColor];
        _successLab.textColor =  XZFS_TEXTGRAYCOLOR;
        _successLab.textAlignment =NSTextAlignmentLeft;
        _successLab.font = XZFS_S_FONT(10);
    }
    return _successLab;
}

-(UIButton *)agreeBtn{
    if (!_agreeBtn) {
        _agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreeBtn setImage:XZFS_IMAGE_NAMED(@"yidianzan") forState:UIControlStateSelected];
         [_agreeBtn setImage:XZFS_IMAGE_NAMED(@"weidianzan") forState:UIControlStateNormal];
        [_agreeBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
        _agreeBtn.titleLabel.font = XZFS_S_FONT(10);
        [_agreeBtn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:5];
        [_agreeBtn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeBtn;
}

//-(UILabel *)agreeLab{
//    if (!_agreeLab) {
//        _agreeLab = [[UILabel alloc]init];
//        _agreeLab.backgroundColor = [UIColor clearColor];
//        _agreeLab.textColor =  XZFS_TEXTORANGECOLOR;
//        _agreeLab.textAlignment =NSTextAlignmentLeft;
//        _agreeLab.font = XZFS_S_FONT(10);
//    }
//    return _agreeLab;
//}

-(UILabel *)introduce{
    if (!_introduce) {
        _introduce = [[UILabel alloc]init];
        _introduce.backgroundColor = [UIColor clearColor];
        _introduce.textColor =  XZFS_HEX_RGB(@"#545454");
        _introduce.textAlignment =NSTextAlignmentLeft;
        _introduce.font = XZFS_S_FONT(9);
        _introduce.numberOfLines = 0;
    }
    return _introduce;
}


@end
