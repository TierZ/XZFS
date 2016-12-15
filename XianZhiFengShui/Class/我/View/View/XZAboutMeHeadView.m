//
//  XZAboutMeHeadView.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZAboutMeHeadView.h"

@implementation XZAboutMeHeadView{
    
    UIImageView * _headIv;
    UILabel * _titleLab;
    UILabel * _detailLab;
    UIButton * _clickBtn;
//    UIImageView * _moneyIv;
//    UIImageView * _arrowIv;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self showInfo];
        
    }
    return self;
}

-(void)showInfo{
    
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 34,self.width, 18)];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.font = XZFS_S_FONT(17);
    _titleLab.text = @"我";
    _titleLab.textColor = [UIColor whiteColor];
    [self addSubview:_titleLab];
    
    
    _headIv = [[UIImageView alloc]init];;
    _headIv.frame = CGRectMake((self.width-62)/2, 64+12, 62, 62);
    _headIv.layer.masksToBounds = YES;
    _headIv.layer.cornerRadius = 31;
    _headIv.image = XZFS_IMAGE_NAMED(@"wotouxiang");
    _headIv.backgroundColor = XZFS_HEX_RGB(@"#DCDDDD");
    [self addSubview:_headIv];
    
    _detailLab = [[UILabel alloc]initWithFrame:CGRectMake(0, _headIv.bottom+21,self.width, 13)];
    _detailLab.textAlignment = NSTextAlignmentCenter;
    _detailLab.font = XZFS_S_FONT(12);
    _detailLab.textColor = [UIColor whiteColor];
    [self addSubview:_detailLab];
    
    _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _clickBtn.backgroundColor = [UIColor clearColor];
    _clickBtn.frame =CGRectMake(0, 64, self.width, self.height-64);
    [self addSubview:_clickBtn];
    [_clickBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    
//    _moneyIv = [[UIImageView alloc]init];
//    _moneyIv.backgroundColor = [UIColor redColor];
//    [self addSubview:_moneyIv];
//    
//    _detailLab = [[UILabel alloc]init];
//    _detailLab.font = XZFS_S_FONT(12);
//    _detailLab.textColor = XZFS_TEXTGRAYCOLOR;
//    [self addSubview:_detailLab];
    
    
//    _arrowIv = [[UIImageView alloc]initWithFrame:CGRectMake(self.width-11-20, self.height/2-9, 11, 18)];
//    _arrowIv.backgroundColor = [UIColor yellowColor];
//    [self addSubview:_arrowIv];

}

-(void)refreshInfoWithLogin:(BOOL)isLogin{
    if (isLogin) {
//        _detailLab.frame = CGRectMake(16, 45, 200, 12);
        _detailLab.text = @"吃不起的potato";
        
//        _moneyIv.hidden = NO;
//        _moneyIv.frame = CGRectMake(16, _titleLab.bottom+15 , 18, 18);
//        
//        _detailLab.frame = CGRectMake(_moneyIv.right+10, _moneyIv.top+3, 200, 12);
//        _detailLab.textColor = XZFS_TEXTORANGECOLOR;
//        _detailLab.font = XZFS_S_FONT(11);
    }else{

        _detailLab.text = @"登录更精彩哦";
        
//        _moneyIv.hidden = YES;
//        
//        _detailLab.frame = CGRectMake(_titleLab.left, _titleLab.bottom+10, 200, 12);
//        _detailLab.textColor = XZFS_TEXTGRAYCOLOR;
//        _detailLab.font = XZFS_S_FONT(11);
//        _detailLab.text = @"登录更精彩哦~！";
    }
}

-(void)click:(UIButton*)sender{
    if (self.block) {
        self.block();
    }
    NSLog(@"跳转");
}

-(void)editInfoWithBlock:(EditInfoBlock)block{
    self.block = block;
}

@end
