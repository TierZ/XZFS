//
//  XZMasterDetailVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#define headHeight 165
#import "XZMasterDetailVC.h"
#import "XZMasterDetailInfo.h"//头部
#import "XZMasterDetailInfo2.h"//中间
#import "XZMasterDetailInfo3.h"//主要部分
#import "XZFindService.h"

@interface XZMasterDetailVC ()
@property (nonatomic,strong)XZMasterDetailInfo * headInfo;//头部信息
@property (nonatomic,strong)XZMasterDetailInfo2 * middleInfo;//中间标签
@property (nonatomic,strong)XZMasterDetailInfo3 * mainInfo;//主要业务
@property (nonatomic,strong)UIButton * collectBtn;//收藏
@property (nonatomic,copy)NSString * masterCode;
@end

@implementation XZMasterDetailVC

- (instancetype)initWithMasterCode:(NSString *)masterCode
{
    self = [super init];
    if (self) {
        _masterCode = masterCode;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"大师详情";
    
    [self setupHeader];
    [self setupMiddle];
    [self setupMain];
    [self setupCollect];
    
    [self requestMasterInfo];
 
}

#pragma mark view
-(void)setupHeader{
    UIImageView * headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, headHeight)];
    headView.backgroundColor = [UIColor whiteColor];
    headView.tag = 10;
    [self.mainView addSubview:headView];
    
    self.headInfo = [[XZMasterDetailInfo alloc]initWithFrame:CGRectMake(headView.width-95-15, 18, 95, headView.height-18*2)];
    self.headInfo.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [headView addSubview:self.headInfo];
}

-(void)setupMiddle{
    self.middleInfo = [[XZMasterDetailInfo2 alloc]initWithFrame:CGRectMake(0, headHeight, SCREENWIDTH, 35) Titles:@[ @"-",@"-",@"-",@"-" ]];
    self.middleInfo.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:self.middleInfo];
    [self.middleInfo btnClickWithBlock:^(BtnTag tag) {
        switch (tag) {
            case PointOfPraiseTag:{
                NSLog(@"点赞");
                [self pointOfPraiseMaster];
            }
                break;
            case CollectedTag:
                NSLog(@"收藏");
                break;
                
            default:
                break;
        }
    }];
}
-(void)setupMain{
    self.mainInfo = [[XZMasterDetailInfo3 alloc]initWithFrame:CGRectMake(0, self.middleInfo.bottom+7, SCREENWIDTH, SCREENHEIGHT-XZFS_STATUS_BAR_H-45-self.middleInfo.bottom-7) masterCode:self.masterCode detailVC:self];
    [self.mainView addSubview:self.mainInfo];
}

-(void)setupCollect{
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.frame = CGRectMake(0, self.mainInfo.bottom, SCREENWIDTH, 45);
    self.collectBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
    [self.collectBtn setTitle:@"收藏大师" forState:UIControlStateNormal];
     [self.collectBtn setTitle:@"已收藏大师" forState:UIControlStateSelected];
    [self.collectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.collectBtn.titleLabel.font = XZFS_S_FONT(20);
    [self.collectBtn addTarget:self action:@selector(collectMaster:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:self.collectBtn];

}

#pragma mark action
-(void)collectMaster:(UIButton*)sender{
    NSInteger type;
    if (sender.selected) {
        type = 2;
    }else{
        type = 1;
    }
    [self collectionMasterWithType:type];
}

#pragma mark 网络
-(void)requestMasterInfo{
    NSDictionary * dic = GETUserdefault(@"userInfo");
    NSString * userCode = [dic objectForKey:@"bizCode"]?:@"";
    XZFindService * masterInfo = [[XZFindService alloc]initWithServiceTag:XZMasterDetail];
    masterInfo.delegate = self;
    [masterInfo masterDetailWithMasterCode:self.masterCode UserCode:userCode cityCode:@"110000" view:self.mainView];
}



-(void)collectionMasterWithType:(NSInteger)type{
    NSDictionary * dic = GETUserdefault(@"userInfo");
    NSString * userCode = [dic objectForKey:@"bizCode"];
    XZFindService * collectMasterService = [[XZFindService alloc]initWithServiceTag:XZCollectionMaster];
    collectMasterService.delegate = self;
    [collectMasterService collectMasterWithMasterCode:self.masterCode userCode:userCode type:type cityCode:@"110000" view:self.mainView];
}

-(void)pointOfPraiseMaster{
    NSDictionary * dic = GETUserdefault(@"userInfo");
    NSString * userCode = [dic objectForKey:@"bizCode"];
    XZFindService * pointOfPraiseService = [[XZFindService alloc]initWithServiceTag:XZPointOfPraiseMaster];
    pointOfPraiseService.delegate = self;
    [pointOfPraiseService pointOfPraiseMasterWithCityCode:@"110000" masterCode:self.masterCode userCode:userCode view:self.mainView];
    
}


-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    XZFindService * masterService = (XZFindService*)service;
    switch (masterService.serviceTag) {
        case XZMasterDetail:{
            NSDictionary * dic = (NSDictionary*)succeedHandle;
            UIImageView * iv = (UIImageView*)[self.mainView viewWithTag:10];
            [iv setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"icon"]] options:YYWebImageOptionProgressive];
            [self.headInfo refreshInfoWithDic:dic];
            [self.middleInfo refreshInfoWithDic:dic];
            [self.mainInfo setupOriginData:dic];
            NSLog(@"XZMasterDetail = %@",succeedHandle);
        }
            break;
        case XZCollectionMaster:
            NSLog(@"XZCollectionMaster = %@",succeedHandle);
            break;
        case XZPointOfPraiseMaster:
            NSLog(@"XZPointOfPraiseMaster = %@",succeedHandle);
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
