//
//  XZMyMasterVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyMasterVC.h"
#import "XZMyMasterWantedView.h"
#import "XZMyMasterFinishedView.h"
#import "XZFindService.h"
@interface XZMyMasterVC ()
@property (nonatomic,strong)UISegmentedControl * selectSeg;
@property (nonatomic,strong)NSArray * selectArray;
@property (nonatomic,strong)UIView * lineView;
@property (nonatomic,strong)UIScrollView * selectScroll;
@property (nonatomic,strong)XZMyMasterWantedView * wantView;
@property (nonatomic,strong)XZMyMasterFinishedView * finishView;
@end

@implementation XZMyMasterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainView.backgroundColor = RandomColor(1);
    [self setupSeg];
    [self setupScroll];
}
-(void)setupSeg{
    self.selectSeg.frame = CGRectMake(0, 0, SCREENWIDTH, 32);
    [self.mainView addSubview:self.selectSeg];
    float lineWidth = (SCREENWIDTH-20*2)/(int)self.selectArray.count;
    self.lineView.frame = CGRectMake(20, self.selectSeg.bottom-0.5, lineWidth, 1);
    [self.mainView addSubview:self.lineView];

}
-(void)setupScroll{
    self.selectScroll.frame = CGRectMake(0, self.lineView.bottom, SCREENWIDTH, XZFS_MainView_H-self.lineView.bottom);
    [self.mainView addSubview:self.selectScroll];
    self.selectScroll.contentSize = CGSizeMake(self.selectScroll.width*(int)self.selectArray.count, self.selectScroll.height);
    
    self.finishView = [[XZMyMasterFinishedView alloc]initWithFrame:CGRectMake(0, 0, self.selectScroll.width, self.selectScroll.height)];
    self.finishView.weakSelfVC = self;
    [self.selectScroll addSubview:self.finishView];
    
    self.wantView = [[XZMyMasterWantedView alloc]initWithFrame:CGRectMake(self.selectScroll.width, 0, self.selectScroll.width, self.selectScroll.height)];
     self.wantView.weakSelfVC = self;
    [self.selectScroll addSubview:self.wantView];

}

-(void)selectSegChanged:(UISegmentedControl*)seg{
    self.selectScroll.contentOffset = CGPointMake(seg.selectedSegmentIndex*self.selectScroll.width, 0);
}

#pragma mark delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.selectSeg.selectedSegmentIndex = scrollView.contentOffset.x/SCREENWIDTH;
    CGRect frame = self.lineView.frame;
    frame.origin.x = 20+self.lineView.width*self.selectSeg.selectedSegmentIndex;
    self.lineView.frame = frame;
}




#pragma mark getter
-(NSArray *)selectArray{
    if (!_selectArray) {
        _selectArray = @[@"我约过的大师",@"我想约的大师"];
    }
    return _selectArray;
    
}

-(UISegmentedControl *)selectSeg{
    if (!_selectSeg) {
        _selectSeg =[[UISegmentedControl alloc]initWithItems:self.selectArray];
        [_selectSeg addTarget:self action:@selector(selectSegChanged:) forControlEvents:UIControlEventValueChanged];
        //        _selectSeg.frame =  CGRectMake(0, 20, SCREENWIDTH, XZFS_STATUS_BAR_H-22);
        _selectSeg.tintColor=XZFS_NAVICOLOR;
        _selectSeg.backgroundColor = XZFS_NAVICOLOR;
        NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                 NSForegroundColorAttributeName: XZFS_HEX_RGB(@"#eb6000")};
        
        [_selectSeg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                   NSForegroundColorAttributeName: [UIColor blackColor]};
        [_selectSeg setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        _selectSeg.selectedSegmentIndex=0;
    }
    return _selectSeg;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = XZFS_HEX_RGB(@"#eb6000");
    }
    return _lineView;
}

-(UIScrollView *)selectScroll{
    if (!_selectScroll) {
        _selectScroll = [[UIScrollView alloc]init];
        _selectScroll.delegate = self;
        _selectScroll.pagingEnabled = YES;
        _selectScroll.showsHorizontalScrollIndicator = NO;
        _selectScroll.backgroundColor = [UIColor clearColor];
    }
    return _selectScroll;
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
