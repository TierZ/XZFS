//
//  XZOrderVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/9.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZOrderVC.h"
#import "XZRefreshTable.h"
#import "XZOrderCell.h"
#import "XZOrderHeaderView.h"
#import "XZOrderFooterView.h"
#import "XZGoodsDetailVC.h"
@interface XZOrderVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)XZRefreshTable * orderTable;
@end

@implementation XZOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
    [self setupData];
    // Do any additional setup after loading the view.
}

-(void)setupTable{
    self.orderTable = [[XZRefreshTable alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.orderTable.delegate = self;
    self.orderTable.dataSource = self;
    [self.view addSubview:self.orderTable];
      self.orderTable.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0,0,0,0));
}

-(void)setupData{
    for (int i = 0; i<4; i++) {
        NSMutableArray * arr = [NSMutableArray array];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        [dic setObject:@"荔枝园" forKey:@"storeName"];
        [dic setObject:[NSNumber numberWithInt:i+1] forKey:@"state"];
        for (int j = 0; j<5; j++) {
            XZGoodsModel * model = [[XZGoodsModel alloc]init];
            model.image = @"http://file.shagualicai.cn/201610/09/pic/pic_14759978965900.jpg";
            model.name = @"宏泰翔  8寸风水罗盘";
            model.price = @"3800";
            model.counts = @"2";
            [arr addObject:model];
        }
        [dic setObject:arr forKey:@"data"];
        [self.orderTable.dataArray addObject:dic];
    }
    [self.orderTable reloadData];
}


#pragma mark table 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.orderTable.dataArray.count>0?self.orderTable.dataArray.count:1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.orderTable.dataArray[section]objectForKey:@"data"] count]>0?[[self.orderTable.dataArray[section]objectForKey:@"data"] count]:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * orderCellId = @"orderCellId";
    XZOrderCell * orderCell = [tableView dequeueReusableCellWithIdentifier:orderCellId];
    if (!orderCell) {
        orderCell = [[XZOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:orderCellId];
    }
    NSDictionary * dic = self.orderTable.dataArray[indexPath.section];
    orderCell.model = [dic objectForKey:@"data"] [indexPath.row];
    return orderCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString * orderHeaderId = @"orderHeaderId";
    XZOrderHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:orderHeaderId];
    if (!headerView) {
        headerView = [[XZOrderHeaderView alloc]initWithReuseIdentifier:orderHeaderId];
    }
    NSDictionary * dic = self.orderTable.dataArray[section];
    XZGoodsModel * model = [XZGoodsModel modelWithDictionary:dic];
    headerView.model = model;
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    static NSString * orderFooterId = @"orderFooterId";
    XZOrderFooterView * footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:orderFooterId];
    if (!footerView) {
        footerView = [[XZOrderFooterView alloc]initWithReuseIdentifier:orderFooterId];
    }
    NSDictionary * dic = self.orderTable.dataArray[section];
    XZGoodsModel * model = [XZGoodsModel modelWithDictionary:dic];
    footerView.model = model;
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 88;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XZGoodsDetailVC * detailvc = [[XZGoodsDetailVC alloc]initWithGoodsId:@"12313"];
    [self.parentViewController.navigationController pushViewController:detailvc animated:YES];

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
