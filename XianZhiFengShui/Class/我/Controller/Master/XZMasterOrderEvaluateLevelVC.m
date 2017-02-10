//
//  XZMasterOrderEvaluateLevelVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/12.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterOrderEvaluateLevelVC.h"

@interface XZMasterOrderEvaluateLevelVC ()

@end

@implementation XZMasterOrderEvaluateLevelVC{
    UIImageView * _header;
    UILabel * _levelLab;//等级
    UIView * _statV;//星级
    UILabel * _evaluateLab;//评价内容
    UILabel * _avgLevel;//平均星级
    UILabel * _rankRateLab;//排名
    UIScrollView * _mainScrll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"评价星级";
    [self setupMainScroll];
    [self setupHeader];
    [self setupTips];
    // Do any additional setup after loading the view.
}
-(void)setupMainScroll{
    _mainScrll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, XZFS_MainView_H)];
    _mainScrll.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:_mainScrll];
}
-(void)setupHeader{
    float widthScale = SCREENWIDTH/375;
    float heightScale =  SCREENHEIGHT/667;
    
    _header = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375*widthScale, 745/2.0*heightScale)];
    _header.image = XZFS_IMAGE_NAMED(@"chengjiaolv");
    [_mainScrll addSubview:_header];
    
    UILabel * titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 30*heightScale, SCREENWIDTH, 17)];
    titleLab.text = @"近100评价订单平均星级";
    titleLab.font = XZFS_S_BOLD_FONT(18);
    titleLab.textColor = [UIColor whiteColor];
    titleLab.textAlignment =NSTextAlignmentCenter;
    [_header addSubview:titleLab];
    
    _levelLab = [self setupLabelWithFont:38 textColor:[UIColor whiteColor] text:@"--" isBold:YES];
    _levelLab.frame = CGRectMake(0, titleLab.bottom+50*heightScale, SCREENWIDTH, 39);
    _levelLab.textAlignment = NSTextAlignmentCenter;
    [_header addSubview:_levelLab];
    
    _statV = [[UIView alloc]initWithFrame:CGRectMake(0, _levelLab.bottom+12*heightScale, SCREENWIDTH, 21)];
    _statV.backgroundColor = [UIColor clearColor];
    [_header addSubview:_statV];
    
    _evaluateLab = [self setupLabelWithFont:17 textColor:[UIColor whiteColor] text:@"--" isBold:YES];
    _evaluateLab.numberOfLines = 0;
    _evaluateLab.textAlignment = NSTextAlignmentCenter;
    _evaluateLab.frame = CGRectMake(0, _statV.bottom+35*heightScale, SCREENWIDTH, 45);
    [_header addSubview:_evaluateLab];
    
    _avgLevel = [self setupLabelWithFont:20 textColor:[UIColor whiteColor] text:@"--" isBold:YES];
    _avgLevel.textAlignment = NSTextAlignmentCenter;
    _avgLevel.frame = CGRectMake(0, _evaluateLab.bottom+40*heightScale, SCREENWIDTH/2, 20);
    [_header addSubview:_avgLevel];
    
    _rankRateLab = [self setupLabelWithFont:20 textColor:[UIColor whiteColor] text:@"--" isBold:YES];
    _rankRateLab.textAlignment = NSTextAlignmentCenter;
    _rankRateLab.frame = CGRectMake(SCREENWIDTH/2, _evaluateLab.bottom+40*heightScale, SCREENWIDTH/2, 20);
    [_header addSubview:_rankRateLab];
    
    UILabel * avgTextLab = [self setupLabelWithFont:11 textColor:[UIColor whiteColor] text:@"优秀大师平均星级" isBold:YES];
    avgTextLab.textAlignment = NSTextAlignmentCenter;
    avgTextLab.frame = CGRectMake(0, _avgLevel.bottom+13*heightScale, SCREENWIDTH/2, 20);
    [_header addSubview:avgTextLab];
    
    UILabel * rankRateTextLab = [self setupLabelWithFont:11 textColor:[UIColor whiteColor] text:@"您的排名" isBold:YES];
    rankRateTextLab.textAlignment = NSTextAlignmentCenter;
    rankRateTextLab.frame = CGRectMake(SCREENWIDTH/2, _rankRateLab.bottom+13*heightScale, SCREENWIDTH/2, 20);
    [_header addSubview:rankRateTextLab];
    
}

-(void)setupTips{
    UIView * tipHeader = [[UIView alloc]initWithFrame:CGRectMake(0, _header.bottom+10, SCREENWIDTH, 30)];
    tipHeader.backgroundColor = [UIColor whiteColor];
    [_mainScrll addSubview:tipHeader];

    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 15, SCREENWIDTH, 0.5)];
    line.backgroundColor = XZFS_HEX_RGB(@"#EEEFEF");
    [tipHeader addSubview:line];

    UILabel * tipLab = [self setupLabelWithFont:11 textColor:XZFS_TEXTBLACKCOLOR text:@"规则说明" isBold:YES];
    tipLab.backgroundColor = [UIColor whiteColor];
    tipLab.textAlignment = NSTextAlignmentCenter;
    tipLab.frame = CGRectMake((SCREENWIDTH-80)/2, 10, 80, 9);
    [tipHeader addSubview:tipLab];
    
    UILabel * tips = [self setupLabelWithFont:11 textColor:XZFS_HEX_RGB(@"#9FA0A0") text:@"--" isBold:NO];
    tips.numberOfLines = 0;
    tips.text = @"1.评价星级: 有评价订单星级总数÷有评价订单数。如有评价订单星级总数为98，有评价订单数为22，则评价星级为98÷22=4.45\n\n2.评价星级越高，越容易被用户约见，同时也越容易被先知平台在首页推荐。\n\n3.服务过程中给客户在业务水平和服务水平上留下好的印象，可以有助于用户对您评价星级的提高。此外，完成约见后，可在我的订单-已约见中点击[完成服务要评价]向用户索要评价。\n";
    tips.backgroundColor = [UIColor whiteColor];
    tips.frame = CGRectMake(20, tipHeader.bottom, SCREENWIDTH-20*2, 95);
    [tips sizeToFit];
    [_mainScrll addSubview:tips];
    UIView * tipsBgV = [[UIView alloc]initWithFrame:CGRectMake(0, tipHeader.bottom, SCREENWIDTH, tips.height)];
    tipsBgV.backgroundColor = [UIColor whiteColor];
    [_mainScrll insertSubview:tipsBgV belowSubview:tips];
    _mainScrll.contentSize = CGSizeMake(SCREENWIDTH, tips.bottom+10);
}

#pragma mark private
-(UILabel*)setupLabelWithFont:(int)font textColor:(UIColor*)color text:(NSString*)text isBold:(BOOL)isBold{
    UILabel * label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    label.text = text;
    label.font = isBold?XZFS_S_BOLD_FONT(font):XZFS_S_FONT(font);
    return label;
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
