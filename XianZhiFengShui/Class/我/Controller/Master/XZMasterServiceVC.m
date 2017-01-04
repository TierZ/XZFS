//
//  XZMasterServiceVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/4.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterServiceVC.h"
#import "XZMasterServiceCell.h"
#import "XZRefreshTable.h"
#import "XZMasterAddServiceVC.h"
#define BottomHeight 45
@interface XZMasterServiceVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)XZRefreshTable * serviceTable;
@end

@implementation XZMasterServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"我的服务项目";
    [self setupTable];
    [self setupBottom];
    [self setupdata];
}

-(void)setupdata{
    for (int i = 0; i<10; i++) {
        XZMasterModel * model = [[XZMasterModel alloc]init];
        model.icon = @"http://www.baidu.com/img/bd_logo1.png";
        model.name = @"商务风水";
        model.level = @"3";
        model.state = @"已通过审核";
        model.price = 888;
        model.appointCount = 1;
        model.summary = @"脏阿里手电筒安师大你给你，爱是，都抢我野一去他那卡萨诺的刘嘉玲及噶案例四大满贯爱是图卢卡斯的";
        if (i%3==0) {
            model.state = @"未通过审核";
            model.price = 10;
            model.appointCount = 1000;
            model.summary = @"脏阿里手电筒安师大你";
        }
        [self.serviceTable.dataArray addObject:model];
    }
    [self.serviceTable reloadData];
}

-(void)setupTable{
    self.serviceTable.frame = CGRectMake(0, 0, SCREENWIDTH, XZFS_MainView_H-BottomHeight);
    [self.mainView addSubview:self.serviceTable];
    
    [self.serviceTable registerClass:[XZMasterServiceCell class] forCellReuseIdentifier:@"serviceIdentifier"];
    [self.serviceTable refreshListWithBlock:^(int page, BOOL isRefresh) {
        if (isRefresh) {
            NSLog(@"下拉刷新 ==page = %d",page);
        }else{
            NSLog(@"上啦加载 ==page = %d",page);
        }
    }];
}

-(void)setupBottom{
    UIButton * addServiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addServiceBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
    [addServiceBtn setTitle:@"添加服务项目" forState:UIControlStateNormal];
    [addServiceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addServiceBtn.titleLabel.font = XZFS_S_FONT(18);
    [addServiceBtn addTarget:self action:@selector(addService) forControlEvents:UIControlEventTouchUpInside];
    addServiceBtn.frame = CGRectMake(0, XZFS_MainView_H-BottomHeight, SCREENWIDTH, BottomHeight);
    [self.mainView addSubview:addServiceBtn];
}

#pragma mark action
-(void)addService{
    NSLog(@"添加服务");
    [self.navigationController pushViewController:[[XZMasterAddServiceVC alloc]init] animated:YES];
}

#pragma mark table 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.serviceTable.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XZMasterServiceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"serviceIdentifier" forIndexPath:indexPath];
    cell.model = self.serviceTable.dataArray[indexPath.row];
    cell.indexPath = indexPath;
    [cell modifyServiceWithBlock:^(XZMasterModel *model, NSIndexPath *indexPath) {
        NSLog(@"进行修改服务的操作");
    }];
    [cell deleteServiceWithBlock:^(XZMasterModel *model, NSIndexPath *indexPath) {
        NSLog(@"进行删除服务的操作");
    }];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.serviceTable.dataArray[indexPath.row];
    return [self.serviceTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZMasterServiceCell class] contentViewWidth:SCREENWIDTH];
}


-(XZRefreshTable *)serviceTable{
    if (!_serviceTable) {
        _serviceTable = [[XZRefreshTable alloc] init];
        _serviceTable.dataSource = self;
        _serviceTable.delegate = self;
        _serviceTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView * footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        _serviceTable.tableFooterView = footerView;
    }
    return _serviceTable;

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
