//
//  XZMyMasterFinishedView.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/18.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyMasterFinishedView.h"
#import "XZMyMasterInProgressCell.h"
#import "XZMyMasterFinishedCell.h"
#import "XZMasterDetailVC.h"
#import "XZMyEvaluateVC.h"
#import "XZMarkScoreVC.h"
#import "JCHATConversationController.h"

@interface XZMyMasterFinishedView()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation XZMyMasterFinishedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.finishedMaster.frame = CGRectMake(0, 0, self.width, self.height);
        [self addSubview:self.finishedMaster];
        [self loadData];
    }
    return self;
}
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
    [self.finishedMaster.mj_header endRefreshing];
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
                        [MBProgressHUD hideHUDForView:self animated:YES];
                        __strong __typeof(weakSelf) strongSelf = weakSelf;
                        sendMessageCtl.conversation = resultObject;
                        [strongSelf.weakSelfVC.navigationController pushViewController:sendMessageCtl animated:YES];
                    } else {
                        [MBProgressHUD showMessage:[error.userInfo objectForKey:@"NSLocalizedDescription" ] view:self];
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
                [self.weakSelfVC.navigationController  pushViewController:markVC animated:YES];
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
    [self.weakSelfVC.navigationController pushViewController:detailVC animated:YES];
}

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

@end
