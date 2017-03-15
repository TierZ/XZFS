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
@interface XZTheThemeVC ()
@property (nonatomic,strong)XZFindTable * themeView;//话题

@end

@implementation XZTheThemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setupThemeView{
    
}


-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    NSLog(@"successHandle2= %@",succeedHandle);
    NSArray * themes = (NSArray*)succeedHandle;
    [self.themeView.data addObjectsFromArray:themes];
    [self.themeView.table reloadData];
    [self.themeView.table endRefreshFooter];
    [self.themeView.table endRefreshHeader];
    if (themes.count<=0) {
        self.themeView.table.mj_footer.hidden = YES;
    }
    if (self.themeView.data.count<=0) {
        [self.themeView showNoDataViewWithType:NoDataTypeDefault backgroundBlock:nil btnBlock:^(NoDataType type) {
            //                    [self requestThemeList];
        }];
    }else{
        [self.themeView hideNoDataView];
    }

}

-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{

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
