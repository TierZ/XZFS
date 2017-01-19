//
//  XZMasterOrderYYYVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/12.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterOrderYYJVC.h"
#import "XZRefreshTable.h"
#import "XZYYJCell.h"
@interface XZMasterOrderYYJVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)XZRefreshTable * yyjTable;
@end

@implementation XZMasterOrderYYJVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yyjTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.yyjTable];
    self.yyjTable.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0,0,0,0));

    [self.yyjTable registerClass:[XZYYJCell class] forCellReuseIdentifier:@"XZYyjCellId"];
     __weak typeof(self)weakSelf = self;
    [self.yyjTable refreshListWithBlock:^(int page, BOOL isRefresh) {
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
        [self.yyjTable.dataArray addObject:model];
    }
    [self.yyjTable reloadData];
    [self.yyjTable endRefreshHeader];
}

#pragma mark table 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.yyjTable.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XZYYJCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XZYyjCellId" forIndexPath:indexPath];
    cell.model = self.yyjTable.dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.yyjTable.dataArray[indexPath.row];
    return [self.yyjTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZYYJCell class] contentViewWidth:SCREENWIDTH];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"已约见点击--indexPath= %d",(int)indexPath.row);
}

#pragma mark getter
-(XZRefreshTable *)yyjTable{
    if (!_yyjTable) {
        _yyjTable = [[XZRefreshTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _yyjTable.delegate = self;
        _yyjTable.dataSource = self;
        UIView * footV = [UIView new];
        _yyjTable.tableFooterView = footV;
    }
    return _yyjTable;
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
