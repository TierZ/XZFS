//
//  XZMasterOrderVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/12.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterOrderVC.h"
#import "XZMasterOrderDYYVCViewController.h"
#import "XZMasterOrderYYJVC.h"
#import "XZMasterOrderYYYVC.h"
#import "XZMasterOrderYQXVC.h"
@interface XZMasterOrderVC ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView * scroll;
@property (nonatomic,strong)UISegmentedControl * seg;
@property (nonatomic,strong)NSArray * titleArr;
@end

@implementation XZMasterOrderVC{
    UIView * _topView;
    UIView * _redLine;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTop];
    [self setupMain];
    // Do any additional setup after loading the view.
}

-(void)setupTop{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 70)];
    _topView.backgroundColor = XZFS_TEXTORANGECOLOR;
    [self.mainView addSubview:_topView];
    
    UIButton * evaluateLevelBtn = [self setupBtnWithFrame:CGRectMake(0, 0, _topView.width/2, _topView.height) firstStr:@"5.00" secondStr:@"评价星级" method:@selector(evaluateLevel:)];
    [_topView addSubview:evaluateLevelBtn];
    
    UIButton * successRateBtn = [self setupBtnWithFrame:CGRectMake(_topView.width/2, 0, _topView.width/2, _topView.height) firstStr:@"90%" secondStr:@"成交率" method:@selector(successRate:)];
    [_topView addSubview:successRateBtn];
    
    UIView * verticaleLine = [[UIView alloc]initWithFrame:CGRectMake(_topView.width/2-0.5, 15, 0.5, _topView.height-15*2)];
    verticaleLine.backgroundColor = [UIColor whiteColor];
    [_topView addSubview:verticaleLine];
}

-(void)setupMain{
    self.seg.frame = CGRectMake(0, _topView.bottom, SCREENWIDTH, 36);
    [self.mainView addSubview:self.seg];
    
    float lineWidth = (SCREENWIDTH-20*8)/4;
    _redLine = [[UIView alloc]initWithFrame:CGRectMake(20, self.seg.bottom-0.5, lineWidth, 1)];
    _redLine.backgroundColor = XZFS_HEX_RGB(@"#F0AB79");
    [self.mainView addSubview:_redLine];
    
    self.scroll.frame = CGRectMake(0, _redLine.bottom+3, SCREENWIDTH, XZFS_MainView_H-(_redLine.bottom+3));
    self.scroll.contentSize = CGSizeMake(SCREENWIDTH*(int)self.titleArr.count, self.scroll.height);
    [self.mainView addSubview:self.scroll];
    
    XZMasterOrderDYYVCViewController * orderDyyVC = [[XZMasterOrderDYYVCViewController alloc]init];
    [self addChildViewController:orderDyyVC];
    orderDyyVC.view.frame = CGRectMake(0, 0, SCREENWIDTH,self.scroll.height);
    [self.scroll addSubview:orderDyyVC.view];
    
    XZMasterOrderYYYVC * orderYyyVC = [[XZMasterOrderYYYVC alloc]init];
    [self addChildViewController:orderYyyVC];
    orderYyyVC.view.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH,self.scroll.height);
    [self.scroll addSubview:orderYyyVC.view];
    
    XZMasterOrderYYJVC * orderYyjVC = [[XZMasterOrderYYJVC alloc]init];
    [self addChildViewController:orderYyjVC];
    orderYyjVC.view.frame = CGRectMake(SCREENWIDTH*2, 0, SCREENWIDTH,self.scroll.height);
    [self.scroll addSubview:orderYyjVC.view];
    
    XZMasterOrderYQXVC * orderYqxVC = [[XZMasterOrderYQXVC alloc]init];
    [self addChildViewController:orderYqxVC];
    orderYqxVC.view.frame = CGRectMake(SCREENWIDTH*3, 0, SCREENWIDTH,self.scroll.height);
    [self.scroll addSubview:orderYqxVC.view];
                                    
    
}


#pragma mark action
-(void)segChanged:(UISegmentedControl*)seg{
    [_scroll setContentOffset:CGPointMake(SCREENWIDTH*seg.selectedSegmentIndex, 0) animated:YES];
}
-(void)evaluateLevel:(UIButton*)sender{
    NSLog(@"跳转到评价星级");
}
-(void)successRate:(UIButton*)sender{
    NSLog(@"跳转到成交率");
}
#pragma mark scrollDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x==0||scrollView.contentOffset.x==SCREENWIDTH||scrollView.contentOffset.x==SCREENWIDTH*2||scrollView.contentOffset.x==SCREENWIDTH*3) {
        _seg.selectedSegmentIndex = scrollView.contentOffset.x/SCREENWIDTH;
        CGRect frame = _redLine.frame;
        frame.origin.x = 20+(_redLine.width+20*2)*(_seg.selectedSegmentIndex);
        _redLine.frame = frame;
    }
}
#pragma mark getter
-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = @[@"待预约",@"已预约",@"已约见",@"已取消"];
    }
    return _titleArr;
}
-(UIScrollView *)scroll{
    if (!_scroll) {
        _scroll = [[UIScrollView alloc]init];
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.pagingEnabled = YES;
        _scroll.delegate = self;
    }
    return _scroll;
}
-(UISegmentedControl *)seg{
    if (!_seg) {
        _seg =[[UISegmentedControl alloc]initWithItems:self.titleArr];
        [_seg addTarget:self action:@selector(segChanged:) forControlEvents:UIControlEventValueChanged];
        _seg.tintColor=[UIColor whiteColor];
        _seg.backgroundColor = [UIColor whiteColor];
        NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11],
                                                 NSForegroundColorAttributeName: XZFS_TEXTORANGECOLOR};
        
        [_seg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11],
                                                   NSForegroundColorAttributeName: XZFS_TEXTBLACKCOLOR};
        [_seg setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        _seg.selectedSegmentIndex=0;

    }
    return _seg;
}
#pragma mark private
-(UIButton*)setupBtnWithFrame:(CGRect)frame firstStr:(NSString*)firstStr secondStr:(NSString*)secondStr method:(SEL)selector{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    float labFont = 12.0;
    float space = (btn.height-12*2)/3;
    
    
    UILabel * firstLab = [[UILabel alloc]initWithFrame:CGRectMake(0, space, btn.width, 13)];
    firstLab.textColor = [UIColor whiteColor];
    firstLab.font = XZFS_S_BOLD_FONT(labFont);
    firstLab.text = firstStr;
    firstLab.textAlignment = NSTextAlignmentCenter;
    [btn addSubview:firstLab];
    
    UILabel * secondLab = [[UILabel alloc]initWithFrame:CGRectMake(0, firstLab.bottom+space, btn.width, 13)];
    secondLab.textColor = [UIColor whiteColor];
    secondLab.font = XZFS_S_BOLD_FONT(labFont);
    secondLab.text = secondStr;
    secondLab.textAlignment = NSTextAlignmentCenter;
    [btn addSubview:secondLab];
    
    return btn;
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
