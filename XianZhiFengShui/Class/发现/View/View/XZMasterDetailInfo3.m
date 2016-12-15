//
//  XZMasterDetailInfo3.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterDetailInfo3.h"
#import "XZMasterDetailTable.h"

@implementation XZMasterDetailInfo3{
    XZMasterDetailTable * _masterService;//服务项目
    XZMasterDetailTable * _masterEvaluate;//客户评价
    XZMasterDetailTable * _masterArticle;//大师文章
    
    YYTextView * _aboutMaster;//关于大师
    
    UIScrollView * _masterInfoScroll;
    UISegmentedControl * _masterInfoSeg;
    
    NSArray * _segArray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        
        _segArray = @[@"服务项目",@"关于大师",@"客户评价",@"大师文章"];
        [self drawSeg];
        [self drawTable];
//        [self loadDataWithStyle:MasterHot];
    }
    return self;
}

-(void)drawSeg{
    _masterInfoSeg =[[UISegmentedControl alloc]initWithItems:_segArray];
    [_masterInfoSeg addTarget:self action:@selector(masterSegChanged:) forControlEvents:UIControlEventValueChanged];
    _masterInfoSeg.frame =  CGRectMake(0, 0, self.width, 32);
    _masterInfoSeg.tintColor=XZFS_NAVICOLOR;
    _masterInfoSeg.backgroundColor = XZFS_NAVICOLOR;
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11],
                                             NSForegroundColorAttributeName: XZFS_HEX_RGB(@"#eb6000")};
    
    [_masterInfoSeg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:11],
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
    _masterService.backgroundColor = RandomColor(1);
    [_masterInfoScroll addSubview:_masterService];
    
    _aboutMaster = [[YYTextView alloc]initWithFrame:CGRectMake(0, _masterInfoScroll.width, _masterInfoScroll.width, _masterInfoScroll.height)];
    _aboutMaster.backgroundColor = RandomColor(1);
    [_masterInfoScroll addSubview:_aboutMaster];
    
    _masterEvaluate = [[XZMasterDetailTable alloc]initWithFrame:CGRectMake(0, _masterInfoScroll.width*2, _masterInfoScroll.width, _masterInfoScroll.height) style:MasterInfoEvaluate];
    _masterEvaluate.backgroundColor = RandomColor(1);
    [_masterInfoScroll addSubview:_masterEvaluate];
    
    _masterArticle = [[XZMasterDetailTable alloc]initWithFrame:CGRectMake(0, _masterInfoScroll.width*3, _masterInfoScroll.width, _masterInfoScroll.height) style:MasterInfoArticle];
    _masterArticle.backgroundColor = RandomColor(1);
    [_masterInfoScroll addSubview:_masterArticle];
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
