//
//  XZMasterOrderDYYVCViewController.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/12.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterOrderDYYVCViewController.h"
#import "XZRefreshTable.h"
#import "XZDYYCell.h"
#import "JXTAlertController.h"
#import "XZDataPickerView.h"
@interface XZMasterOrderDYYVCViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)XZRefreshTable * dyyTable;
@end

@implementation XZMasterOrderDYYVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.dyyTable.frame = CGRectMake(0, 0, SCREENWIDTH, self.view.height);
    self.dyyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.dyyTable];
    self.dyyTable.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0,0,0,0));
    [self.dyyTable registerClass:[XZDYYCell class] forCellReuseIdentifier:@"XZDyyCellId"];
    __weak typeof(self)weakSelf = self;
    [self.dyyTable refreshListWithBlock:^(int page, BOOL isRefresh) {
        [weakSelf setupData];
    }];
}

-(void)setupData{
    for (int i = 0; i<10; i++) {
        XZMasterOrderModel * model = [[XZMasterOrderModel alloc]init];
        model.service = @"商务风水";
        model.location = @"北京西城";
        model.time = @"2017-01-12 16:01";
        model.price = @"6889";
        [self.dyyTable.dataArray addObject:model];
    }
    [self.dyyTable reloadData];
    [self.dyyTable endRefreshHeader];
}

#pragma mark table 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dyyTable.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XZDYYCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XZDyyCellId" forIndexPath:indexPath];
    cell.model = self.dyyTable.dataArray[indexPath.row];
    __weak typeof(self)weakSelf = self;
    [cell appointNowWithBlock:^(XZMasterOrderModel *model, NSIndexPath *index) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf jxt_showAlertWithTitle:@"提示" message:@"请在沟通中与用户确定具体约见时间，并在结束会话后点击[提交约见时间]按钮录入系统，否则平台不承认订单有效，影响您的收益" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"知道了");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            if (buttonIndex == 0) {
                NSLog(@"跳转到 私信界面。。。");
            }
        }];

    }];
    [cell submitAppointTimeWithBlock:^(XZMasterOrderModel *model, NSIndexPath *index) {
          __strong typeof(weakSelf)strongSelf = weakSelf;
        XZDataPickerView * datePicker = [[XZDataPickerView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT)];
        [strongSelf.parentViewController.view addSubview:datePicker];
        NSLog(@"显示时间选择器，提交时间..待办");
        [datePicker selectDateWithBlock:^(NSDate * startDate,NSDate * endDate) {
            NSLog(@"时间间隔== %@--%@",startDate,endDate);
        [strongSelf jxt_showAlertWithTitle:@"提示" message:  [NSString stringWithFormat:@"您提交的约见时间为 %@ 至%@",startDate,endDate] appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                alertMaker.
                addActionCancelTitle(@"确认"). addActionDefaultTitle(@"取消");
            } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                if (buttonIndex == 0) {
                    datePicker.hidden = YES;
                    [datePicker removeFromSuperview];
                    NSLog(@"刷新界面");
                }
            }];
        }];
    }];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.dyyTable.dataArray[indexPath.row];
    return [self.dyyTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZDYYCell class] contentViewWidth:SCREENWIDTH];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"待预约点击--indexPath= %d",(int)indexPath.row);
}

#pragma mark getter
-(XZRefreshTable *)dyyTable{
    if (!_dyyTable) {
        _dyyTable = [[XZRefreshTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _dyyTable.delegate = self;
        _dyyTable.dataSource = self;
        UIView * footV = [UIView new];
        _dyyTable.tableFooterView = footV;
    }
    return _dyyTable;
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
