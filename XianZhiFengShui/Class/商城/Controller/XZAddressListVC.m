//
//  XZAddressListVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/12.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZAddressListVC.h"
#import "XZRefreshTable.h"
#import "XZAddressCell.h"
#import "XZAddAddressVC.h"
@interface XZAddressListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)XZRefreshTable * addressList;
@end

@implementation XZAddressListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"收货地址";
    
    [self setupTable];
    [self setupBottom];
    [self setupData];

    // Do any additional setup after loading the view.
}

-(void)setupTable{
    self.addressList = [[XZRefreshTable alloc]initWithFrame:CGRectMake(0, 4, SCREENWIDTH, XZFS_MainView_H-45) style:UITableViewStylePlain];
    self.addressList.delegate = self;
    self.addressList.dataSource = self;
    self.addressList.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView * footV = [UIView new];
    self.addressList.tableFooterView = footV;
    [self.mainView addSubview:self.addressList];

    
}
-(void)setupBottom{
    UIButton * addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addAddressBtn.frame = CGRectMake(0, XZFS_MainView_H-45, SCREENWIDTH, 45);
    [addAddressBtn setTitle:@"添加收货地址" forState:UIControlStateNormal];
    [addAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addAddressBtn .titleLabel.font = XZFS_S_FONT(18);
    addAddressBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
    [addAddressBtn addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:addAddressBtn];
    
}

-(void)setupData{
    for (int i = 0; i<10; i++) {
        XZAddressModel * model = [[XZAddressModel alloc]init];
        model.consignee  =@"张三丰";
        model.phone = @"13812321993";
        model.address = @"武当山具体在襄阳市和十堰市铁路和高速公路的中间地带，即丹江口市境内的中央 武当派紫霄宫302室";
        if (i%3==0) {
            model.consignee  =@"张无忌";
            model.phone = @"11033296472";
            model.address = @"光明顶 明教";
        }
        [self.addressList.dataArray addObject:model];
    }
    [self.addressList reloadData];

}
#pragma mark action
-(void)addAddress:(UIButton*)sender{
    NSLog(@"添加收货地址");
    [self.navigationController pushViewController:[[XZAddAddressVC alloc]init] animated:YES];
}

#pragma mark table 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressList.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * addressListId = @"addressListId";
    XZAddressCell * cell = [tableView dequeueReusableCellWithIdentifier:addressListId];
    if (!cell) {
        cell = [[XZAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addressListId];
    }
//    [cell hideEditBar:YES];
    XZAddressModel * model = self.addressList.dataArray[indexPath.row];
    model.isHideEditBar = NO;
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     XZAddressModel *  model = self.addressList.dataArray[indexPath.row];
    model.isHideEditBar = NO;
     return [self.addressList cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZAddressCell class] contentViewWidth:SCREENWIDTH];
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
