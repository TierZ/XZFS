//
//  XZAddBankCardVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/18.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//


#import "XZAddBankCardVC.h"

@interface XZAddBankCardVC ()
@property (nonatomic,strong)NSArray * titles;
@property (nonatomic,strong)NSArray * placeHolders;
@end

@implementation XZAddBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    // Do any additional setup after loading the view.
}

-(void)setupView{
    UIScrollView * scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, XZFS_MainView_H)];
    [self.mainView addSubview:scroll];
    float tmpHegiht = 0;
    for (int i = 0; i<self.titles.count; i++) {
        UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 8+i*54, SCREENWIDTH, 46)];
        titleView.backgroundColor = [UIColor whiteColor];
        [scroll addSubview:titleView];
        
        UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(20, 16.5, 50 ,13)];
        title.textColor = XZFS_TEXTBLACKCOLOR;
        title.text = self.titles[i];
        title.font = XZFS_S_FONT(13);
        [title sizeToFit];
        [titleView addSubview:title];
        
        UITextField * tf = [[UITextField alloc]initWithFrame:CGRectMake(title.right+20, title.top, titleView.width-50-title.right-20, 13)];
        tf.font = title.font;
        tf.textColor = title.textColor;
        tf.placeholder = self.placeHolders[i];
        [titleView addSubview:tf];
        
        UIImageView * arrow = [UIImageView new];
        arrow.backgroundColor = [UIColor redColor];
        arrow.frame = CGRectMake(titleView.width-7-20, tf.top, 7, 13);
        [titleView addSubview:arrow];
        if (i==self.titles.count-1) {
            tmpHegiht=titleView.bottom;
        }
    }
    
    UIButton * agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.backgroundColor = [UIColor redColor];
    agreeBtn.frame = CGRectMake(20, tmpHegiht+15, 12, 12);
    [scroll addSubview:agreeBtn];
    
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:@"并同意 用户协议"];
    [att addAttribute:NSFontAttributeName value:XZFS_S_FONT(12) range:NSMakeRange(0, att.length)];
    [att addAttribute:NSForegroundColorAttributeName value:XZFS_HEX_RGB(@"#BCBDBE") range:NSMakeRange(0, att.length)];
    [att addAttribute:NSForegroundColorAttributeName value:XZFS_HEX_RGB(@"#FE4A00") range:[[att string]rangeOfString:@"用户协议"]];
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(agreeBtn.right+5, agreeBtn.top, 200, 12)];
    lab.font = XZFS_S_FONT(12);
    lab.textColor = XZFS_HEX_RGB(@"#FE4A00");
    lab.attributedText = att;
    [scroll addSubview:lab];
    
    UIButton * addBankCard = [UIButton buttonWithType:UIButtonTypeCustom];
    addBankCard.frame = CGRectMake(20, lab.bottom+45, SCREENWIDTH-40, 45);
    addBankCard.backgroundColor = XZFS_TEXTORANGECOLOR;
    addBankCard.layer.masksToBounds = YES;
    addBankCard.layer.cornerRadius = 5;
    [addBankCard setTitle:@"添加银行卡" forState:UIControlStateNormal];
    [addBankCard setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBankCard.titleLabel.font = XZFS_S_FONT(18);
    [addBankCard addTarget:self action:@selector(addBankCard:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:addBankCard];
    
    scroll .contentSize = CGSizeMake(SCREENWIDTH, addBankCard.bottom+20);

    
    
}

-(NSArray *)titles{
    if (!_titles) {
        _titles = @[@"卡号",@"卡类型",@"持卡人",@"身份证号码",@"银行预留手机号"];
    }
    return _titles;
}
-(NSArray *)placeHolders{
    if (!_placeHolders) {
        _placeHolders = @[@"请输入您的银行卡号",@"中国银行 储蓄卡",@"请输入持卡人姓名",@"请输入持卡人身份证号码",@"请输入预留手机号"];
    }
    return _placeHolders;
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
