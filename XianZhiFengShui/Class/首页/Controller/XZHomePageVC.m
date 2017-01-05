//
//  XZHomePageVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/8.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZHomePageVC.h"
#import "XZLoginVC.h"
#import "XZHomeView.h"
#import "PYSearchViewController.h"
#import "XZMessagesVC.h"
#import "XZHomeService.h"
#import "XZFindService.h"
@interface XZHomePageVC ()<UIWebViewDelegate,PYSearchViewControllerDelegate>
@property (nonatomic,strong)XZHomeView * home ;
@property (nonatomic,strong)NSString  * cityCode ;
@property (nonatomic,strong)NSMutableArray  * masters ;
@property (nonatomic,strong)NSMutableArray  * lectures ;
@property (nonatomic,strong)NSArray  * headArray; ;
@end

@implementation XZHomePageVC{

}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.tabBarItem.badgeValue = @"1000";
     self.view.backgroundColor = [UIColor whiteColor];
    _cityCode = @"110000";
    [self setupNavi];
    [self setUpHomeView];
}

-(void)setupNavi{
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(75, 31, SCREENWIDTH-125, 25);
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.cornerRadius = 12.5;
    searchBtn.backgroundColor = [UIColor whiteColor];
    searchBtn.layer.borderWidth = 1;
    searchBtn.layer.borderColor = XZFS_HEX_RGB(@"#D1D0D2").CGColor;
    [searchBtn setTitle:@"搜索大师、话题" forState:UIControlStateNormal];
    [searchBtn setTitleColor:XZFS_HEX_RGB(@"#D1D0D2") forState:UIControlStateNormal];
    searchBtn.titleLabel.font = XZFS_S_FONT(12);
    [self.navView addSubview:searchBtn];
    [searchBtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightButton.backgroundColor = [UIColor redColor];
    
}

-(void)setUpHomeView{
    [self.view addSubview:self.home];
    __weak typeof(self)weakSelf =self;
    [self.home.xzHomeTable refreshListWithBlock:^(int page, BOOL isRefresh) {
        [weakSelf initData];
    }];
}

#pragma mark 网络
// 数据请求
-(void)initData
{
        // 创建信号量
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    // 创建全局并行
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        XZHomeService * homeService = [[XZHomeService alloc]init];
        [homeService requestHomeDataWithCityCode:_cityCode View:self.mainView successBlock:^(NSDictionary *data) {
            NSDictionary * dic = [data objectForKey:@"data"];
            NSArray * carouselList = [dic objectForKey:@"carouselList"];
            NSArray * cityList = [dic objectForKey:@"cityList"];
            NSArray * naviMenuList = [dic objectForKey:@"naviMenuList"];
            self.headArray = @[carouselList,@{@"tags":naviMenuList}];
            dispatch_semaphore_signal(semaphore);
        } failBlock:^(NSError *error) {
             self.headArray = @[@[],@{@"tags":@[]}];
           dispatch_semaphore_signal(semaphore);
        }];

    });
    dispatch_group_async(group, queue, ^{
        XZHomeService * homeMasterService = [[XZHomeService alloc]init];
        [homeMasterService masterListWithPageNum:1 PageSize:10 cityCode:_cityCode view:self.mainView successBlock:^(NSArray *data) {
              self.masters = [NSMutableArray arrayWithArray:data];
             dispatch_semaphore_signal(semaphore);
        } failBlock:^(NSError *error) {
            self.masters = [NSMutableArray arrayWithArray:@[]];
             dispatch_semaphore_signal(semaphore);
        }];
       
    });
    dispatch_group_async(group, queue, ^{
       XZHomeService * homeLectureService = [[XZHomeService alloc]init];
        [homeLectureService lectureListWithPageNum:1 PageSize:10 cityCode:_cityCode view:self.mainView successBlock:^(NSArray *data) {
            self.lectures = [NSMutableArray arrayWithArray:data];
            dispatch_semaphore_signal(semaphore);
        } failBlock:^(NSError *error) {
            self.lectures = [NSMutableArray arrayWithArray:@[]];
            dispatch_semaphore_signal(semaphore);
        }];
    });
    
    dispatch_group_notify(group, queue, ^{
        // 三个请求对应三次信号等待
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [self.home.xzHomeData addObjectsFromArray:self.headArray];
        [self.home.xzHomeData addObjectsFromArray:@[self.masters,self.lectures]];
        [self.home.xzHomeTable reloadData];
        [self.home refreshHeadView];
        [self.home.xzHomeTable.mj_header endRefreshing];
    });
    
}
#pragma mark action
-(void)search:(UIButton*)sender{
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"商务风水", @"家居风水", @"流年运势", @"手相面相", @"婚恋情感", @"良辰吉日", @"周公解梦", @"阴宅风水"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索大师、话题" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        
    }];
    // 3. 设置风格
        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
    searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:YES completion:nil];
}

-(void)clickRightButton{
    [self.navigationController pushViewController:[[XZMessagesVC alloc]init] animated:YES];
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}

#pragma mark  getter
-(XZHomeView *)home{
    if (!_home) {
        _home = [[XZHomeView alloc]initWithFrame:CGRectMake(0, XZFS_STATUS_BAR_H, SCREENWIDTH, SCREENHEIGHT-XZFS_STATUS_BAR_H-XZFS_Bottom_H)];
        _home.backgroundColor = [UIColor whiteColor];
    }
    return _home;
}
-(NSMutableArray *)masters{
    if (!_masters) {
        _masters = [NSMutableArray arrayWithCapacity:1];
    }
    return _masters;
}
-(NSMutableArray *)lectures{
    if (!_lectures) {
        _lectures = [NSMutableArray arrayWithCapacity:1];
    }
    return _lectures;
}
//-(NSArray *)headArray{
//    if (!_headArray) {
//        _headArray = [NSMutableArray arrayWithCapacity:1];
//    }
//    return _headArray;
//}
//-(void)click{
//   
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[XZLoginVC alloc]init]];
//    nav.navigationBar.hidden = YES;
//    [self.navigationController presentViewController:nav animated:YES completion:nil];
//}
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
