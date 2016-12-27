//
//  XZMasterDetailInfo3.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterDetailInfo3.h"
#import "XZMasterDetailTable.h"
#import "XZMasterInfoModel.h"
#import "XZMasterDetailListData.h"

@interface XZMasterDetailInfo3 ()
@property (nonatomic,strong)NSString* masterCode;
@property (nonatomic,weak)XZMasterDetailVC* detailVC;
@end
@implementation XZMasterDetailInfo3{
    XZMasterDetailTable * _masterService;//服务项目
    XZMasterDetailTable * _masterEvaluate;//客户评价
    XZMasterDetailTable * _masterArticle;//大师文章
    
    YYTextView * _aboutMaster;//关于大师
    
    UIScrollView * _masterInfoScroll;
    UISegmentedControl * _masterInfoSeg;
    
    NSArray * _segArray;
}

-(instancetype)initWithFrame:(CGRect)frame masterCode:(NSString*)masterCode detailVC:(XZMasterDetailVC*)detailVC{
    self = [super initWithFrame: frame];
    if (self) {
        _detailVC = detailVC;
        _masterCode = masterCode;
        _segArray = @[@"服务项目",@"关于大师",@"客户评价",@"大师文章"];
        [self drawSeg];
        [self drawTable];
    }
    return self;
}

-(void)drawSeg{
    _masterInfoSeg =[[UISegmentedControl alloc]initWithItems:_segArray];
    [_masterInfoSeg addTarget:self action:@selector(masterSegChanged:) forControlEvents:UIControlEventValueChanged];
    _masterInfoSeg.frame =  CGRectMake(0, 0, self.width, 32);
    _masterInfoSeg.tintColor=XZFS_NAVICOLOR;
    _masterInfoSeg.backgroundColor = XZFS_NAVICOLOR;
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                             NSForegroundColorAttributeName: XZFS_HEX_RGB(@"#eb6000")};
    
    [_masterInfoSeg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                               NSForegroundColorAttributeName: [UIColor blackColor]};
    [_masterInfoSeg setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    _masterInfoSeg.selectedSegmentIndex=0;
    
    [self addSubview:_masterInfoSeg];
}

-(void)drawTable{
    _masterInfoScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 32, self.width, self.height-32)];
    _masterInfoScroll.contentSize = CGSizeMake(self.width*_segArray.count, _masterInfoScroll.height);
    _masterInfoScroll.showsHorizontalScrollIndicator = NO;
    _masterInfoScroll.pagingEnabled = YES;
    _masterInfoScroll.bounces = NO;
    _masterInfoScroll.delegate = self;
    [self addSubview:_masterInfoScroll];
    
    _masterService = [[XZMasterDetailTable alloc]initWithFrame:CGRectMake(0, 0, _masterInfoScroll.width, _masterInfoScroll.height) style:MasterInfoServices];
    _masterService.backgroundColor = [UIColor whiteColor];
    _masterService.currentVC = self.detailVC;
    [_masterInfoScroll addSubview:_masterService];
    
    _aboutMaster = [[YYTextView alloc]initWithFrame:CGRectMake(_masterInfoScroll.width,0, _masterInfoScroll.width, _masterInfoScroll.height)];
    _aboutMaster.backgroundColor = [UIColor whiteColor];
    [_masterInfoScroll addSubview:_aboutMaster];
    
    _masterEvaluate = [[XZMasterDetailTable alloc]initWithFrame:CGRectMake(_masterInfoScroll.width*2,0, _masterInfoScroll.width, _masterInfoScroll.height) style:MasterInfoEvaluate];
    _masterEvaluate.backgroundColor = [UIColor whiteColor];
     _masterEvaluate.currentVC = self.detailVC;
    [_masterInfoScroll addSubview:_masterEvaluate];
    
    _masterArticle = [[XZMasterDetailTable alloc]initWithFrame:CGRectMake( _masterInfoScroll.width*3,0, _masterInfoScroll.width, _masterInfoScroll.height) style:MasterInfoArticle];
    _masterArticle.backgroundColor = [UIColor whiteColor];
     _masterArticle.currentVC = self.detailVC;
    [_masterInfoScroll addSubview:_masterArticle];
    
    [self setupBlock];
}

-(void)setupBlock{
    [_masterService refreshDataWithBlock:^(MasterDetailType type,int page,BOOL isrefresh) {
        
    }];
    
    [_masterArticle refreshDataWithBlock:^(MasterDetailType type,int page,BOOL isrefresh) {
        XZMasterDetailListData * articleListData =[[XZMasterDetailListData alloc]initWithServiceTag:XZMasterArticleList];
        [articleListData articleListWithMasterCode:self.masterCode pageNum:page pageSize:10 cityCode:@"110000" view:self successBlock:^(NSArray *data) {
            if (isrefresh) {
                [_masterArticle.data removeAllObjects];
            }
            [_masterArticle.data addObjectsFromArray:data];
            [_masterArticle.table endRefreshFooter];
            [_masterArticle.table endRefreshHeader];
            if (data.count<=0) {
                _masterArticle.table.mj_footer.hidden = YES;
            }
            if (_masterArticle.data.count<=0) {
                [_masterArticle showNoDataViewWithType:NoDataTypeDefault backgroundBlock:nil btnBlock:^(NoDataType type) {
                }];
            }else{
                [_masterArticle hideNoDataView];
            }
             [_masterArticle.table reloadData];
        } failBlock:^(NSError *error) {
            NSLog(@"失败");
            [_masterArticle.table endRefreshFooter];
            [_masterArticle.table endRefreshHeader];
            [_masterArticle showNoDataViewWithType:NoDataTypeDefault backgroundBlock:nil btnBlock:^(NoDataType type) {
            }];
        }];
    }];
}




#pragma mark data
-(void)setupOriginData:(NSDictionary*)dic{
    if (dic) {
        NSArray * serviceArr = [dic objectForKey:@"serviceType"];
        NSArray * evaluateArr = [dic objectForKey:@"evaluateList"];
        NSArray * articleArr = [dic objectForKey:@"articleList"];
        
        for ( int i = 0; i<serviceArr.count; i++) {
            XZMasterInfoServiceModel * model =[XZMasterInfoServiceModel modelWithDictionary:serviceArr[i]];
            [_masterService.data addObject:model];
        }
        
        for (int i=  0; i<evaluateArr.count; i++) {
            XZMasterInfoEvaluateModel * model = [XZMasterInfoEvaluateModel modelWithDictionary:evaluateArr[i]];
            [_masterEvaluate.data addObject:model];
        }
        
        for (int i=0; i<articleArr.count; i++) {
            XZMasterInfoArticleModel * model = [XZMasterInfoArticleModel modelWithDictionary:articleArr[i]];
            [_masterArticle.data addObject:model];
        }
        
        [_masterArticle.table reloadData];
        [_masterEvaluate.table reloadData];
        [_masterService.table reloadData];
    }
}


#pragma mark action
-(void)masterSegChanged:(UISegmentedControl*)seg{
    _masterInfoScroll.contentOffset =CGPointMake(seg.selectedSegmentIndex*SCREENWIDTH,0);
}

#pragma mark scrollDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _masterInfoSeg.selectedSegmentIndex = scrollView.contentOffset.x/SCREENWIDTH;
    
}



@end
