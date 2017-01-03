//
//  XZPayMiddleView.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/3.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZPayMiddleView.h"
#import "UIButton+XZImageTitleSpacing.h"

#define RightBtnWidth 60
#define WidthSpace 20

@implementation XZPayMiddleView{
    XZCouponStyle _couponStyle;
    UIButton * _couponSelectBtn;
    UIImageView * _iv;//选择优惠券的图标
    UILabel * _couponLab;//选择优惠券上的lab
     UIButton * _rightBtn;//  如何获取/点我获取
}

- (instancetype)initWithFrame:(CGRect)frame couponStyle:(XZCouponStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        _couponStyle = style;
        [self setupView];
    }
    return self;
}

-(void)setupView{
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 100, 15)];
    title.text = @"优惠券";
    title.font = XZFS_S_FONT(15);
    title.textColor = XZFS_TEXTBLACKCOLOR;
    [self addSubview:title];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, title.bottom+12, self.width-40, 0.5)];
    line.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
    [self addSubview:line];
    
    _couponSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _couponSelectBtn.frame = CGRectMake(40, line.bottom, self.width-40-RightBtnWidth, 40);
    [_couponSelectBtn setImage:XZFS_IMAGE_NAMED(@"chongzhi_unselect@") forState:UIControlStateNormal];
    [_couponSelectBtn setImage:XZFS_IMAGE_NAMED(@"chongzhi_select@") forState:UIControlStateSelected];
    [_couponSelectBtn addTarget:self action:@selector(selectCoupon:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_couponSelectBtn];
    
    _iv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 14.5, 11, 11)];
    _iv.image = XZFS_IMAGE_NAMED(@"chongzhi_unselect@");
    [_couponSelectBtn addSubview:_iv];
    
    _couponLab = [[UILabel alloc]initWithFrame:CGRectMake(_iv.right+16, 14, _couponSelectBtn.width-_iv.right-16, 12)];
    _couponLab.text = @"新用户注册优惠券￥50";
    _couponLab.textColor  = XZFS_HEX_RGB(@"#5A5959");
    _couponLab.font = XZFS_S_FONT(12);
    [_couponSelectBtn addSubview:_couponLab];
    
    UILabel * noCouponLab = [[UILabel alloc]initWithFrame:CGRectMake(40, line.bottom+14, self.width-40-85, 12)];
    noCouponLab.text = @"新用户注册优惠券￥50";
    noCouponLab.textColor  = XZFS_HEX_RGB(@"#5A5959");
    noCouponLab.font = XZFS_S_FONT(12);
    [self addSubview:noCouponLab];
    
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(self.width-80-20, line.bottom+15, RightBtnWidth, 9);
    NSString * rightTitle = _couponStyle?@"如何获取优惠券":@"点我获取优惠券";
    [_rightBtn setTitle:rightTitle forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = XZFS_S_FONT(9);
    [_rightBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(jumpToCoupon:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightBtn];
    

}

-(void)selectCoupon:(UIButton*)sender{
    sender.selected = !sender.selected;
    NSLog(@"选中优惠券");
}

-(void)jumpToCoupon:(UIButton*)sender{
    NSLog(@"跳转到推荐送礼");
}
@end
