//
//  XZShoppingCartVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/9.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZShoppingCartVC.h"
#import "XZRefreshTable.h"
#import "XZShoppingCartCell.h"
#import "XZShoppingCartHeaderView.h"
#import "XZGoodsDetailVC.h"
@interface XZShoppingCartVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)XZRefreshTable * cartTable;
@end

@implementation XZShoppingCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
    [self setupData];
    // Do any additional setup after loading the view.
}

-(void)setupTable{
    self.cartTable = [[XZRefreshTable alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.cartTable.delegate = self;
    self.cartTable.dataSource = self;
    [self.view addSubview:self.cartTable];
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
            model.selectCount = @"2";
            [arr addObject:model];
        }
        [dic setObject:arr forKey:@"data"];
        [self.cartTable.dataArray addObject:dic];
    }
    [self.cartTable reloadData];
}


#pragma mark table 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cartTable.dataArray.count>0?self.cartTable.dataArray.count:1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.cartTable.dataArray[section]count]>0?[self.cartTable.dataArray[section]count]:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cartCellId = @"cartCellId";
    XZShoppingCartCell * cartCell = [tableView dequeueReusableCellWithIdentifier:cartCellId];
    if (!cartCell) {
        cartCell = [[XZShoppingCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cartCellId];
    }
    NSDictionary * dic = self.cartTable.dataArray[indexPath.section];
    cartCell.model = [dic objectForKey:@"data"] [indexPath.row];
    return cartCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString * shopCartHeaderId = @"shopCartHeaderId";
    XZShoppingCartHeaderView * cartHead = [tableView dequeueReusableHeaderFooterViewWithIdentifier:shopCartHeaderId];
    if (!cartHead) {
        cartHead = [[XZShoppingCartHeaderView alloc]initWithReuseIdentifier:shopCartHeaderId];
    }
    NSDictionary * dic = self.cartTable.dataArray[section];
    XZGoodsModel * model = [XZGoodsModel modelWithDictionary:dic];
    cartHead.model = model;

    return cartHead;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 36;
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
