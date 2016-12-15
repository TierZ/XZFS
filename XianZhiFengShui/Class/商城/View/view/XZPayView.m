//
//  XZPayView.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZPayView.h"

@implementation XZPayView{
    UIView * bgView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    bgView = [UIView new];
    bgView.frame = CGRectMake(0, 9, SCREENWIDTH, 160);
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 100, 13)];
    lab.textColor = XZFS_TEXTBLACKCOLOR;
    lab.font = XZFS_S_FONT(13);
    lab.text  =@"支付方式";
    [bgView addSubview:lab];
    
    UIView * line = [UIView new];
    line.backgroundColor = XZFS_TEXTLIGHTGRAYCOLOR;
    line.frame = CGRectMake(20, lab.bottom+12, SCREENWIDTH-40, 0.5);
    [bgView addSubview:line];
    
    NSArray * selects = @[@"支付宝",@"微信",@"知币"];
    NSArray * images = @[@"zhifubaochongzhi",@"weixinchongzhi",@"zhibi"];
    for (int i = 0; i<selects.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, line.bottom+i*40, SCREENWIDTH, 40);
        [btn addTarget:selects action:@selector(selectStyle:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 10+i;
        [bgView addSubview:btn];
        
        UIView * line2 = [UIView new];
        line2.frame = CGRectMake(69, btn.bottom, SCREENWIDTH-20-69, 0.5);
        line2.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
        [bgView addSubview:line2];
        
        UIImageView * selectIv = [[UIImageView alloc]initWithFrame:CGRectMake(40, 15, 10, 10)];
        selectIv.tag  =99;
        selectIv.image = XZFS_IMAGE_NAMED(@"chongzhi_unselect");
        if (i==0) {
            selectIv.image = XZFS_IMAGE_NAMED(@"chongzhi_select");
        }
        [btn addSubview:selectIv];
        
        UIImageView * iconIv = [[UIImageView alloc]initWithFrame:CGRectMake(selectIv.right+11, 7.5, 25, 25)];
        iconIv.image = XZFS_IMAGE_NAMED(images[i]);
        [btn addSubview:iconIv];
        
        UILabel * nameLab = [[UILabel alloc]initWithFrame:CGRectMake(iconIv.right+16, 13.5, 100, 13)];
        nameLab.font = XZFS_S_FONT(13);
        nameLab.text =selects[i];
        nameLab.textColor = XZFS_TEXTBLACKCOLOR;
        [btn addSubview:nameLab];
    }
  }

-(void)selectStyle:(UIButton*)sender{
    for (UIView * view in bgView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * btn = (UIButton*)view;
            btn.selected = NO;
            UIImageView * iv = (UIImageView*)[btn viewWithTag:99];
            iv.image = XZFS_IMAGE_NAMED(@"chongzhi_unselect");
        }
      
    }
    sender.selected = YES;
    UIImageView * iv = (UIImageView*)[sender viewWithTag:99];
    iv.image = XZFS_IMAGE_NAMED(@"chongzhi_select");
    
    NSLog(@"支付方式");
    NSLog(@"sender.tag = %ld",(long)sender.tag);
    if (self.block) {
        self.block();
    }
}
-(void)selectPayWithBlock:(SelectPayStyleBlock)block{
    self.block = block;
}

@end
