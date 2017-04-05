//
//  XZFindVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/8.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//


#import "XZFindVC.h"
#import "XZTheMasterView.h"
#import "XZFindTable.h"
#import "XZTheMasterModel.h"
#import "XZFindService.h"
#import "XZLectureDetailData.h"
#import "XZLoginVC.h"

#import "XZTheLectureVC.h"
#import "XZTheMasterVC.h"
#import "XZTheThemeVC.h"

@interface XZFindVC ()<UIScrollViewDelegate>
@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,strong)UISegmentedControl * titleSeg;
@property (nonatomic,strong)UIView * lineView;
@property (nonatomic,strong)UIScrollView * titleScroll;

@property (nonatomic,strong)XZTheLectureVC * lectureVC;
@property (nonatomic,strong)XZTheThemeVC * themeVC;//话题
@property (nonatomic,strong)NSIndexPath * selectIndex;

@end

@implementation XZFindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawNaviTag];
    [self drawMainScroll];
    

}

#pragma mark drawView
-(void)drawNaviTag{
    
    [self.navView addSubview:self.titleSeg];
    [self.navView addSubview:self.lineView];
}

-(void)drawMainScroll{
    [self.mainView addSubview:self.titleScroll];
    self.titleScroll.bounces = NO;
    self.titleScroll.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-XZFS_STATUS_BAR_H-XZFS_Bottom_H);
    self.titleScroll.contentSize = CGSizeMake(SCREENWIDTH*self.titleArray.count, self.titleScroll.height);
    self.titleScroll.contentOffset = CGPointMake(0, 0);
    
    XZTheMasterVC * masterVC = [[XZTheMasterVC alloc]init];
    [self addChildViewController:masterVC];
    [self.titleScroll addSubview:masterVC.view];
    masterVC.view.frame = CGRectMake(0, 0, self.titleScroll.width, self.titleScroll.height);
}


#pragma mark action
-(void)titleSegChanged:(UISegmentedControl*)seg{
    [self.titleScroll setContentOffset:CGPointMake(seg.selectedSegmentIndex*SCREENWIDTH,0) animated:YES];
}

#pragma mark delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offsetX = scrollView.contentOffset.x/SCREENWIDTH;
    self.titleSeg.selectedSegmentIndex = roundf(offsetX);
    CGRect frame = self.lineView.frame;
    frame.origin.x = self.lineView.width*self.titleSeg.selectedSegmentIndex;
    self.lineView.frame = frame;
    
    if (offsetX==1) {
        if (!self.lectureVC) {
            self.lectureVC = [[XZTheLectureVC alloc]init];
            [self addChildViewController:self.lectureVC];
            [self.titleScroll addSubview:self.lectureVC.view];
            self.lectureVC.view.frame = CGRectMake(self.titleScroll.width, 0, self.titleScroll.width, self.titleScroll.height);
         }
    }else if (offsetX==2){
        if (!self.themeVC) {
            self.themeVC = [[XZTheThemeVC alloc]init];
            [self addChildViewController: self.themeVC];
            [self.titleScroll addSubview: self.themeVC.view];
            self.themeVC.view.frame = CGRectMake(self.titleScroll.width*2, 0, self.titleScroll.width, self.titleScroll.height);
        }
    }
    
    
}

#pragma mark getter
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"大师",@"讲座",@"话题"];
    }
    return _titleArray;
    
}

-(UISegmentedControl *)titleSeg{
    if (!_titleSeg) {
        _titleSeg =[[UISegmentedControl alloc]initWithItems:self.titleArray];
        [_titleSeg addTarget:self action:@selector(titleSegChanged:) forControlEvents:UIControlEventValueChanged];
        _titleSeg.frame =  CGRectMake(0, 20, SCREENWIDTH, XZFS_STATUS_BAR_H-22);
        _titleSeg.tintColor=XZFS_NAVICOLOR;
        _titleSeg.backgroundColor = XZFS_NAVICOLOR;
        NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                 NSForegroundColorAttributeName: XZFS_HEX_RGB(@"#eb6000")};
        
        [_titleSeg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                                   NSForegroundColorAttributeName: [UIColor blackColor]};
        [_titleSeg setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        _titleSeg.selectedSegmentIndex=0;
    }
    return _titleSeg;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, XZFS_STATUS_BAR_H-1, SCREENWIDTH/3, 2)];
        _lineView.backgroundColor = XZFS_HEX_RGB(@"#eb6000");
    }
    return _lineView;
}

-(UIScrollView *)titleScroll{
    if (!_titleScroll) {
        _titleScroll = [[UIScrollView alloc]init];
        _titleScroll.delegate = self;
        _titleScroll.pagingEnabled = YES;
        _titleScroll.showsHorizontalScrollIndicator = NO;
        _titleScroll.backgroundColor = [UIColor clearColor];
    }
    return _titleScroll;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
