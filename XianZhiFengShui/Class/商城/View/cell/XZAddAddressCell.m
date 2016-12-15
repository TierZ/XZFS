//
//  XZAddAddressCell.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/14.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZAddAddressCell.h"
#import "UIButton+XZImageTitleSpacing.h"
#import "UILabel+Tools.h"
#import "XZTextView.h"

@implementation XZAddAddressCell{
    UILabel * _titleLab;
    UITextField * _tf;
    UILabel * _contentLab;
    UIButton * _selectBtn;
    UIButton*_defaultBtn;
    XZTextView * _detailedInfo;//详细地址

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupCell];
    }
    return self;
}

-(void)setupCell{
    _titleLab = [UILabel labelWithFontSize:14 textColor:XZFS_TEXTBLACKCOLOR];
    _tf = [[UITextField alloc]init];
    _tf.textColor = XZFS_TEXTBLACKCOLOR;
    _tf.font = XZFS_S_FONT(15);
    
    _contentLab = [UILabel labelWithFontSize:14 textColor:XZFS_TEXTBLACKCOLOR];
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectBtn setTitle:@"请选择" forState:UIControlStateNormal];
    [_selectBtn setTitleColor:XZFS_TEXTLIGHTGRAYCOLOR forState:UIControlStateNormal];
    _selectBtn.titleLabel.font = XZFS_S_FONT(13);
    [_selectBtn setImage:XZFS_IMAGE_NAMED(@"youjiantou_hui") forState:UIControlStateNormal];
    [_selectBtn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleRight imageTitleSpace:30];
    
    _defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     [_defaultBtn setImage:XZFS_IMAGE_NAMED(@"switch") forState:UIControlStateNormal];
    [_defaultBtn setImage:XZFS_IMAGE_NAMED(@"switch_on") forState:UIControlStateSelected];
    [_defaultBtn addTarget:self action:@selector(selectDefault:) forControlEvents:UIControlEventTouchUpInside];
    
    _detailedInfo = [[XZTextView alloc]init];
    _detailedInfo.textColor = XZFS_TEXTBLACKCOLOR;
    _detailedInfo.font = XZFS_S_BOLD_FONT(12);
    _detailedInfo.placeholder = @"请填写详细地址";
    _detailedInfo.placeholderFont = XZFS_S_BOLD_FONT(12);
    _detailedInfo.placeholderColor = XZFS_TEXTLIGHTGRAYCOLOR;
    
    
    [self.contentView sd_addSubviews:@[_titleLab,_tf,_contentLab,_selectBtn,_defaultBtn,_detailedInfo]];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _titleLab.frame = CGRectMake(24, 11, 100, 15);
    _tf.frame = CGRectMake(100, 11, self.contentView.width-120, 15);
    _contentLab.frame = CGRectMake(100, 11, self.contentView.width-120, 15);
    _selectBtn.frame = CGRectMake(self.contentView.width-100, 11, 80, 15);
    _defaultBtn.frame =CGRectMake(self.contentView.width-45, 11, 25, 15);
    _detailedInfo.frame = CGRectMake(20, 10, self.contentView.width-40, 78);

}

-(void)refreshContent:(NSString*)content{
    _contentLab.text = content;
}

-(void)selectDefault:(UIButton*)sender{
    
    sender.selected = !sender.selected;
}


-(void)refreshCellWithDic:(NSDictionary*)dic indexPath:(NSIndexPath*)path {
    NSString * title = [[dic allKeys]firstObject];
    _titleLab.text = title;
    _titleLab.hidden = NO;
    if (path.section==0) {
        if (path.row<2) {
            _tf.text = [dic objectForKey:title];
            _contentLab.hidden = YES;
            _selectBtn.hidden = YES;
            _tf.hidden = NO;
            _defaultBtn.hidden = YES;
            _detailedInfo.hidden = YES;
        }else{
            _contentLab.hidden = NO;
            _selectBtn.hidden = NO;
            _tf.hidden = YES;
            _defaultBtn.hidden = YES;
            _detailedInfo.hidden = YES;
            if ([title isEqualToString:@""]) {
                _detailedInfo.hidden = NO;
                _selectBtn.hidden = YES;
                _contentLab.hidden = YES;
            }
        }
    }else{
        _tf.hidden = YES;
        _detailedInfo.hidden = YES;
        _defaultBtn.hidden = NO;
        _selectBtn.hidden = YES;
        _contentLab.hidden = YES;
    }
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
