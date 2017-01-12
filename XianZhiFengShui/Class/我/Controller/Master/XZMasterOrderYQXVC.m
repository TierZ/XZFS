//
//  XZMasterOrderYYYVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/12.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterOrderYQXVC.h"
#import "XZRefreshTable.h"
#import "XZYQXCell.h"
@interface XZMasterOrderYQXVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)XZRefreshTable * yqxTable;
@end

@implementation XZMasterOrderYQXVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yqxTable.frame = CGRectMake(0, 0, SCREENWIDTH, self.view.height);
    self.yqxTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.yqxTable];
    [self.yqxTable registerClass:[XZYQXCell class] forCellReuseIdentifier:@"XZYqxCellId"];
    [self setupData];
}

-(void)setupData{
    for (int i = 0; i<10; i++) {
        XZMasterOrderModel * model = [[XZMasterOrderModel alloc]init];
        model.service = @"商务风水";
        model.location = @"北京西城";
        model.time = @"2017-01-12 16:01";
        model.price = @"6889";
        model.cancelTime = @"2017-01-20 10:00";
        model.cancelPerson = @"我";
        model.cancelReason = @"预约时间无法达成一致";
        [self.yqxTable.dataArray addObject:model];
    }
    [self.yqxTable reloadData];
    [self.yqxTable endRefreshHeader];
}

#pragma mark table 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.yqxTable.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XZYQXCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XZYqxCellId" forIndexPath:indexPath];
    cell.model = self.yqxTable.dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.yqxTable.dataArray[indexPath.row];
    return [self.yqxTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZYQXCell class] contentViewWidth:SCREENWIDTH];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"已取消点击--indexPath= %d",(int)indexPath.row);
}

#pragma mark getter
-(XZRefreshTable *)yqxTable{
    if (!_yqxTable) {
        _yqxTable = [[XZRefreshTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _yqxTable.delegate = self;
        _yqxTable.dataSource = self;
        UIView * footV = [UIView new];
        _yqxTable.tableFooterView = footV;
    }
    return _yqxTable;
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
