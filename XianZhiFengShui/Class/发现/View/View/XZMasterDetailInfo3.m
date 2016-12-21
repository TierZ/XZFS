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
        [self setupData];
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
    
    _aboutMaster = [[YYTextView alloc]initWithFrame:CGRectMake(_masterInfoScroll.width,0, _masterInfoScroll.width, _masterInfoScroll.height)];
    _aboutMaster.backgroundColor = RandomColor(1);
    [_masterInfoScroll addSubview:_aboutMaster];
    
    _masterEvaluate = [[XZMasterDetailTable alloc]initWithFrame:CGRectMake(_masterInfoScroll.width*2,0, _masterInfoScroll.width, _masterInfoScroll.height) style:MasterInfoEvaluate];
    _masterEvaluate.backgroundColor = RandomColor(1);
    [_masterInfoScroll addSubview:_masterEvaluate];
    
    _masterArticle = [[XZMasterDetailTable alloc]initWithFrame:CGRectMake( _masterInfoScroll.width*3,0, _masterInfoScroll.width, _masterInfoScroll.height) style:MasterInfoArticle];
    _masterArticle.backgroundColor = RandomColor(1);
    [_masterInfoScroll addSubview:_masterArticle];
}

-(void)setupData{
    for ( int i = 0; i<10; i++) {
        XZMasterInfoServiceModel * model =[[XZMasterInfoServiceModel alloc]init];
        model.serviceName = @"买房选址";
        model.serviceContent = @"爱多亏了你们爱傻傻的你女，你空间和我去交通工具哈嘎是的你个，那是的你空间海滩上的那个啊阿打算发领军人物";
        model.servicePrice = @"999";
        model.isAppointment = i%3==0?YES:NO;
        [_masterService.data addObject:model];
    }
    
    for (int i=  0; i<10; i++) {
        XZMasterInfoEvaluateModel * model = [[XZMasterInfoEvaluateModel alloc]init];
        model.evaluateName = @"小米粒";
        model.evaluateTime = @"2016-9-9";
        model.evaluateContent =@"咋着垃圾少打卡上脚后跟阿萨德年痛苦煎熬塑料袋三大师的健康嘎哈";
        [_masterEvaluate.data addObject:model];
    }

    for (int i=0; i<10; i++) {
        XZMasterInfoArticleModel * model = [[XZMasterInfoArticleModel alloc]init];
        model.articleTitle = @"奥斯卡大管卡送的嘛干";
        model.articleDetail = @"昂克赛拉单那个路口见阿斯顿今天就安东尼女，你自己阿尔及全网通阿萨德个垃圾的 干你管卡";
        [_masterArticle.data addObject:model];
    }
    
    [_masterArticle.table reloadData];
    [_masterEvaluate.table reloadData];
    [_masterService.table reloadData];
    
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
