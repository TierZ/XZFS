//
//  XZMyAccountBillVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/17.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyAccountBillVC.h"
#import "XZRefreshTable.h"
#import "XZMyAccountBillCell.h"
#import "XZMyAccountBillDetailVC.h"
@interface XZMyAccountBillVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)XZRefreshTable * billTable;
@property (nonatomic,strong)NSMutableArray * bills;
@end

@implementation XZMyAccountBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"我的账单";
      [self showData];
    self.billTable.frame = CGRectMake(0, 0, SCREENWIDTH, XZFS_MainView_H);
    [self.mainView addSubview:self.billTable];
    
  
    [self.billTable reloadData];
    // Do any additional setup after loading the view.
}

#pragma mark 假数据

-(void)showData{
    for (int i = 0; i<3; i++) {
        NSMutableArray * arrar = [NSMutableArray array];
        for (int j = 0; j<3; j++) {
            XZMyAccountBillModel * model = [[XZMyAccountBillModel alloc]init];
            model.title = @"充值";
            model.subTitle = @"2016-11-17 10:25:30";
            model.price = @"1000.00";
            if (j==arc4random()%3) {
                model.title = @"先知吉祥商城[精品开光挂件]";
                model.price = @"-100.00";
            }
            [arrar addObject:model];
//            [self.bills addObject:model];
        }
        [self.bills addObject:arrar];
    }
    NSLog(@"array = %@",self.bills);
  
}

#pragma mark table 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.bills.count>0) {
        return self.bills.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.bills.count>0) {
        return [self.bills[section]count];
    }return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * billCellId = @"billCellId";
    XZMyAccountBillCell * cell = [tableView dequeueReusableCellWithIdentifier:billCellId];
    if (!cell) {
        cell = [[XZMyAccountBillCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:billCellId];
    }
    
    cell.model = self.bills[indexPath.section][indexPath.row];
//    cell.model = self.bills[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XZMyAccountBillModel * model = self.bills[indexPath.section][indexPath.row];
    [self.navigationController pushViewController:[[XZMyAccountBillDetailVC alloc]init] animated:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headV = [UIView new];
    headV.backgroundColor = XZFS_HEX_RGB(@"#F0EEEF");
    headV.frame = CGRectMake(0, 0, SCREENWIDTH, 40);
    
    UILabel * timeLab = [UILabel new];
    timeLab.frame = CGRectMake(22, 23, 100, 10);
    timeLab.textColor = XZFS_TEXTBLACKCOLOR;
    timeLab.font = XZFS_S_FONT(10);
    timeLab.text = @"2016-11";
    [headV addSubview:timeLab];
    return headV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

#pragma mark getter
-(XZRefreshTable *)billTable{
    if (!_billTable) {
        _billTable = [[XZRefreshTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _billTable.dataSource = self;
        _billTable.delegate = self;
        
        UIView * footV = [UIView new];
        _billTable.tableFooterView = footV;
        
    }
    return _billTable;
}

-(NSMutableArray *)bills{
    if (!_bills) {
        _bills = [NSMutableArray array];
    }
    return _bills;
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
