//
//  XZMyMasterFinishedVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/20.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMyMasterFinishedVC.h"
#import "XZRefreshTable.h"
#import "XZMyMasterInProgressCell.h"
#import "XZMyMasterFinishedCell.h"
#import "XZMasterDetailVC.h"
#import "XZMyEvaluateVC.h"
#import "XZMarkScoreVC.h"
#import "JCHATConversationController.h"
#import "XZUserCenterService.h"
@interface XZMyMasterFinishedVC ()<UITableViewDataSource,UITableViewDelegate,DataReturnDelegate>
@property (nonatomic,strong)XZRefreshTable * finishedMaster;//完成的
@property (nonatomic,strong)XZRefreshTable * finishingMaster;//进行中
@property (nonatomic,assign)int  searchType;;
@end

@implementation XZMyMasterFinishedVC

-(void)loadData{
    for (int i = 0; i<10; i++) {
        XZTheMasterModel * model = [[XZTheMasterModel alloc]init];
        model.icon = @"http://navatar.shagualicai.cn/uid/150922010117012662";
        model.masterName = @"张三丰";
        model.level = @"V1";
        model.isFinished = NO;
        model.startTime = @"2016-10-11 11:30";
        model.service = @"服务项目：按时大大人家阿萨德v";
        if (i%3==0) {
            model.isFinished = YES;
            model.service = @"服务项目：通古至今，上下五千年麻醉学聪明阿萨德";
        }
        model.price = @"￥88 知币";
        [self.finishedMaster.dataArray addObject:model];
    }
    [self.finishedMaster reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.finishedMaster];
    [self.view addSubview:self.finishingMaster];
    self.finishingMaster.hidden = YES;
    self.finishedMaster.hidden = NO;
    self.finishedMaster.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    self.finishingMaster.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
//    [self loadData];
    
    __weak typeof(self)weakSelf = self;
    [self.finishedMaster refreshListWithBlock:^(int page, BOOL isRefresh) {
        [weakSelf loadFinishedDataWithPageNum:page];
    }];
    
    [self.finishingMaster refreshListWithBlock:^(int page, BOOL isRefresh) {
        [weakSelf loadFinishingDataWithPageNum:page];
    }];
}

-(void)selectDataIsFinished:(BOOL)isFinished{
    self.finishingMaster.hidden = isFinished;
    self.finishedMaster.hidden = !isFinished;
    
}

#pragma mark 网络
//完成的大师
-(void)loadFinishedDataWithPageNum:(int)pageNum{
    XZUserCenterService * myMasterFinishedService = [[XZUserCenterService alloc]initWithServiceTag:XZMyMasterFinishedTag];
    myMasterFinishedService.delegate = self;
    NSDictionary * dic = GETUserdefault(@"userInfos");
    NSString * userCode = [dic objectForKey:@"bizCode"];
    [myMasterFinishedService myFinishedMasterWithUserCode:userCode pageNum:pageNum PageSize:10 cityCode:@"110000" view:self.view];
}
//进行中的大师
-(void)loadFinishingDataWithPageNum:(int)pageNum{
    XZUserCenterService * myMasterFinishingService = [[XZUserCenterService alloc]initWithServiceTag:XZMyMasterFinishingTag];
    myMasterFinishingService.delegate = self;
    
    NSString * userCode = [GETUserdefault(@"userInfos")objectForKey:@"bizCode"];
    [myMasterFinishingService myFinishingMasterWithUserCode:userCode pageNum:pageNum PageSize:10 cityCode:@"110000" view:self.view];
}



-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    XZUserCenterService * myMasterService = (XZUserCenterService*)service;
    switch (myMasterService.serviceTag) {
        case XZMyMasterFinishedTag:{
            NSLog(@"完成的==%@",succeedHandle);
            NSArray * array = (NSArray*)succeedHandle;
            [self showDataAfterNetRequestWithArray:array isFinished:YES];
        }
            break;
        case XZMyMasterFinishingTag:{
             NSLog(@"进行中的==%@",succeedHandle);
            NSArray * array = (NSArray*)succeedHandle;
            [self showDataAfterNetRequestWithArray:array isFinished:NO];
        }
            break;
            
        default:
            break;
    }
}
-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{
      XZUserCenterService * myMasterService = (XZUserCenterService*)service;
    switch (myMasterService.serviceTag) {
        case XZMyMasterFinishedTag:{
            [self showDataAfterNetRequestWithArray:@[] isFinished:YES];
        }
        case XZMyMasterFinishingTag:{
            [self showDataAfterNetRequestWithArray:@[] isFinished:NO];
        }
            break;
            
        default:
            break;
    }
}



