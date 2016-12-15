//
//  XZPersonCertificationVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/22.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZPersonCertificationVC.h"

@interface XZPersonCertificationVC ()

@end

@implementation XZPersonCertificationVC{
    UIView * _header;
    UIView * _inputV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"实名认证";
    [self setupHeader];
    [self setupInput];
    [self setupBotton];
    
    __weak typeof(self) weakSelf = self;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        for (UITextField * tf in weakSelf.mainView.subviews) {
            [tf resignFirstResponder];
        }
    }];
    [self.mainView addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}
-(void)setupHeader{
    _header = [UIView new];
    _header.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:_header];
    
    _header.frame = CGRectMake(0, 0, SCREENWIDTH, 100);
    
    UIImageView * headIv = [UIImageView new];
    headIv.backgroundColor = [UIColor redColor];
    [_header addSubview:headIv];
    headIv.frame = CGRectMake(0, 15, 40, 25);
    headIv.centerX = _header.centerX;
    
    UILabel * warnLab = [UILabel new];
    warnLab.font = XZFS_S_FONT(10);
    warnLab.textColor = XZFS_TEXTBLACKCOLOR;
   
    warnLab.numberOfLines = 0;
    
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:@"请提交本人真正的身份信息\n否则将无法获得平台提供的安全保障"];
    [att addAttribute:NSFontAttributeName value:XZFS_S_FONT(10) range:NSMakeRange(0, att.length)];
    [att addAttribute:NSForegroundColorAttributeName value:XZFS_TEXTBLACKCOLOR range:NSMakeRange(0, att.length)];
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = 5;
    [att addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, att.length)];
    
    warnLab.attributedText = att;
     warnLab.textAlignment = NSTextAlignmentCenter;
    
    [_header addSubview:warnLab];
    warnLab.frame = CGRectMake(0, headIv.bottom+18, SCREENWIDTH, 50);

    CGRect frame = _header.frame;
    frame.size.height = warnLab.bottom+18;
    _header.frame = frame;

}
-(void)setupInput{
    _inputV = [UIView new];
    _inputV.backgroundColor = [UIColor whiteColor];
    _inputV.frame = CGRectMake(0, _header.bottom, SCREENWIDTH, 90);
    [self.mainView addSubview:_inputV];

    NSArray * titles = @[@"真实姓名",@"身份证号"];
     NSArray * placeHolders = @[@"请输入真实姓名",@"请输入身份证号"];
    for (int i = 0; i<titles.count; i++) {
        UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(21, 15.5+i*45, 100, 14)];
        titleLab.font = XZFS_S_FONT(14);
        titleLab.textColor  =XZFS_TEXTBLACKCOLOR;
        titleLab.text = titles[i];
        [titleLab sizeToFit];
        [_inputV addSubview:titleLab];
        
        if (i==0) {
            UIView * line = [UIView new];
            line.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
            line.frame = CGRectMake(21, _inputV.height/2, _inputV.width-42, 0.5);
            [_inputV addSubview:line];
        }
        
        UITextField * tf = [[UITextField alloc]initWithFrame:CGRectMake(titleLab.right+35, i*45, _inputV.width-titleLab.right-35-21, 45)];
        tf.placeholder = placeHolders[i];
        tf.font = XZFS_S_FONT(14);
        tf.textColor = XZFS_TEXTBLACKCOLOR;
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_inputV addSubview:tf];
     }
  }
-(void)setupBotton{
    UILabel * tips = [UILabel new];
    tips.frame = CGRectMake(0, _inputV.bottom+20, SCREENWIDTH, 10);
    tips.textColor = XZFS_HEX_RGB(@"#B5B6B6");
    tips.textAlignment = NSTextAlignmentCenter;
    tips.font = XZFS_S_FONT(10);
    tips.text  = @"仅支持中华人民共和国居民身份证进行实名认证";
    [self.mainView addSubview:tips];
    
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(21, tips.bottom+8, SCREENWIDTH-42, 45);
    [submitBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = XZFS_S_FONT(18);
    submitBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5;
    [submitBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:submitBtn];

}

-(void)submit:(UIButton*)sender{
    NSLog(@"提交");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
