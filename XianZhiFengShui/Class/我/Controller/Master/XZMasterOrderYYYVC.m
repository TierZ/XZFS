//
//  XZMasterOrderYYYVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/12.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterOrderYYYVC.h"
#import "XZRefreshTable.h"
#import "XZYYYCell.h"
#import "JXTAlertController.h"
#import "XZDataPickerView.h"
@interface XZMasterOrderYYYVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)XZRefreshTable * yyyTable;
@end

@implementation XZMasterOrderYYYVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yyyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.yyyTable];
    self.yyyTable.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0,0,0,0));
    [self.yyyTable registerClass:[XZYYYCell class] forCellReuseIdentifier:@"XZYyyCellId"];
     __weak typeof(self)weakSelf = self;
    [self.yyyTable refreshListWithBlock:^(int page, BOOL isRefresh) {
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
        model.appointTime = @"2017-01-20 10:00";
        [self.yyyTable.dataArray addObject:model];
    }
    [self.yyyTable reloadData];
    [self.yyyTable endRefreshHeader];
}

#pragma mark table 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.yyyTable.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XZYYYCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XZYyyCellId" forIndexPath:indexPath];
    cell.model = self.yyyTable.dataArray[indexPath.row];
    
    __weak typeof(self)weakSelf = self;
   
    [cell yyycellBtnClickWithBlock:^(XZMasterOrderModel *model, NSIndexPath *indexPath, YYYCellBtnType type) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        switch (type) {
            case YYYCellBtnSendMsg:{
                NSLog(@"发送消息，跳转到消息界面");
            }
                break;
            case YYYCellBtnModify:{
                NSLog(@"修改时间");
                 int modifyCount  = arc4random()%2;
                if (modifyCount>1) {
                    [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:NO message:@"您已修改过约见时间，不可再次修改"];
                }else{
                    modifyCount+=1;
                    [strongSelf jxt_showAlertWithTitle:@"提示" message:@"每个客户只能修改一次约见时间\n请与客户有效沟通\n以免影响您的收入" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                        alertMaker.addActionDefaultTitle(@"知道了");
                    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                        if (buttonIndex ==0) {
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
                        }
                    }];
                }
            
            }
                break;
            case YYYCellBtnCancel:{
                NSLog(@"取消约见");
                [strongSelf jxt_showAlertWithTitle:@"提示" message:@"是否取消约见" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                    alertMaker.addActionDefaultTitle(@"不取消").addActionDefaultTitle(@"仍然取消");
                } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                    if (buttonIndex ==1) {
                        NSLog(@"刷新界面 取消约见");
                    }
                }];
            }
                break;
            case YYYCellBtnOk:{
                NSLog(@"完成约见");
                [strongSelf jxt_showAlertWithTitle:@"提示" message:@"请确认您已如期约见客户。\n如果虚报，一经查实将永久封号" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                    alertMaker.addActionDefaultTitle(@"取消").addActionDefaultTitle(@"确认");
                } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
                    if (buttonIndex ==1) {
                        NSLog(@"刷新界面 完成约见");
                    }
                }];
            }
                break;
                
            default:
                break;
        }
    }];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.yyyTable.dataArray[indexPath.row];
    return [self.yyyTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZYYYCell class] contentViewWidth:SCREENWIDTH];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"已预约点击--indexPath= %d",(int)indexPath.row);
}

#pragma mark getter
-(XZRefreshTable *)yyyTable{
    if (!_yyyTable) {
        _yyyTable = [[XZRefreshTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _yyyTable.delegate = self;
        _yyyTable.dataSource = self;
        UIView * footV = [UIView new];
        _yyyTable.tableFooterView = footV;
    }
    return _yyyTable;
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