#pragma mark table 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.finishedMaster.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * progressingCellId = @"progressingCellId";
    static NSString * finishedCellId = @"finishedCellId";
    
    XZMyMasterInProgressCell * progressCell = [tableView dequeueReusableCellWithIdentifier:progressingCellId];
    if (!progressCell) {
        progressCell = [[XZMyMasterInProgressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:progressingCellId];
        [progressCell messageWithBlock:^(XZTheMasterModel *model) {
            NSLog(@"私信大师===");
            
            __block JCHATConversationController *sendMessageCtl = [[JCHATConversationController alloc] init];
            sendMessageCtl.superViewController = self;
            __weak __typeof(self)weakSelf = self;
            [JMSGConversation createSingleConversationWithUsername:@"asdfg" appKey:JMESSAGE_APPKEY completionHandler:^(id resultObject, NSError *error) {
                
                if (error == nil) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    __strong __typeof(weakSelf) strongSelf = weakSelf;
                    sendMessageCtl.conversation = resultObject;
                    [strongSelf.parentViewController.navigationController pushViewController:sendMessageCtl animated:YES];
                } else {
                    [MBProgressHUD showMessage:[error.userInfo objectForKey:@"NSLocalizedDescription" ] view:self.view];
                }
                
            }];
        }];
        [progressCell cancelWithBlock:^(XZTheMasterModel *model) {
            NSLog(@"取消约见===");
        }];
        [progressCell modifyWithBlock:^(XZTheMasterModel *model) {
            NSLog(@"修改约见===");
        }];
    }
    
    XZMyMasterFinishedCell * finishedCell = [tableView dequeueReusableCellWithIdentifier:finishedCellId];
    if (!finishedCell) {
        finishedCell = [[XZMyMasterFinishedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:progressingCellId];
        [finishedCell evaluateMasterWithBlock:^(XZTheMasterModel *model) {
            NSLog(@"评价大师");
            XZMarkScoreVC * markVC = [[XZMarkScoreVC alloc]initWithMasterCode:model.masterCode];
            [self.parentViewController.navigationController  pushViewController:markVC animated:YES];
        }];
        
    }
    XZTheMasterModel * model = self.finishedMaster.dataArray[indexPath.row];
    
    
    
    if (model.isFinished) {
        finishedCell .model = model;
        return finishedCell;
    }else{
        progressCell.model = model;
        return progressCell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XZTheMasterModel * model = self.finishedMaster.dataArray[indexPath.row];
    if (model.isFinished) {
        return [self.finishedMaster cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZMyMasterFinishedCell class] contentViewWidth:SCREENWIDTH ];
    }else{
        return [self.finishedMaster cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZMyMasterInProgressCell class] contentViewWidth:SCREENWIDTH ];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XZTheMasterModel * model = self.finishedMaster.dataArray[indexPath.row];
    NSString * masterCode = model.masterCode?:@"";
    XZMasterDetailVC * detailVC = [[XZMasterDetailVC alloc]initWithMasterCode:masterCode];
    [self.parentViewController.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark private

/**
 网络请求后 显示数据

 @param array      请求下来的数字
 @param isFinished 进行中/已完成
 */
-(void)showDataAfterNetRequestWithArray:(NSArray*)array  isFinished:(BOOL)isFinished{
    XZRefreshTable * table;
    if (isFinished) {
        table = self.finishedMaster;
    }else{
        table = self.finishingMaster;
    }
    if (table.row==1) {
        [table.dataArray removeAllObjects];
    }
    [table.dataArray addObjectsFromArray:array];
    [table reloadData];
    [table endRefreshHeader];
    [table endRefreshFooter];
    if (array.count<=0) {
        table.mj_footer.hidden = YES;
    }
    __weak typeof(self)weakSelf = self;
    if (table.dataArray.count<=0) {
        [table showNoDataViewWithType:NoDataTypeDefault backgroundBlock:^{
            if (isFinished) {
                 [weakSelf loadFinishedDataWithPageNum:1];
            }else{
                 [weakSelf loadFinishingDataWithPageNum:1];
            }
        } btnBlock:nil];
    }else{
        [table hideNoDataView];
    }
}

#pragma mark getter
-(XZRefreshTable *)finishedMaster{
    if (!_finishedMaster) {
        _finishedMaster = [[XZRefreshTable alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _finishedMaster.backgroundColor = XZFS_HEX_RGB(@"#F0EEEF");
        _finishedMaster.dataSource = self;
        _finishedMaster.delegate = self;
        _finishedMaster.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        UIView * footerView = [UIView new];
        _finishedMaster.backgroundColor = [UIColor clearColor];
        _finishedMaster.tableFooterView = footerView;
    }
    return _finishedMaster;
    
}

-(XZRefreshTable *)finishingMaster{
    if (!_finishingMaster) {
        _finishingMaster = [[XZRefreshTable alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _finishingMaster.backgroundColor = XZFS_HEX_RGB(@"#F0EEEF");
        _finishingMaster.dataSource = self;
        _finishingMaster.delegate = self;
        _finishingMaster.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        UIView * footerView = [UIView new];
        _finishingMaster.backgroundColor = [UIColor clearColor];
        _finishingMaster.tableFooterView = footerView;
    }
    return _finishingMaster;
    
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
