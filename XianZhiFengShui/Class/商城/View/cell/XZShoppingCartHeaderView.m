//
//  XZShoppingCartHeaderView.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/12.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZShoppingCartHeaderView.h"

@implementation XZShoppingCartHeaderView{
    UIButton * _selectAllBtn;//全选
    UILabel * _storeLab;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCartHeader];
    }
    return self;
}

-(void)initCartHeader{
    _selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectAllBtn.frame = CGRectMake(20, 7.5, 20, 20);
    [_selectAllBtn setImage:XZFS_IMAGE_NAMED(@"weixuanzhong") forState:UIControlStateNormal];
     [_selectAllBtn setImage:XZFS_IMAGE_NAMED(@"xuanzhong") forState:UIControlStateSelected];
    [_selectAllBtn addTarget:self action:@selector(selectAllGoos:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_selectAllBtn];
    
    _storeLab = [[UILabel alloc]init];
    _storeLab.backgroundColor = [UIColor clearColor];
    _storeLab.textColor =  XZFS_TEXTBLACKCOLOR;
    _storeLab.textAlignment =NSTextAlignmentLeft;
    _storeLab.font = XZFS_S_FONT(14);
    _storeLab.frame = CGRectMake(_selectAllBtn.right+16, 10, 200, 14);
    [self.contentView addSubview:_storeLab];
    
}

-(void)selectAllGoos:(UIButton*)sender{
    NSLog(@"全选");
    sender.selected = !sender.selected;

}

-(void)setModel:(XZGoodsModel *)model{
    _model = model;
    _storeLab.text = model.storeName;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
