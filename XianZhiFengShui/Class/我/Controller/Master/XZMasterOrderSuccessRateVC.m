//
//  XZMasterOrderSuccessRateVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/12.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterOrderSuccessRateVC.h"
#import "ArcView.h"
@interface XZMasterOrderSuccessRateVC ()

@end

@implementation XZMasterOrderSuccessRateVC{
    UIImageView * _header;
    UISegmentedControl * _seg;
    ArcView * _archV;
    UILabel * _rateLab;//成交率
    UILabel * _avgRate;//平均成交率
    UILabel * _rankRateLab;//排名
    
    UIScrollView * _mainScroll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"成交率";
    [self setupMainScroll];
    [self setupHeader];
    [self setupTips];
    // Do any additional setup after loading the view.
}

-(void)setupMainScroll{
    _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, XZFS_MainView_H)];
    _mainScroll.backgroundColor = [UIColor clearColor];
  [self.mainView addSubview:_mainScroll];
    _mainScroll.userInteractionEnabled = YES;
}
-(void)setupHeader{
    float widthScale = SCREENWIDTH/375;
    float heightScale =  SCREENHEIGHT/667;
    
    
    _header = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375*widthScale, 745/2.0*heightScale)];
    _header.image = XZFS_IMAGE_NAMED(@"chengjiaolv");
    _header.backgroundColor = [UIColor clearColor];
    _header.userInteractionEnabled = YES;
    [_mainScroll addSubview:_header];
    
    _seg =[[UISegmentedControl alloc]initWithItems:@[@"年成交率",@"月成交率"]];
    _seg.frame = CGRectMake((_header.width-135)/2, 25*heightScale, 135, 24);
    [_seg addTarget:self action:@selector(segChanged:) forControlEvents:UIControlEventValueChanged];
    _seg.tintColor=[UIColor whiteColor];
    _seg.backgroundColor = [UIColor clearColor];
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                             NSForegroundColorAttributeName: XZFS_TEXTORANGECOLOR};
    
    [_seg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                               NSForegroundColorAttributeName: [UIColor whiteColor]};
    [_seg setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    _seg.selectedSegmentIndex=0;
    [_header addSubview:_seg];
    
    _archV = [[ArcView alloc]initWithFrame:CGRectMake((SCREENWIDTH-250)/2, _seg.bottom+20*heightScale, 250, 250) arcWidth:32 current:30 total:100];
    _archV.backgroundColor=[UIColor clearColor];//设置背景色

    [_header addSubview:_archV];
    
    _rateLab = [self setupLabelWithFont:40 textColor:[UIColor whiteColor] text:@"--%" isBold:YES];
    _rateLab.frame = CGRectMake((SCREENWIDTH-250)/2, _seg.bottom+20*heightScale, 250, 250);
    _rateLab.textAlignment = NSTextAlignmentCenter;
    _rateLab.center = _archV.center;
    [_header addSubview:_rateLab];
    
    _avgRate = [self setupLabelWithFont:20 textColor:[UIColor whiteColor] text:@"--%" isBold:YES];
    _avgRate.textAlignment = NSTextAlignmentCenter;
    _avgRate.frame = CGRectMake(0, _archV.bottom+10*heightScale, SCREENWIDTH/2, 20);
    [_header addSubview:_avgRate];
    
    _rankRateLab = [self setupLabelWithFont:20 textColor:[UIColor whiteColor] text:@"--%" isBold:YES];
    _rankRateLab.textAlignment = NSTextAlignmentCenter;
    _rankRateLab.frame = CGRectMake(SCREENWIDTH/2, _archV.bottom+10*heightScale, SCREENWIDTH/2, 20);
    [_header addSubview:_rankRateLab];
    
    UILabel * avgTextLab = [self setupLabelWithFont:11 textColor:[UIColor whiteColor] text:@"优秀大师平均成交率" isBold:YES];
    avgTextLab.textAlignment = NSTextAlignmentCenter;
    avgTextLab.frame = CGRectMake(0, _avgRate.bottom+13*heightScale, SCREENWIDTH/2, 20);
    [_header addSubview:avgTextLab];
    
    UILabel * rankRateTextLab = [self setupLabelWithFont:11 textColor:[UIColor whiteColor] text:@"您的排名" isBold:YES];
    rankRateTextLab.textAlignment = NSTextAlignmentCenter;
    rankRateTextLab.frame = CGRectMake(SCREENWIDTH/2, _rankRateLab.bottom+13*heightScale, SCREENWIDTH/2, 20);
    [_header addSubview:rankRateTextLab];
    
}

-(void)setupTips{
    UIView * tipHeader = [[UIView alloc]initWithFrame:CGRectMake(0, _header.bottom+10, SCREENWIDTH, 30)];
    tipHeader.backgroundColor = [UIColor whiteColor];
    [_mainScroll addSubview:tipHeader];
    
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
    tips.text = @"1.成交率: (应约订单数-取消订单数)÷应约订单数。如12月份应约订单数为98，因各种原因取消约见的订单数为6，则改月成交率为(98-6)÷98=93.88%\n\n2.若取消订单较大，成交率则会下降，将影响您的后续订单质量\n";
    tips.backgroundColor = [UIColor whiteColor];
    tips.frame = CGRectMake(20, tipHeader.bottom, SCREENWIDTH-20*2, 95);
    [tips sizeToFit];
    [_mainScroll addSubview:tips];
    UIView * tipsBgV = [[UIView alloc]initWithFrame:CGRectMake(0, tipHeader.bottom, SCREENWIDTH, tips.height)];
    tipsBgV.backgroundColor = [UIColor whiteColor];
    [_mainScroll insertSubview:tipsBgV belowSubview:tips];
    _mainScroll.contentSize = CGSizeMake(SCREENWIDTH, tips.bottom+10);
}

#pragma mark action
-(void)segChanged:(UISegmentedControl*)seg{
    NSLog(@"切换");
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
