//
//  XZMarkScoreVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/17.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMarkScoreVC.h"
#import "LPLevelView.h"
#import "XZFindService.h"
@interface XZMarkScoreVC ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong)UILabel * masterName;
@property (nonatomic,strong)LPLevelView * mark1;//服务态度
@property (nonatomic,strong)LPLevelView * mark2;//专业水平
@property (nonatomic,strong)YYTextView * comment;//评价
@property (nonatomic,strong)UIButton * submit;//提交
@property (nonatomic,assign) NSInteger starCount1;//星星 数量
@property (nonatomic,assign) NSInteger starCount2;//

@end

@implementation XZMarkScoreVC{
    NSString * _masterCode;

}

- (instancetype)initWithMasterCode:(NSString*)masterCode
{
    self = [super init];
    if (self) {
        _masterCode = masterCode;
        _masterCode = @"bd35193472fa43d6b6aa7cdcf96d4c33";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text  =@"评价大师";
    [self setupView];
}

-(void)setupView{
    UIView * commentV = [UIView new];
    commentV.backgroundColor = [UIColor whiteColor];
    commentV.frame = CGRectMake(0, 0, SCREENWIDTH, 340);
    [self.mainView addSubview:commentV];
    
    NSArray * leftTitles = @[ @"服务大师:", @"服务态度:",@"专业水平:"];
    for (int i = 0; i<leftTitles.count; i++) {
        UILabel * leftLab = [[UILabel alloc]initWithFrame:CGRectMake(23, 18+i*36, 100, 14)];
        leftLab.text = leftTitles[i];
        leftLab.font = XZFS_S_FONT(14);
        leftLab.textColor = XZFS_TEXTBLACKCOLOR;
        [leftLab sizeToFit];
        [commentV addSubview:leftLab];
    }
    
    self.masterName.frame = CGRectMake(92, 18, 100, 14);
    self.mark1.frame = CGRectMake(92, self.masterName.bottom+19, 160, 20);
    self.mark2.frame = CGRectMake(92, self.mark1.bottom+15, 160, 20);
    
    [commentV addSubview:self.masterName];
    [commentV addSubview:self.mark1];
    [commentV addSubview:self.mark2];

    UILabel * commentLab = [[UILabel alloc]initWithFrame:CGRectMake(23, self.mark2.bottom+35, 100, 14)];
    commentLab.text = @"详细评价";
    commentLab.textColor = XZFS_TEXTBLACKCOLOR;
    commentLab.font = XZFS_S_FONT(14);
    [commentV addSubview:commentLab];
    
    self.comment.frame = CGRectMake(23, commentLab.bottom+8, commentV.width-23*2, 160);
    self.comment.layer.masksToBounds = YES;
    self.comment.layer.borderWidth = 0.5;
    self.comment.layer.borderColor = XZFS_HEX_RGB(@"#E6E6E7").CGColor;
    self.comment.layer.cornerRadius  =3;
    
    [commentV addSubview:self.comment];
    
    self.submit.frame = CGRectMake(23, commentV.bottom+20, SCREENWIDTH-23*2, 45);
    [self.mainView addSubview:self.submit];
    
    __weak typeof(self) weakSelf = self;
    [_mark1 setScoreBlock:^(float star) {
        weakSelf.starCount1 = star;
    }];
    
    [_mark2 setScoreBlock:^(float star) {
        weakSelf.starCount2 = star;
    }];

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        [weakSelf.comment resignFirstResponder];
    }];
    tap.delegate  =self;
    [commentV addGestureRecognizer:tap];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"YYTextView"]) {
        return NO;
    }
    return YES;
}

-(void)submitComment:(UIButton*)sender{
    NSLog(@"star1 = %.2ld  star2 = %.2ld  comment = %@",(long)self.starCount1,(long)self.starCount2,self.comment.text);
    if (self.comment.text.length>0) {
        [self evaluateMaster];
    }else{
        [ToastManager showToastOnView:self.mainView position:CSToastPositionCenter flag:NO message:@"评价内容不能为空"];
    }
    NSLog(@"提交");
}


#pragma mark 网络
-(void)evaluateMaster{
    NSDictionary * userInfo = GETUserdefault(@"userInfo");
    NSString * userCode = [userInfo objectForKey:@"bizCode"];
    XZFindService * evaluateService = [[XZFindService alloc]initWithServiceTag:XZEvaluateMaster];
    evaluateService.delegate = self;
    [evaluateService evaluateMasterWithMasterCode:_masterCode userCode:userCode content:self.comment.text cityCode:@"110000" masterOrderCode:@"123123" star:(self.starCount1+self.starCount2) view:self.mainView];
}
-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    NSLog(@"successhandle = %@",succeedHandle);
}

#pragma mark getter
-(UILabel *)masterName{
    if (!_masterName) {
        _masterName = [[UILabel alloc]init];
        _masterName.textColor =  XZFS_TEXTBLACKCOLOR;
        _masterName.textAlignment =NSTextAlignmentLeft;
        _masterName.font = XZFS_S_FONT(14);
        _masterName.text  =@"--";
    }
    return _masterName;
}

-(LPLevelView *)mark1{
    if (!_mark1) {
        _mark1 = [[LPLevelView alloc]init];
        _mark1.canScore = YES;
        _mark1.animated = YES;
        _mark1.level = 0;
        _mark1.iconSize = CGSizeMake(33, 33);
        _mark1.iconFull = [UIImage imageNamed:@"xingxing_full"];
//        _mark1.iconHalf = [UIImage imageNamed:@"vedio_record_comment_tankuang_img_star_yellow"];
        _mark1.iconHalf = [UIImage imageNamed:@"xingxing_empty"];
         _mark1.iconEmpty = [UIImage imageNamed:@"xingxing_empty"];
    }
    return _mark1;
}

-(LPLevelView *)mark2{
    if (!_mark2) {
        _mark2 = [[LPLevelView alloc]init];
        _mark2.canScore = YES;
        _mark2.animated = YES;
        _mark2.level = 0;
        _mark2.iconSize = CGSizeMake(20, 20);
        _mark2.iconFull = [UIImage imageNamed:@"xingxing_full"];
        _mark2.iconHalf = [UIImage imageNamed:@"xingxing_empty"];
        _mark2.iconEmpty = [UIImage imageNamed:@"xingxing_empty"];

    }
    return _mark2;
}

-(YYTextView *)comment{
    if (!_comment) {
        _comment = [[YYTextView alloc]init];
        _comment.placeholderText = @"请输入评价";
        _comment.textColor = XZFS_TEXTBLACKCOLOR;
        _comment.font = XZFS_S_FONT(13);
        _comment.placeholderFont = XZFS_S_FONT(13);
    }
    return _comment;
}

-(UIButton *)submit{
    if (!_submit) {
        _submit = [UIButton buttonWithType:UIButtonTypeCustom];
        _submit.backgroundColor = XZFS_TEXTORANGECOLOR;
        [_submit setTitle:@"提交评价" forState:UIControlStateNormal];
        [_submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submit.titleLabel.font = XZFS_S_FONT(18);
        [_submit addTarget:self action:@selector(submitComment:) forControlEvents:UIControlEventTouchUpInside];
        _submit.layer.masksToBounds = YES;
        _submit.layer.cornerRadius  =5;
    }
    return _submit;
    
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
