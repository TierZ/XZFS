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
@interface XZMasterOrderYYYVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)XZRefreshTable * yyyTable;
@end

@implementation XZMasterOrderYYYVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yyyTable.frame = CGRectMake(0, 0, SCREENWIDTH, self.view.height);
    self.yyyTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.yyyTable];
    [self.yyyTable registerClass:[XZYYYCell class] forCellReuseIdentifier:@"XZYyyCellId"];
    [self setupData];
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
