//
//  XZTheMasterView.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/11.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZTheMasterView.h"
#import "XZFindTable.h"
#import "XZTheMasterModel.h"
#import "XZLoginVC.h"

@interface XZTheMasterView ()
@property (nonatomic,strong) XZFindTable * hotMaster;
@property (nonatomic,strong) XZFindTable * localMaster;
@property (nonatomic,strong) XZFindTable * allMaster;
@property (nonatomic,strong) NSIndexPath * selectIndex;
@end

@implementation XZTheMasterView{

    
    UIScrollView * _masterScroll;
    UISegmentedControl * _masterSeg;
    NSString * _userCode;
    NSArray * _segArray;
}

-(instancetype)initWithFrame:(CGRect)frame curVC:(UIViewController*)vc{
    self = [super initWithFrame: frame];
    if (self) {
        _curVC = vc;
        _segArray = @[@"最火",@"本地",@"所有"];
        NSDictionary * dic = GETUserdefault(@"userInfos");
        _userCode = [dic objectForKey:@"bizCode"];
        [self drawSeg];
        [self drawTable];
        [self refreshList];
        [self loadDataWithStyle:MasterHot page:1 isRefresh:YES];
        [self setupBlock];
    }
    return self;
}

-(void)drawSeg{
    _masterSeg =[[UISegmentedControl alloc]initWithItems:_segArray];
    [_masterSeg addTarget:self action:@selector(masterSegChanged:) forControlEvents:UIControlEventValueChanged];
    _masterSeg.frame =  CGRectMake(0, 0, self.width, 32);
    _masterSeg.tintColor=XZFS_NAVICOLOR;
    _masterSeg.backgroundColor = XZFS_NAVICOLOR;
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11],
                                             NSForegroundColorAttributeName: XZFS_HEX_RGB(@"#eb6000")};
    
    [_masterSeg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11],
                                               NSForegroundColorAttributeName: [UIColor blackColor]};
    [_masterSeg setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    _masterSeg.selectedSegmentIndex=0;
    
    [self addSubview:_masterSeg];
}

-(void)drawTable{
    _masterScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 32, self.width, self.height-32)];
    _masterScroll.contentSize = CGSizeMake(self.width*_segArray.count, _masterScroll.height);
    _masterScroll.showsHorizontalScrollIndicator = NO;
    _masterScroll.pagingEnabled = YES;
    _masterScroll.bounces = NO;
    _masterScroll.delegate = self;
    [self addSubview:_masterScroll];
    
     _hotMaster = [[XZFindTable alloc]initWithFrame:CGRectMake(0, 0, _masterScroll.width, _masterScroll.height) style:XZFindMaster];
    _hotMaster.currentVC  = self.curVC;
    [_masterScroll addSubview:_hotMaster];
    
  
    
    _localMaster = [[XZFindTable alloc]initWithFrame:CGRectMake(_masterScroll.width, 0, _masterScroll.width, _masterScroll.height) style:XZFindMaster];
    _localMaster.currentVC  = self.curVC;
    [_masterScroll addSubview:_localMaster];
    
    _allMaster = [[XZFindTable alloc]initWithFrame:CGRectMake(_masterScroll.width*2, 0, _masterScroll.width, _masterScroll.height) style:XZFindMaster];
    _allMaster.currentVC  = self.curVC;
    [_masterScroll addSubview:_allMaster];
}
-(void)setupBlock{
    __weak typeof(self)weakSelf = self;
    [_hotMaster pointOfPraiseMasterWithBlock:^(NSString *masterCode,NSIndexPath * indexPath) {
        [weakSelf pointOfPraiseMasterWithMasterCode:masterCode];
        weakSelf.selectIndex = indexPath;
    }];
    
    [_localMaster pointOfPraiseMasterWithBlock:^(NSString *masterCode,NSIndexPath * indexPath) {
        [weakSelf pointOfPraiseMasterWithMasterCode:masterCode];
        weakSelf.selectIndex = indexPath;
    }];
    
    [_allMaster pointOfPraiseMasterWithBlock:^(NSString *masterCode,NSIndexPath * indexPath) {
        [weakSelf pointOfPraiseMasterWithMasterCode:masterCode];
        weakSelf.selectIndex = indexPath;
    }];
}



-(void)refreshList{
    __weak typeof(self)weakSelf = self;
    [_hotMaster.table refreshListWithBlock:^(int page, BOOL isRefresh) {
        NSLog(@"page= %d,isrefresh = %d",page,isRefresh);
            [weakSelf loadDataWithStyle:MasterHot page:weakSelf.hotMaster.table.row isRefresh:isRefresh];
    }];
    
    [_localMaster.table refreshListWithBlock:^(int page, BOOL isRefresh) {
          NSLog(@"page= %d,isrefresh = %d",page,isRefresh);
   
            [weakSelf loadDataWithStyle:MasterLocal page:weakSelf.localMaster.table.row isRefresh:isRefresh];
    }];

    
    [_allMaster.table refreshListWithBlock:^(int page, BOOL isRefresh) {
          NSLog(@"page= %d,isrefresh = %d",page,isRefresh);
  
            [weakSelf loadDataWithStyle:MasterAll page:weakSelf.allMaster.table.row isRefresh:isRefresh];

    }];

    
}


#pragma mark 网络


/**
 给大师点赞

 @param masterCode 。。
 */
