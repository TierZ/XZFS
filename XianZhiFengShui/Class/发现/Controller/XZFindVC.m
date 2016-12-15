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

@interface XZFindVC ()<UIScrollViewDelegate>
@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,strong)UISegmentedControl * titleSeg;
@property (nonatomic,strong)UIView * lineView;
@property (nonatomic,strong)UIScrollView * titleScroll;

@property (nonatomic,strong)XZTheMasterView * mastView;//大师
@property (nonatomic,strong)XZFindTable * lectureView;//讲座
@property (nonatomic,strong)XZFindTable * themeView;//话题
@end

@implementation XZFindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawNaviTag];
    [self drawMainScroll];
//    [self requestMasterListWithPage:1];
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
    
    self.mastView = [[XZTheMasterView alloc]initWithFrame:CGRectMake(0, 0, self.titleScroll.width, self.titleScroll.height) curVC:self];
    [self.titleScroll addSubview:self.mastView];
    
    self.lectureView = [[XZFindTable alloc]initWithFrame:CGRectMake(self.titleScroll.width, 0, self.titleScroll.width, self.titleScroll.height) style:XZFindLecture];
    self.lectureView.backgroundColor = RandomColor(1);
    self.lectureView.currentVC = self;
    [self.titleScroll addSubview:self.lectureView];
    
    self.themeView = [[XZFindTable alloc]initWithFrame:CGRectMake(2*self.titleScroll.width, 0, self.titleScroll.width, self.titleScroll.height) style:XZFindTheme];
    self.themeView.backgroundColor = RandomColor(1);
    self.themeView.currentVC = self;
    [self.titleScroll addSubview:self.themeView];
}



#pragma mark 网络

///**
// 请求大师列表
//
// @param page <#page description#>
// */
//-(void)requestMasterListWithPage:(int)page{
//    XZFindService * masterService = [[XZFindService alloc]initWithServiceTag:XZMasterListHot];
//    masterService.delegate = self;
//    [masterService masterListWithPageNum:page PageSize:10 cityCode:@"110000" view: self.mastView];
//}


/**
 请求讲座列表

 @param page <#page description#>
 */
-(void)requestLectureListWithPage:(int)page{
    XZFindService * lectureService = [[XZFindService alloc]initWithServiceTag:XZLectureList];
    lectureService.delegate = self;
    [lectureService masterListWithPageNum:page PageSize:10 cityCode:@"110000" view: self.mastView];
}


/**
 请求话题列表

 @param page <#page description#>
 */
-(void)requestThemeListWithPage:(int)page{
    XZFindService * themeService = [[XZFindService alloc]initWithServiceTag:XZThemeList];
    themeService.delegate = self;
    [themeService masterListWithPageNum:page PageSize:10 cityCode:@"110000" view: self.mastView];
}


-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    NSLog(@"successHandle= %@",succeedHandle);
}


#pragma mark action
-(void)titleSegChanged:(UISegmentedControl*)seg{
    self.titleScroll.contentOffset =CGPointMake(seg.selectedSegmentIndex*SCREENWIDTH,0);
}

#pragma mark delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
     self.titleSeg.selectedSegmentIndex = scrollView.contentOffset.x/SCREENWIDTH;
  CGRect frame = self.lineView.frame;
    frame.origin.x = self.lineView.width*self.titleSeg.selectedSegmentIndex;
    self.lineView.frame = frame;
    
    if (self.titleSeg.selectedSegmentIndex==1) {
        NSLog(@"请求讲座")
        if (self.lectureView.data.count>0) {
        }else{
            [self requestLectureListWithPage:1];
        }
    }else if (self.titleSeg.selectedSegmentIndex==2){
        NSLog(@"请求话题");
        if (self.themeView.data.count>0) {
        }else{
            [self requestThemeListWithPage:1];
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
