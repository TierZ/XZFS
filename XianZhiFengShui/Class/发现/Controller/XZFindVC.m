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

@interface XZFindVC ()<UIScrollViewDelegate>
@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,strong)UISegmentedControl * titleSeg;
@property (nonatomic,strong)UIView * lineView;
@property (nonatomic,strong)UIScrollView * titleScroll;

@property (nonatomic,strong)XZTheMasterView * mastView;//大师
@property (nonatomic,strong)XZFindTable * lectureView;//讲座
@property (nonatomic,strong)XZFindTable * themeView;//话题
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
    
    self.mastView = [[XZTheMasterView alloc]initWithFrame:CGRectMake(0, 0, self.titleScroll.width, self.titleScroll.height) curVC:self];
    [self.titleScroll addSubview:self.mastView];
}



#pragma mark 网络


/**
 请求讲座列表

 @param page <#page description#>
 */
-(void)requestLectureListWithPage:(int)page{
    XZFindService * lectureService = [[XZFindService alloc]initWithServiceTag:XZLectureList];
    lectureService.delegate = self;
    NSDictionary * dic = GETUserdefault(@"userInfos");
    NSString * userCodeStr = KISDictionaryHaveKey(dic, @"bizCode");
    [lectureService lectureListWithPageNum:page PageSize:10 userCode:userCodeStr cityCode:@"110000" view: self.lectureView];
}


/**
 请求话题类型列表

 */
-(void)requestThemeList{
    XZFindService * themeService = [[XZFindService alloc]initWithServiceTag:XZThemeTypeList];
    themeService.delegate = self;
    [themeService themeTypeListWithCityCode:@"110000" view:self.themeView];
}


/**
 收藏/取消收藏 讲座

 @param type        类型（1收藏   0 取消收藏）
 @param lectureCode <#lectureCode description#>
 */
-(void)lectureCollectWithType:(NSString*)type lectureCode:(NSString*)lectureCode{
    NSDictionary * dic = GETUserdefault(@"userInfos");
    BOOL isLogin = [KISDictionaryHaveKey(dic, @"isLogin")boolValue];
    if (!isLogin) {
        [ToastManager showToastOnView:self.mainView position:CSToastPositionCenter flag:NO message:@"请先登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[XZLoginVC alloc]init]];
            nav.navigationBar.hidden = YES;
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        });
        return;
    }
    NSString * userCode = KISDictionaryHaveKey(dic, @"bizCode");
    XZLectureDetailData * lectureCollectService = [[XZLectureDetailData alloc]initWithServiceTag:XZLectureCollection];
    lectureCollectService.delegate = self;
    [lectureCollectService collectLectureWithUsercode:userCode lectCode:lectureCode type:type view:self.mainView];
}

-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    if ([service isKindOfClass:[XZFindService class]]) {
        XZFindService * findService = (XZFindService*)service;
        switch (findService.serviceTag) {
            case XZLectureList:{
                NSLog(@"successHandle= %@",succeedHandle);
                NSArray * lectures = (NSArray*)succeedHandle;
                if (self.lectureView.table.row==1) {
                    [self.lectureView.data removeAllObjects];
                }
                [self.lectureView.data addObjectsFromArray:lectures];
                [self.lectureView.table reloadData];
                [self.lectureView.table endRefreshFooter];
                [self.lectureView.table endRefreshHeader];
                if (lectures.count<=0) {
                    self.lectureView.table.mj_footer.hidden = YES;
                }
                if (self.lectureView.data.count<=0) {
                    [self.mainView showNoDataViewWithType:NoDataTypeDefault backgroundBlock:nil btnBlock:^(NoDataType type) {
                        //                    [self requestLectureListWithPage:1];
                    }];
                }else{
                    [self.mainView hideNoDataView];
                }
            }
                break;
            case XZThemeTypeList:{
                NSLog(@"successHandle2= %@",succeedHandle);
                NSArray * themes = (NSArray*)succeedHandle;
                [self.themeView.data addObjectsFromArray:themes];
                [self.themeView.table reloadData];
                [self.themeView.table endRefreshFooter];
                [self.themeView.table endRefreshHeader];
                if (themes.count<=0) {
                    self.themeView.table.mj_footer.hidden = YES;
                }
                if (self.themeView.data.count<=0) {
                    [self.mainView showNoDataViewWithType:NoDataTypeDefault backgroundBlock:nil btnBlock:^(NoDataType type) {
                        //                    [self requestThemeList];
                    }];
                }else{
                    [self.mainView hideNoDataView];
                }
            }
                break;
            default:
                break;
        }

    }else if ([service isKindOfClass:[XZLectureDetailData class]]){
        NSLog(@"讲座收藏==%@",succeedHandle);
        NSLog(@"讲座收藏有问题");
        NSDictionary * dic = (NSDictionary*)succeedHandle;
        if ([[dic objectForKey:@"statusCode"]intValue]==200) {
            XZTheMasterModel * model = self.lectureView.data[self.selectIndex.row];
            NSString * isCollect = model.collect;
            
            model.collect = isCollect?@"1":@"0";
            [self.lectureView.table reloadData];
        }
        [ToastManager showToastOnView:self.lectureView position:CSToastPositionCenter flag:YES message:[dic objectForKey:@"message"]];
    }
    
}

-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{
//    [self.mainView showNoDataViewWithType:NoDataTypeDefault backgroundBlock:nil btnBlock:nil];
    [self.lectureView.table endRefreshFooter];
    [self.lectureView.table endRefreshHeader];
    
    [self.themeView.table endRefreshHeader];
    [self.themeView.table endRefreshFooter];
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
     __weak typeof(self)weakSelf = self;
    if (scrollView.contentOffset.x==SCREENWIDTH) {
        NSLog(@"请求讲座")
        if (!self.lectureView) {
            self.lectureView = [[XZFindTable alloc]initWithFrame:CGRectMake(self.titleScroll.width, 0, self.titleScroll.width, self.titleScroll.height) style:XZFindLecture];
            self.lectureView.currentVC = self;
            [self.titleScroll addSubview:self.lectureView];
           
            [self.lectureView.table refreshListWithBlock:^(int page, BOOL isRefresh) {
                [weakSelf requestLectureListWithPage:page];
            }];
            [self.lectureView lectureListCollectionWithBlock:^(NSString *lectureCode, NSIndexPath *indexPath,NSString * isCollect) {
                weakSelf.selectIndex = indexPath;
                NSString * type = [isCollect intValue]>0?@"0":@"1";
                [weakSelf lectureCollectWithType:type lectureCode:lectureCode];
            }];
        }
    }else if (scrollView.contentOffset.x==SCREENWIDTH*2){
        NSLog(@"请求话题");
        if (!self.themeView) {
            self.themeView = [[XZFindTable alloc]initWithFrame:CGRectMake(2*self.titleScroll.width, 0, self.titleScroll.width, self.titleScroll.height) style:XZFindTheme];
            self.themeView.currentVC = self;
            [self.titleScroll addSubview:self.themeView];
            [self.themeView.table refreshListWithBlock:^(int page, BOOL isRefresh) {
                [weakSelf requestThemeList];
            }];
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
