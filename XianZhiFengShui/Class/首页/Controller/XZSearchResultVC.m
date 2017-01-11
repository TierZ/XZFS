//
//  XZSearchResultVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/11.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZSearchResultVC.h"
#import "XZHomeService.h"
#import "XZFindTable.h"
@interface XZSearchResultVC ()

@end

@implementation XZSearchResultVC{
    NSString * _keyword;
    XZFindTable * _searchTable;
}

- (instancetype)initWithKeyWord:(NSString*)keyword
{
    self = [super init];
    if (self) {
        _keyword = keyword;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self searchWithKeyWord:_keyword];
    [self setupTable];
}

-(void)setupTable{
    _searchTable = [[XZFindTable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, XZFS_MainView_H) style:XZFindMaster];
    _searchTable.currentVC = self;
    [self.mainView addSubview:_searchTable];
}

-(void)searchWithKeyWord:(NSString*)keyWord{
    NSDictionary * dic = GETUserdefault(@"userInfos");
    NSString * userCodeStr = KISDictionaryHaveKey(dic, @"bizCode");
    XZHomeService * homeMasterService = [[XZHomeService alloc]init];
    [ homeMasterService masterListWithPageNum:1 PageSize:10 cityCode:@"11000" keyWord:keyWord searchType:1 userCode:userCodeStr view:self.mainView successBlock:^(NSArray *data) {
        [_searchTable.data addObjectsFromArray:data];
        if (_searchTable.data.count<=0) {
            [_searchTable showNoDataViewWithType:NoDataTypeDefault backgroundBlock:^{
                [self searchWithKeyWord:_keyword];
            } btnBlock:nil];
        }else{
             [_searchTable hideNoDataView];
        }
        NSLog(@"dataarray = %@",data);
    } failBlock:^(NSError *error) {
        [_searchTable showNoDataViewWithType:NoDataTypeDefault backgroundBlock:^{
            [self searchWithKeyWord:_keyword];
        } btnBlock:nil];
        NSLog(@"error= %@",error);
    }];

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
