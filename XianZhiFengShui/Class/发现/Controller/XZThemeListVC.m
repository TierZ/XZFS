//
//  XZThemeListVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/21.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZThemeListVC.h"
#import "XZThemeListCell.h"
#import "XZPostTopicVC.h"
#import "XZThemeDetailVC.h"
#import "XZFindService.h"
#import "XZRefreshTable.h"

NSString * const ThemeListTableViewCellId = @"ThemeListId";

@interface XZThemeListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)XZRefreshTable * themeListTable;
@property (nonatomic,strong)NSMutableArray * themes;
@property (nonatomic,assign)BOOL isRefresh;
@property (nonatomic,strong)NSString* typeCode;
@end

@implementation XZThemeListVC
- (instancetype)initWithTypeCode:(NSString*)typeCode
{
    self = [super init];
    if (self) {
        _typeCode = typeCode;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    [self setupTable];
//

}

-(void)setupNavi{
    [self.rightTitleBtn setTitle:@"发帖" forState:UIControlStateNormal];
    [self.rightTitleBtn setTitleColor:XZFS_TEXTBLACKCOLOR forState:UIControlStateNormal];
    self.rightTitleBtn.hidden = NO;
    self.rightButton.hidden = YES;
//    self.rightButton .backgroundColor = [UIColor redColor];
}

-(void)setupTable{
    [self.view addSubview:self.themeListTable];
    
    self.themeListTable.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(XZFS_STATUS_BAR_H,0,0,0));
    
    
    [self.themeListTable registerClass:[XZThemeListCell class] forCellReuseIdentifier:ThemeListTableViewCellId];
    __weak typeof(self)weakSelf = self;
    [self.themeListTable refreshListWithBlock:^(int page, BOOL isRefresh) {
        weakSelf.isRefresh = isRefresh;
        NSLog(@"page = %d",page);
        [weakSelf requestThemeListWithPage:page];
    }];
}

#pragma mark 网络
-(void)requestThemeListWithPage:(int)page{
    XZFindService * themeListService = [[XZFindService alloc]initWithServiceTag:XZThemeList];
    themeListService.delegate = self;
    [themeListService themeListWithPageNum:page PageSize:10 cityCode:@"110000" view:self.mainView];
}

-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    NSLog(@"successhandle = %@",succeedHandle);
    NSArray * array = (NSArray*)succeedHandle;
    if (self.isRefresh) {
        [self.themes removeAllObjects];
    }
    [self.themes addObjectsFromArray:array];
    [self.themeListTable reloadData];
    [self.themeListTable endRefreshFooter];
    [self.themeListTable endRefreshHeader];
    if (array.count<=0) {
        self.themeListTable.mj_footer.hidden = YES;
    }
    if (self.themes.count<=0) {
        __weak typeof(self)weakSelf = self;
        [self.themeListTable showNoDataViewWithType:NoDataTypeDefault backgroundBlock:^{
            [weakSelf requestThemeListWithPage:1];
        } btnBlock:nil];
    }else{
        [self.themeListTable hideNoDataView];
    }
}

-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{
    [self.themeListTable endRefreshFooter];
    [self.themeListTable endRefreshHeader];
    __weak typeof(self)weakSelf = self;
    [self.themeListTable showNoDataViewWithType:NoDataTypeDefault backgroundBlock:^{
        [weakSelf requestThemeListWithPage:1];
    } btnBlock:nil];
}

#pragma mark action
-(void)clickRightButton{
    NSLog(@"发帖");
    [self.navigationController pushViewController:[[XZPostTopicVC alloc]init] animated:YES];
    
}


#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.themes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XZThemeListCell *cell = [tableView dequeueReusableCellWithIdentifier:ThemeListTableViewCellId];
    [cell hideEditBtn:YES];
    cell.indexPath = indexPath;
    cell.model = self.themes[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.themes[indexPath.row];
    return [self.themeListTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZThemeListCell class] contentViewWidth:SCREENWIDTH];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     XZThemeListModel * model = self.themes[indexPath.row];
    
    [self.navigationController pushViewController:[[XZThemeDetailVC alloc]initWithTopicCode:model.topicCode] animated:YES];

}


#pragma mark getter
-(XZRefreshTable *)themeListTable{
    if (!_themeListTable) {
        _themeListTable = [[XZRefreshTable alloc] init];
        _themeListTable.backgroundColor = XZFS_HEX_RGB(@"#F0EDEE");
        _themeListTable.dataSource = self;
        _themeListTable.delegate = self;
        _themeListTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView * footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        _themeListTable.tableFooterView = footerView;
    }
    return _themeListTable;
}

-(NSMutableArray *)themes{
    if (!_themes) {
        _themes = [NSMutableArray array];
    }
    return _themes;
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