-(void)pointOfPraiseMasterWithMasterCode:(NSString*)masterCode{
    NSDictionary * userDic = GETUserdefault(@"userInfos");
    BOOL isLogin = [[userDic objectForKey:@"isLogin"]boolValue];
    if (isLogin) {
        XZFindService * pointOfPraiseService = [[XZFindService alloc]initWithServiceTag:XZPointOfPraiseMaster];
        pointOfPraiseService.delegate = self;
        [pointOfPraiseService pointOfPraiseMasterWithCityCode:@"110000" masterCode:masterCode userCode:_userCode view:self];
    }else{
        [ToastManager showToastOnView:self position:CSToastPositionCenter flag:NO message:@"请先登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[XZLoginVC alloc]init]];
            nav.navigationBar.hidden = YES;
            [self.curVC.navigationController presentViewController:nav animated:YES completion:nil];

        });
    }
   

}


/**
 获取列表数据

 @param style     类型
 @param page      页码
 @param isrefresh 是否刷新
 */
-(void)loadDataWithStyle:(MasterSelect)style page:(int)page isRefresh:(BOOL) isrefresh{
    int serviceTag;
    int orderType; //（最火，本地，全部）
    XZFindTable * masterTable;
    switch (style) {
        case MasterHot:{
            serviceTag=XZMasterListHot;
            masterTable = _hotMaster;
            orderType = 3;
        }
            break;
        case MasterLocal:{
            serviceTag=XZMasterListLocal;
            masterTable = _localMaster;
            orderType = 2;
        }
            break;
        case MasterAll:{
            serviceTag=XZMasterListAll;
            masterTable = _allMaster;
            orderType = 1;
        }
            break;
        default:
            serviceTag = 0;
            orderType = 0;
            break;
    }
    if ((page==1&& masterTable.data.count<=0)||isrefresh) {
        XZFindService * masterService = [[XZFindService alloc]initWithServiceTag:serviceTag];
        masterService.delegate = self;
        [masterService masterListWithPageNum:page PageSize:10 cityCode:@"110000" keyWord:@"" searchType:1 userCode:_userCode orderType:orderType view:self];
    }
  
}

-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    XZFindService * masterService = (XZFindService*)service;
    switch (masterService.serviceTag) {
        case XZMasterListLocal:
        case XZMasterListHot:
        case XZMasterListAll:{
            NSDictionary * data = (NSDictionary*)succeedHandle;
            NSArray * list = [data objectForKey:@"list"];
            NSMutableArray * modelList = [NSMutableArray array];
            for (int i = 0; i<list.count; i++) {
                XZTheMasterModel * model = [XZTheMasterModel modelWithJSON:list[i]];
                [modelList addObject:model];
            }
            XZFindTable * masterTable = [self selectTableWithTag:masterService.serviceTag];
            NSLog(@"successHandle= %@",list);
            if (masterTable.table.row==1) {
                masterTable.data = [NSMutableArray arrayWithArray:modelList];
            }else{
                [masterTable.data addObjectsFromArray:modelList];
            }
            [masterTable.table endRefreshHeader];
            [masterTable.table endRefreshFooter];
            if (modelList.count<=0) {
                masterTable.table.mj_footer.hidden = YES;
            }
            [masterTable.table reloadData];
        }
            break;
        case XZPointOfPraiseMaster:{
            NSDictionary * dic = (NSDictionary*)succeedHandle;
            if ([KISDictionaryHaveKey(dic, @"affect") intValue]==1) {
                int offset = _masterScroll.contentOffset.x/SCREENWIDTH;
                XZFindTable * masterTable = [self selectTableWithTag: (offset+200)];
                XZTheMasterModel * model = masterTable.data [self.selectIndex.row];
                model.pointOfPraise = [NSString stringWithFormat:@"%d",model.pointOfPraise.intValue+1];
                [masterTable.table reloadData];
            }
            NSLog(@"点赞  %@",succeedHandle);
        }
            break;
        default:
            break;
    }
    
    
}

-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{
     XZFindService * masterService = (XZFindService*)service;
   XZFindTable * masterTable = [self selectTableWithTag:masterService.serviceTag];
    [masterTable.table endRefreshHeader];
    [masterTable.table endRefreshFooter];
}

#pragma mark action

-(void)masterSegChanged:(UISegmentedControl*)seg{
     _masterScroll.contentOffset =CGPointMake(seg.selectedSegmentIndex*SCREENWIDTH,0);
}

#pragma mark scrollDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _masterSeg.selectedSegmentIndex = scrollView.contentOffset.x/SCREENWIDTH;
    if (scrollView.contentOffset.x==0) {
          [self loadDataWithStyle:MasterHot page:1 isRefresh:NO];
    }else if (scrollView.contentOffset.x==SCREENWIDTH){
         [self loadDataWithStyle:MasterLocal page:1 isRefresh:NO];
    }else if (scrollView.contentOffset.x==SCREENWIDTH*2){
        [self loadDataWithStyle:MasterAll page:1 isRefresh:NO];
    }else{
    
    }
}

#pragma mark private

/**
 找到相应的table

 @param tag <#tag description#>

 @return <#return value description#>
 */
-(XZFindTable*)selectTableWithTag:(int)tag{
    XZFindTable * masterTable;
    switch (tag) {
        case XZMasterListHot:{
            masterTable = _hotMaster;
        }
            break;
        case XZMasterListLocal:{
            masterTable = _localMaster;
            
        }
            break;
        case XZMasterListAll:{
            masterTable = _allMaster;
        }
            break;
            
        default:
            masterTable = [XZFindTable new];
            break;
    }
    return masterTable;
}



@end
