//
//  XZTheThemeVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/3/14.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZTheThemeVC.h"
#import "XZFindTable.h"
#import "XZFindService.h"
@interface XZTheThemeVC ()<DataReturnDelegate>
@property (nonatomic,strong)XZFindTable * themeView;//话题
@property (nonatomic,strong)NSIndexPath * selectIndex;
@end

@implementation XZTheThemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupThemeView];
    // Do any additional setup after loading the view.
}

-(void)setupThemeView{
    self.themeView = [[XZFindTable alloc]initWithFrame:self.view.bounds style:XZFindTheme];
    self.themeView.currentVC = self;
    [self.view addSubview:self.themeView];
    self.themeView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0,0,0,0));
    
    __weak typeof(self)weakSelf = self;
    [self.themeView.table refreshListWithBlock:^(int page, BOOL isRefresh) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf requestThemeList];
    }];


}


#pragma mark 网络
/**
 请求话题类型列表
 
 */
-(void)requestThemeList{
    XZFindService * themeService = [[XZFindService alloc]initWithServiceTag:XZThemeTypeList];
    themeService.delegate = self;
    [themeService themeTypeListWithCityCode:@"110000" view:self.themeView];
}


-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    NSLog(@"话题啦啦啦successHandle2= %@",succeedHandle);
    NSArray * themes = (NSArray*)succeedHandle;
    [self.themeView.data addObjectsFromArray:themes];
    [self.themeView.table reloadData];
    [self.themeView.table endRefreshFooter];
    [self.themeView.table endRefreshHeader];
    if (themes.count<=0) {
        self.themeView.table.mj_footer.hidden = YES;
    }
    if (self.themeView.data.count<=0) {
         __weak typeof(self)weakSelf = self;
        [self.themeView showNoDataViewWithType:NoDataTypeDefault backgroundBlock:^(){
            __strong typeof(weakSelf)strongSelf = weakSelf;
         [strongSelf requestThemeList];
        } btnBlock:^(NoDataType type) {
           
        }];
    }else{
        [self.themeView hideNoDataView];
    }

}

-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{
    if ([service isKindOfClass:[XZFindService class]]) {
        [self.themeView.table endRefreshFooter];
        [self.themeView.table endRefreshHeader];
        __weak typeof(self)weakSelf = self;
        [self.themeView showNoDataViewWithType:NoDataTypeDefault backgroundBlock:^(){
            __strong typeof(weakSelf)strongSelf = weakSelf;
         [strongSelf requestThemeList];
        } btnBlock:^(NoDataType type) {
        }];
    }
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
