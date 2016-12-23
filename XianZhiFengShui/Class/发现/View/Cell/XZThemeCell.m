//
//  XZThemeCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/12.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZThemeCell.h"



@interface XZThemeCell()
@property (nonatomic,strong)UIImageView * photo;
@property (nonatomic,strong)UILabel * title;
@property (nonatomic,strong)UILabel * scanCount;
@property (nonatomic,strong)UILabel * focusCount;
@property (nonatomic,strong)UIButton * focus;
@end

@implementation XZThemeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupCell];
        [self layoutCell];
    }
    return self;
}

#pragma mark draw
-(void)setupCell{
    [self.contentView addSubview:self.photo];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.focus];
    [self.contentView addSubview:self. scanCount];
    [self.contentView addSubview:self.focusCount];
 
}

-(void)layoutCell{
    self.photo.frame = CGRectMake(20, 8, 50, 50);
    self.title.frame = CGRectMake(self.photo.right+8, 19, 150, 14);
    self.scanCount.frame = CGRectMake(self.title.left, self.title.bottom+11, 150, 11);
    self.focusCount.frame = CGRectMake(self.scanCount.right+27, self.title.bottom+11, 150, 11);
    self.focus .frame = CGRectMake(self.title.right+60, self.title.top, 15, 13);
    
}

#pragma mark action
-(void)focus:(UIButton*)sender{
    
}


#pragma mark refresh
-(void)refreshThemeCellWithModel:(XZTheMasterModel*)model{
    if (model) {
        [self.photo setImageWithURL:[NSURL URLWithString:model.icon] placeholder:[UIImage imageNamed:@""] ];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.photo.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.photo.bounds.size];
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        //设置大小
        maskLayer.frame = self.photo.bounds;
        //设置图形样子
        maskLayer.path = maskPath.CGPath;
        self.photo.layer.mask = maskLayer;
        
        
        self.title.text = model.title;
        self.scanCount.text = [NSString stringWithFormat:@"%@人浏览",model.browse];
        self.focusCount.text = [NSString stringWithFormat:@"%@人关注",model.onFocus];
        self.focus.selected = model.isFocused;
    }
}

#pragma mark getter
-(UIImageView *)photo{
    if (!_photo) {
        _photo = [[UIImageView alloc]init];
    }
    return _photo;
}
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
-(UILabel *)focusCount{
    if (!_focusCount) {
        _focusCount = [[UILabel alloc]init];
        _focusCount.backgroundColor = [UIColor clearColor];
        _focusCount.textColor =  XZFS_TEXTBLACKCOLOR;
        _focusCount.textAlignment =NSTextAlignmentLeft;
        _focusCount.font = XZFS_S_FONT(11);
    }
    return _focusCount;
}

-(UILabel *)scanCount{
    if (!_scanCount) {
        _scanCount = [[UILabel alloc]init];
        _scanCount.backgroundColor = [UIColor clearColor];
        _scanCount.textColor =  XZFS_TEXTBLACKCOLOR;
        _scanCount.textAlignment =NSTextAlignmentLeft;
        _scanCount.font = XZFS_S_FONT(11);
    }
    return _scanCount;
}

-(UIButton *)focus{
    if (!_focus) {
        _focus = [UIButton buttonWithType:UIButtonTypeCustom];
        _focus.backgroundColor = [UIColor redColor];
        [_focus addTarget:self action:@selector(focus:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _focus;
}

@end
