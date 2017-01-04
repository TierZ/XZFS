//
//  XZMasterAddServiceVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/4.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterAddServiceVC.h"
#import "XZTextView.h"
@interface XZMasterAddServiceVC ()<UITextViewDelegate>
@property (nonatomic,strong)UILabel * tagLab;
@property (nonatomic,strong)UIView * tagV;
@property (nonatomic,strong)UILabel * contentLab;
@property (nonatomic,strong)UILabel * priceLab;
@property (nonatomic,strong)UILabel * yuanLab;
@property (nonatomic,strong)UITextField * priceTf;
@property (nonatomic,strong)XZTextView * contentTV;
@property (nonatomic,assign)float textviewHeight;
@end

@implementation XZMasterAddServiceVC{
    NSMutableString * _typeCode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"添加服务项目";
    _textviewHeight = 31;
    _typeCode = [[NSMutableString alloc]initWithString:@""];
    [self setupTag];
    [self setupContent];
    [self setupPrice];
    // Do any additional setup after loading the view.
}

-(void)setupTag{
    
    NSString *meListPath = [[NSBundle mainBundle] pathForResource:@"SkillTags" ofType:@"plist"];
      NSArray * _tags =  [[NSArray alloc]initWithContentsOfFile:meListPath];
  
    
    _tagLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 100, 13)];
    _tagLab.text = @"服务项目类别";
    _tagLab.font = XZFS_S_FONT(13);
    _tagLab.textColor = XZFS_TEXTBLACKCOLOR;
    [self.mainView addSubview:_tagLab];
    float verticalSpace = 9;
    float btnHeight = 24;
    float btnWidth = 75;
    float leftWidth = 22;
    float lineSpace = ((SCREENWIDTH-40)-leftWidth*2-btnWidth*3)/2;
    int lineCount = _tags.count%3==0?(int)_tags.count/3:(1+(int)(_tags.count/3));
    _tagV = [[UIView alloc]initWithFrame:CGRectMake(20, _tagLab.bottom+11, SCREENWIDTH-40, lineCount*btnHeight+verticalSpace*(lineCount+1))];
    _tagV.layer.masksToBounds = YES;
    _tagV.layer.cornerRadius = 4;
    [self.mainView addSubview:_tagV];
    _tagV.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i<_tags.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(leftWidth+(i%3)*(btnWidth+lineSpace), verticalSpace+(i/3)*(btnHeight+verticalSpace), 75, 24);
        [btn setTitle:_tags[i] forState:UIControlStateNormal];
        [btn setTitleColor:XZFS_HEX_RGB(@"#B5B6B6") forState:UIControlStateNormal];
        [btn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateSelected];
        btn.titleLabel.font = XZFS_S_FONT(12);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius  =5;
        btn.layer.borderColor = XZFS_HEX_RGB(@"#B5B6B6").CGColor;
        btn.layer.borderWidth = 1;
        btn.tag = 200+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tagV addSubview:btn];
    }
}

/**
 服务项目介绍
 */
-(void)setupContent{
    _contentLab = [[UILabel alloc]init];
    _contentLab.text = @"服务项目介绍";
    _contentLab.textColor = XZFS_TEXTBLACKCOLOR;
    _contentLab.font = XZFS_S_FONT(12);
    _contentLab.frame = CGRectMake(20, _tagV.bottom+12, 100, 13);
    [self.mainView addSubview:_contentLab];
    
    self.contentTV = [[XZTextView alloc]initWithFrame:CGRectMake(_tagLab.left, _contentLab.bottom+12, SCREENWIDTH-40, _textviewHeight)];
    self.contentTV.placeholder = @"请输入话题详细内容";
    self.contentTV.textColor =XZFS_TEXTBLACKCOLOR;
    self.contentTV.font = XZFS_S_FONT(12);
    self.contentTV.delegate = self;
    self.contentTV.returnKeyType = UIReturnKeyDone;
    self.contentTV.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:self.contentTV];
    
    __weak typeof(self)weakSelf = self;
    [self.contentTV textHeightDidChanged:^(NSString *text, float textHeight) {
        weakSelf.textviewHeight = textHeight;
        weakSelf.contentTV.frame = CGRectMake(weakSelf.tagLab.left, weakSelf.contentLab.bottom+12, SCREENWIDTH-40, weakSelf.textviewHeight);
        weakSelf.priceLab.frame = CGRectMake(20, weakSelf.contentTV.bottom+12, 100, 13);
        weakSelf.priceTf.frame = CGRectMake(weakSelf.priceLab.left, weakSelf.priceLab.bottom+12, 70, 30);
        weakSelf.yuanLab.frame = CGRectMake(weakSelf.priceTf.right+17, weakSelf.priceTf.top+7.5, 17, 15);
    }];
    self.contentTV.maxRow = 4;
    self.contentTV.lineSpace = 5;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5; //行距
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:12], NSParagraphStyleAttributeName:paragraphStyle};
    self.contentTV.typingAttributes = attributes;
    
}

-(void)setupPrice{
    self.priceLab = [[UILabel alloc]init];
    self.priceLab.text = @"服务报价";
    self.priceLab.textColor = XZFS_TEXTBLACKCOLOR;
    self.priceLab.font = XZFS_S_FONT(12);
    self.priceLab.frame = CGRectMake(20, self.contentTV.bottom+12, 100, 13);
    [self.mainView addSubview:self.priceLab];
    
    self.priceTf = [[UITextField alloc]initWithFrame:CGRectMake(self.priceLab.left, self.priceLab.bottom+12, 70, 30)];
    self.priceTf.textColor = XZFS_TEXTBLACKCOLOR;
    self.priceTf.font = XZFS_S_FONT(15);
    self.priceTf.backgroundColor = [UIColor whiteColor];
    self.priceTf.textAlignment = NSTextAlignmentCenter;
    [self.mainView addSubview:self.priceTf];
    
    self.yuanLab = [[UILabel alloc]initWithFrame:CGRectMake(self.priceTf.right+17, self.priceTf.top+7.5, 17, 15)];
    self.yuanLab.text = @"元";
    self.yuanLab.font = XZFS_S_FONT(15);
    self.yuanLab.textColor = XZFS_TEXTBLACKCOLOR;
    [self.mainView addSubview:self.yuanLab];

}

-(void)setupBottom{
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(0, XZFS_MainView_H-45, SCREENWIDTH, 45);
    submitBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.titleLabel.font = XZFS_S_FONT(18);
    [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:submitBtn];
}

#pragma mark action
-(void)btnClick:(UIButton*)sender{
    sender.selected = !sender.selected;
    sender.layer.borderColor = sender.selected?XZFS_TEXTORANGECOLOR.CGColor:XZFS_HEX_RGB(@"#B5B6B6").CGColor;
    NSLog(@"选择的 标签--%ld",(long)sender.tag);
    
}

-(void)submit{
    NSLog(@"提交1");
    if ([self checkInputData]) {
        NSLog(@"提交2");
    }
}

-(BOOL)checkInputData{
    for (UIButton*btn in self.tagV.subviews) {
        if (btn.selected) {
            [_typeCode appendString:btn.titleLabel.text];
        }
    }
    if ([_typeCode isEqualToString:@""]) {
        [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:NO message:@"服务项目不能为空"];
        return NO;
    }else if ([_contentTV.text isEqualToString:@""]){
        [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:NO message:@"服务介绍不能为空"];
        return NO;
    }else if ([_priceTf.text isEqualToString:@""]){
        [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:NO message:@"价格不能为空"];
        return NO;
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
