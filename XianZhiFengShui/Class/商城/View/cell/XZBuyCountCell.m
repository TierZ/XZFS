//
//  XZBuyCountCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZBuyCountCell.h"

@implementation XZBuyCountCell{
    UILabel * _titleLab;
    UIButton * _minusBtn;
    UIButton * _plusBtn;
    UILabel * _countLab;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setupCell{
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(22, 15, 80, 15)];
    _titleLab.font = XZFS_S_FONT(15);
    _titleLab.textColor = XZFS_TEXTBLACKCOLOR;
    _titleLab.text = @"购买数量";
    
    _minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_minusBtn setImage:XZFS_IMAGE_NAMED(@"minus") forState:UIControlStateNormal];
    [_minusBtn addTarget:self action:@selector(minusCount:) forControlEvents:UIControlEventTouchUpInside];
    
    _plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_plusBtn setImage:XZFS_IMAGE_NAMED(@"plus") forState:UIControlStateNormal];
    [_plusBtn addTarget:self action:@selector(plusCount:) forControlEvents:UIControlEventTouchUpInside];
    
    _countLab = [[UILabel alloc]init];
    _countLab.backgroundColor = [UIColor clearColor];
    _countLab.textColor =  XZFS_TEXTBLACKCOLOR;
    _countLab.textAlignment =NSTextAlignmentCenter;
    _countLab.text = @"1";
    _countLab.font = XZFS_S_FONT(9);
    
    _plusBtn.frame = CGRectMake(SCREENWIDTH-20-14, 15, 14, 14);
    
    _countLab.frame = CGRectMake(_plusBtn.left-35 , 16, 35, 10);
    _minusBtn.frame = CGRectMake(_countLab.left-14, _plusBtn.top, 14, 14);
    
    [self.contentView sd_addSubviews:@[_titleLab,_countLab,_plusBtn,_minusBtn]];
    
}

-(void)setModel:(XZGoodsModel *)model{
    _model = model;
    _countLab.text = model.selectCount;
}

#pragma mark action

-(void)minusCount:(UIButton*)sender{
    NSLog(@"减一");
}

-(void)plusCount:(UIButton*)sender{
    NSLog(@"加一");
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
