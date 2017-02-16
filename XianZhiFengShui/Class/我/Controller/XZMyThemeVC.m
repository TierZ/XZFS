//
//  XZMyThemeVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyThemeVC.h"
#import "XZMyPostedThemeVC.h"
#import "XZMyJoinedThemeVC.h"
#import "XZMyFocusThemeVC.h"



@interface XZMyThemeVC ()<UIScrollViewDelegate>
@property (nonatomic,strong)NSArray * themeArray;
@property (nonatomic,strong)UISegmentedControl * themeSeg;
@property (nonatomic,strong)UIScrollView * themeScroll;
@property (nonatomic,strong)UIView * lineView;
@property (nonatomic,strong)XZMyJoinedThemeVC * myJoinedVC;
@property (nonatomic,strong)XZMyFocusThemeVC * myFocusVC;
@end

@implementation XZMyThemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = RandomColor(1);
    [self setupSeg];
    [self setupScroll];
}

#pragma mark setup
-(void)setupSeg{
    self.themeSeg.frame = CGRectMake(0, 0, SCREENWIDTH, 32);
    [self.mainView addSubview:self.themeSeg];
    self.lineView.frame = CGRectMake(0, self.themeSeg.bottom, SCREENWIDTH/self.themeArray.count, 1);
    [self.mainView addSubview:self.lineView];
}

-(void)setupScroll{
    self.themeScroll.frame = CGRectMake(0, self.lineView.bottom, SCREENWIDTH, XZFS_MainView_H-self.lineView.bottom);
    
    self.themeScroll.contentSize = CGSizeMake(SCREENWIDTH*self.themeArray.count, self.themeScroll.height);
    [self.mainView addSubview:self.themeScroll];

    XZMyPostedThemeVC * myPostedThemeVC = [[XZMyPostedThemeVC alloc]init];
    myPostedThemeVC.view.frame = CGRectMake(0, 0, self.themeScroll.width, self.themeScroll.height);
    [self addChildViewController:myPostedThemeVC];
    [self.themeScroll addSubview:myPostedThemeVC.view];
    
}




#pragma mark action
-(void)selectSegChanged:(UISegmentedControl*)seg{
 self.themeScroll.contentOffset =CGPointMake(seg.selectedSegmentIndex*SCREENWIDTH,0);
}

#pragma mark scroll代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==self.themeScroll) {
        double offsetXRate =  scrollView.contentOffset.x/SCREENWIDTH;
        int selectedIndex = round(offsetXRate);
        self.themeSeg.selectedSegmentIndex = selectedIndex;
        CGRect frame = self.lineView.frame;
        frame.origin.x = self.lineView.width*selectedIndex;
        self.lineView.frame = frame;
    }
    float offsetX = scrollView.contentOffset.x;
    if (offsetX==SCREENWIDTH) {
            if (!self.myJoinedVC) {
                self.myJoinedVC = [[XZMyJoinedThemeVC alloc]init];
                self.myJoinedVC.view.frame = CGRectMake(self.themeScroll.width, 0, self.themeScroll.width, self.themeScroll.height);
                [self addChildViewController:self.myJoinedVC];
                [self.themeScroll addSubview:self.myJoinedVC.view];
            }
    }else if (offsetX==SCREENWIDTH*2){
        if (!self.myFocusVC) {
            self.myFocusVC = [[XZMyFocusThemeVC alloc]init];
            self.myFocusVC.view.frame = CGRectMake(self.themeScroll.width*2, 0, self.themeScroll.width, self.themeScroll.height);
            [self addChildViewController:self.myFocusVC];
            [self.themeScroll addSubview:self.myFocusVC.view];
        }
    }
}

#pragma mark getter

-(NSArray *)themeArray{
    if (!_themeArray) {
        _themeArray = @[ @"我发起的话题",@"我参与的话题",@"我关注的话题" ];
    }
    return _themeArray;
}

-(UISegmentedControl *)themeSeg{
    if (!_themeSeg) {
        _themeSeg =[[UISegmentedControl alloc]initWithItems:self.themeArray];
        [_themeSeg addTarget:self action:@selector(selectSegChanged:) forControlEvents:UIControlEventValueChanged];
        _themeSeg.tintColor=XZFS_NAVICOLOR;
        _themeSeg.backgroundColor = XZFS_NAVICOLOR;
        NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                 NSForegroundColorAttributeName: XZFS_HEX_RGB(@"#eb6000")};
        
        [_themeSeg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                   NSForegroundColorAttributeName: [UIColor blackColor]};
        [_themeSeg setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        _themeSeg.selectedSegmentIndex=0;

    }
    return _themeSeg;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = XZFS_TEXTORANGECOLOR;
    }
    return _lineView;
}

-(UIScrollView *)themeScroll{
    if (!_themeScroll) {
        _themeScroll = [[UIScrollView alloc]init];
        _themeScroll.backgroundColor = [UIColor redColor];
        _themeScroll.pagingEnabled = YES;
        _themeScroll.delegate = self;
    }
    return _themeScroll;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
