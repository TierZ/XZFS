//
//  XZSearchResultVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/11.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZSearchResultVC.h"
#import "XZHomeService.h"
#import "XZRefreshTable.h"
#import "XZTheMasterCell.h"
#import "XZMasterDetailVC.h"
#import "XZHomePageVC.h"
#import "PYSearchViewController.h"
@interface XZSearchResultVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,copy)  NSString * keyword;
@property (nonatomic,assign) BOOL searchRefresh;
@end

@implementation XZSearchResultVC{

    XZRefreshTable * _searchTable;
}

- (instancetype)initWithKeyWord:(NSString*)keyword
{
    self = [super init];
    if (self) {
        _keyword = keyword;
        _searchRefresh = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNaiv];
    [self setupTable];
}

-(void)setupNaiv{
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(75, 31, SCREENWIDTH-125, 25);
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.cornerRadius = 12.5;
    searchBtn.backgroundColor = [UIColor whiteColor];
    searchBtn.layer.borderWidth = 1;
    searchBtn.layer.borderColor = XZFS_HEX_RGB(@"#D1D0D2").CGColor;
    [searchBtn setTitle:_keyword forState:UIControlStateNormal];
    [searchBtn setTitleColor:XZFS_HEX_RGB(@"#D1D0D2") forState:UIControlStateNormal];
    searchBtn.titleLabel.font = XZFS_S_FONT(12);
    [self.navView addSubview:searchBtn];
    [searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)setupTable{
    _searchTable = [[XZRefreshTable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, XZFS_MainView_H)];
    _searchTable.delegate = self;
    _searchTable.dataSource = self;
    [self.mainView addSubview:_searchTable];
    __weak typeof(self)weakSelf = self;
    [_searchTable refreshListWithBlock:^(int page, BOOL isRefresh) {
        _searchRefresh = isRefresh;
       [weakSelf searchWithKeyWord:weakSelf.keyword];
    }];
}

-(void)searchWithKeyWord:(NSString*)keyWord{
    __weak typeof(self)weakSelf = self;
    NSDictionary * dic = GETUserdefault(@"userInfos");
    NSString * userCodeStr = KISDictionaryHaveKey(dic, @"bizCode");
    XZHomeService * homeMasterService = [[XZHomeService alloc]init];
    [ homeMasterService masterListWithPageNum:1 PageSize:10 cityCode:@"110000" keyWord:keyWord searchType:1 userCode:userCodeStr orderType:3 view:self.mainView successBlock:^(NSArray *data) {
        if (weakSelf.searchRefresh) {
            [_searchTable.dataArray removeAllObjects];
        }
        [_searchTable.dataArray addObjectsFromArray:data];
        if (_searchTable.dataArray.count<=0) {
            [_searchTable showNoDataViewWithType:NoDataTypeDefault backgroundBlock:^{
                [weakSelf searchWithKeyWord:weakSelf.keyword];
            } btnBlock:nil];
        }else{
             [_searchTable hideNoDataView];
        }
        if (weakSelf.searchRefresh) {
            [_searchTable endRefreshHeader];
        }else{
        [_searchTable endRefreshFooter];
        }
        NSLog(@"dataarray = %@",data);
        [_searchTable reloadData];
    } failBlock:^(NSError *error) {
        [_searchTable showNoDataViewWithType:NoDataTypeDefault backgroundBlock:^{
            [weakSelf searchWithKeyWord:weakSelf.keyword];
        } btnBlock:nil];
        NSLog(@"error= %@",error);
        if (weakSelf.searchRefresh) {
            [_searchTable endRefreshHeader];
        }else{
            [_searchTable endRefreshFooter];
        }

    }];
}
#pragma mark table 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _searchTable.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XZTheMasterCell * cell = [tableView dequeueReusableCellWithIdentifier:@"searchMasterId"];
    if (!cell) {
        cell = [[XZTheMasterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchMasterId"];
    }
    [cell refreshMasterCellWithModel:_searchTable.dataArray [indexPath.row]];
    
//    [cell agreeMasterWithBlock:^(XZTheMasterModel *model) {
//        if (weakSelf.block) {
//            weakSelf.block(model.masterCode,indexPath);
//        }
//    }];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self tableView:_searchTable cellForRowAtIndexPath:indexPath];
    return cell.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XZTheMasterModel * model =  _searchTable.dataArray [indexPath.row];
    XZMasterDetailVC * detailVC = [[XZMasterDetailVC alloc]initWithMasterCode:model.masterCode];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

#pragma mark action
-(void)clickLeftButton{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)search:(UIButton*)sender{
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"商务风水", @"家居风水", @"流年运势", @"手相面相", @"婚恋情感", @"良辰吉日", @"周公解梦", @"阴宅风水"];
    // 2. 创建控制器
   PYSearchViewController * _searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索大师、话题" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        
        XZSearchResultVC * resultVC = [[XZSearchResultVC alloc]initWithKeyWord:searchText];
        [searchViewController dismissViewControllerAnimated:NO completion:^{
            [self.navigationController pushViewController:resultVC animated:YES];
        }];
        
    }];
    // 3. 设置风格
    _searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
    _searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_searchViewController];
    [self presentViewController:nav  animated:YES completion:nil];
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
