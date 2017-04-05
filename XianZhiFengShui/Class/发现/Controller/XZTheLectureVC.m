//
//  XZTheLectureVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/3/14.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZTheLectureVC.h"
#import "XZFindTable.h"
#import "XZFindService.h"
#import "XZLectureDetailData.h"
#import "XZLoginVC.h"
#import "XZTheMasterModel.h"
@interface XZTheLectureVC ()<DataReturnDelegate>
@property (nonatomic,strong)XZFindTable * lectureView;//讲座
@property (nonatomic,strong)NSIndexPath * selectIndex;

@end

@implementation XZTheLectureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLectureView];
}

-(void)setupLectureView{
    self.lectureView = [[XZFindTable alloc]initWithFrame:self.view.bounds style:XZFindLecture];
    self.lectureView.currentVC = self;
    [self.view addSubview:self.lectureView];
    self.lectureView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0,0,0,0));
    
    __weak typeof(self)weakSelf = self;
    [self.lectureView.table refreshListWithBlock:^(int page, BOOL isRefresh) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf requestLectureListWithPage:page];
    }];
    [self.lectureView lectureListCollectionWithBlock:^(NSString *lectureCode, NSIndexPath *indexPath,NSString * isCollect) {
         __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.selectIndex = indexPath;
        NSString * type = [isCollect intValue]>0?@"0":@"1";
        [strongSelf lectureCollectWithType:type lectureCode:lectureCode];
    }];
}
#pragma mark 网络请求
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
 收藏/取消收藏 讲座
 
 @param type        类型（1收藏   0 取消收藏）
 @param lectureCode <#lectureCode description#>
 */
-(void)lectureCollectWithType:(NSString*)type lectureCode:(NSString*)lectureCode{
    NSDictionary * dic = GETUserdefault(@"userInfos");
    BOOL isLogin = [KISDictionaryHaveKey(dic, @"isLogin")boolValue];
    if (!isLogin) {
        [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:NO message:@"请先登录"];
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
    [lectureCollectService collectLectureWithUsercode:userCode lectCode:lectureCode type:type view:self.view];
}

#pragma mark 网络回调

-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    if ([service isKindOfClass:[XZFindService class]]) {
        NSLog(@"讲座啦啦啦successHandle= %@",succeedHandle);
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
            [self.lectureView showNoDataViewWithType:NoDataTypeDefault backgroundBlock:nil btnBlock:^(NoDataType type) {
                [self requestLectureListWithPage:1];
            }];
        }else{
            [self.lectureView hideNoDataView];
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
    if ([service isKindOfClass:[XZFindService class]]) {
        [self.lectureView.table endRefreshFooter];
        [self.lectureView.table endRefreshHeader];
        __weak typeof(self)weakSelf = self;
        [self.lectureView showNoDataViewWithType:NoDataTypeDefault backgroundBlock:nil btnBlock:^(NoDataType type) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf requestLectureListWithPage:1];
        }];
    }
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
