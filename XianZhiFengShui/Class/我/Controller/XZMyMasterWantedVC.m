//
//  XZMyMasterWantedVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/20.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMyMasterWantedVC.h"
#import "XZRefreshTable.h"
#import "XZTheMasterCell.h"
#import "XZMasterDetailVC.h"
#import "XZUserCenterService.h"
@interface XZMyMasterWantedVC ()<UITableViewDelegate,UITableViewDataSource,DataReturnDelegate>
@property (nonatomic,strong)XZRefreshTable * hopeTable;//
@end

@implementation XZMyMasterWantedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.hopeTable];
    self.hopeTable.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    __weak typeof(self)weakSelf = self;
    [self.hopeTable refreshListWithBlock:^(int page, BOOL isRefresh) {
        [weakSelf loadDataWithPage:page];
    }];
}
-(void)loadDataWithPage:(int)page{
    XZUserCenterService * myWantService = [[XZUserCenterService alloc]initWithServiceTag:XZMyMasterWantedTag];
    myWantService.delegate = self;
    NSString * userCode = [GETUserdefault(@"userInfos")objectForKey:@"bizCode"];
    [myWantService myWantMasterWithUserCode:userCode pageNum:page PageSize:10 cityCode:@"110000" view:self.hopeTable];

}

-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    NSArray * array = (NSArray*)succeedHandle;
    [self showDataAfterNetRequestWithArray:array];
}
-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{
    [self showDataAfterNetRequestWithArray:@[]];
}
#pragma mark private
/**
 网络请求后 显示数据
 
 @param array      请求下来的数字
 */
-(void)showDataAfterNetRequestWithArray:(NSArray*)array{
    if (self.hopeTable.row==1) {
        [self.hopeTable.dataArray removeAllObjects];
    }
    [self.hopeTable.dataArray addObjectsFromArray:array];
    [self.hopeTable reloadData];
    [self.hopeTable endRefreshHeader];
    [self.hopeTable endRefreshFooter];
    if (array.count<=0) {
        self.hopeTable.mj_footer.hidden = YES;
    }
    __weak typeof(self)weakSelf = self;
    if (self.hopeTable.dataArray.count<=0) {
        [self.hopeTable showNoDataViewWithType:NoDataTypeDefault backgroundBlock:^{
            [weakSelf loadDataWithPage:1];
                } btnBlock:nil];
    }else{
        [self.hopeTable hideNoDataView];
    }
}
#pragma mark table 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.hopeTable.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * masterCellId = @"wantMasterCellId";
    XZTheMasterCell * cell = [tableView dequeueReusableCellWithIdentifier:masterCellId];
    if (!cell) {
        cell = [[XZTheMasterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:masterCellId];
    }
    [cell refreshMasterCellWithModel:self.hopeTable.dataArray [indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self tableView:self.hopeTable cellForRowAtIndexPath:indexPath];
    return cell.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XZTheMasterModel * model = self.hopeTable.dataArray [indexPath.row];
    NSString * masterCode = model.masterCode?:@"";
    
    XZMasterDetailVC * detailvc = [[XZMasterDetailVC alloc]initWithMasterCode:masterCode];
    [self.parentViewController.navigationController pushViewController:detailvc animated:YES];
}

-(XZRefreshTable *)hopeTable{
    if (!_hopeTable) {
        _hopeTable = [[XZRefreshTable alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _hopeTable.backgroundColor = XZFS_HEX_RGB(@"#F0EEEF");
        _hopeTable.dataSource = self;
        _hopeTable.delegate = self;
        _hopeTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        UIView * footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        _hopeTable.tableFooterView = footerView;
    }
    return _hopeTable;
    
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
