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
@interface XZHomePageVC ()<UIWebViewDelegate,PYSearchViewControllerDelegate>
@property (nonatomic,strong)XZHomeView * home ;
@property (nonatomic,strong)NSString  * cityCode ;
@end

@implementation XZHomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.tabBarItem.badgeValue = @"1000";
     self.view.backgroundColor = [UIColor whiteColor];
    _cityCode = @"110000";
    [self setupNavi];
    [self setUpHomeView];
//    [self setUpData];
    [self requestHomeData];
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
}

-(void)setUpData{
      NSMutableArray * masters = [NSMutableArray array];
    for (int i = 0; i<3; i++) {
        XZTheMasterModel * model = [[XZTheMasterModel alloc]init];
        model.icon = @"http://navatar.shagualicai.cn/uid/150922010117012662";
        model.name = @"张三丰";
        model.level = @"V1";
        model.singleVolume = @"82单";
        model.pointOfPraise = @"99";
        model.type  =@[@"上知天文",@"下晓地理",@"古往今来",@"无所不知"];
        model.summary  =@"我是张三丰，zhang。。。。。爱撒大声地阿萨德阿达";
        [masters addObject:model];
    }

    
    NSMutableArray * lectures = [NSMutableArray array];
    for (int i = 0; i<3; i++) {
        XZTheMasterModel * lecture = [[XZTheMasterModel alloc]init];
        lecture.icon = @"http://file.shagualicai.cn/201610/09/pic/pic_14759978965900.jpg";
        lecture.name = @"张三丰  中国道教协会会长，武当创始人，太极";
        lecture.title = @"聊聊买房买车开公司那些事";
        lecture.isCollected = NO;
        lecture.price = @"￥99";
        lecture.time = @"9月18日  9:00";
        lecture.remian = @"余10席";
        
        [lectures addObject:lecture];
    }

    [self.home.xzHomeData addObjectsFromArray:@[masters,lectures]];
    NSLog(@"arrya = %@",self.home.xzHomeData);

    
}
#pragma mark 网络
-(void)requestHomeData{
    XZHomeService * homeService = [[XZHomeService alloc]init];
    homeService.serviceTag = XZGetDataList;
    homeService.delegate = self;
    [homeService requestHomeDataWithCityCode:_cityCode View:self.mainView];
}
-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    XZHomeService * homeService = (XZHomeService*)service;
    switch (homeService.serviceTag) {
        case XZGetDataList:{
            NSDictionary * dic = (NSDictionary*)succeedHandle;
            NSArray * carouselList = [dic objectForKey:@"carouselList"];
            NSArray * cityList = [dic objectForKey:@"cityList"];
            NSArray * naviMenuList = [dic objectForKey:@"naviMenuList"];
            
            [self.home.xzHomeData addObjectsFromArray:@[carouselList,@{@"tags":naviMenuList}]];
            [self setUpData];
          
            [self.home.xzHomeTable reloadData];
            [self.home refreshHeadView];

        }
            break;
            
        default:
            break;
    }
    NSLog(@"successHandle = %@",succeedHandle);

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
