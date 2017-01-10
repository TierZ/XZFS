//
//  XZThemeDetailVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/27.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZThemeDetailVC.h"
#import "XZRefreshTable.h"
#import "XZThemeListCell.h"
#import "XZThemeCommentCell.h"
#import "XZFindService.h"
#import "XZThemeDetailData.h"

@interface XZThemeDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)XZRefreshTable * detailTable;
@property (nonatomic,strong)NSMutableArray * data;
@property (nonatomic,strong)NSString * topicCode;
@property (nonatomic,strong)NSMutableArray * hotComments;//热门
@property (nonatomic,strong)NSMutableArray * refreshComments;//新鲜
@property (nonatomic,assign)BOOL isRefresh;//刷新
@end

@implementation XZThemeDetailVC

- (instancetype)initWithTopicCode:(NSString*)topicCode
{
    self = [super init];
    if (self) {
        _topicCode = topicCode;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"话题详情";
    [self.view addSubview:self.detailTable];
    self.detailTable.frame = CGRectMake(0, XZFS_STATUS_BAR_H, SCREENWIDTH, SCREENHEIGHT-XZFS_STATUS_BAR_H);
    self.detailTable.backgroundColor = [UIColor clearColor];
    __weak typeof(self)weakSelf = self;
    [self.detailTable refreshListWithBlock:^(int page, BOOL isRefresh) {
        weakSelf.isRefresh = isRefresh;
        if (isRefresh) {
            [weakSelf requestThemeDetailWithTopicCode:weakSelf.topicCode];
        }else{
            NSLog(@"加载评论列表");
        }
    }];
    NSLog(@"topiccode = %@",_topicCode);
}

#pragma mark 网络

/**
 话题详情

 @param topicCode 话题id
 */
-(void)requestThemeDetailWithTopicCode:(NSString*)topicCode{
    NSDictionary * dic = GETUserdefault(@"userInfos");
    NSString * userCode = [dic objectForKey:@"bizCode"]?:@"";
    
    XZFindService * themeDetailService = [[XZFindService alloc]initWithServiceTag:XZThemeDetail];
    themeDetailService.delegate = self;
    [themeDetailService themeDetailWithTopicCode:topicCode userCode:userCode cityCode:@"110000" view:self.mainView];
}


/**
 点赞
 */
-(void)pointOfPraiseTopic{
    NSDictionary * dic = GETUserdefault(@"userInfos");
    NSString * userCode = [dic objectForKey:@"bizCode"]?:@"";
    
    XZThemeDetailData * pointOfPraiseService = [[XZThemeDetailData alloc]initWithServiceTag:XZPointOfPraiseTopicTag];
    pointOfPraiseService.delegate = self;
    [pointOfPraiseService pointOfPraiseTopicWithCityCode:@"11000" topicCode:self.topicCode userCode:userCode view:self.mainView];
}

-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    NSLog(@"successhandle = %@",succeedHandle);
    if ([service isKindOfClass:[XZFindService class]]) {
        XZFindService * serv = (XZFindService*)service;
        switch (serv.serviceTag) {
            case XZThemeDetail:{
                NSDictionary * dic = (NSDictionary*)succeedHandle;
                NSArray * data1 = @[[XZThemeListModel modelWithJSON:dic]];
                NSArray * data2 = [dic objectForKey:@"commentList"];
                NSArray * data3 =  [dic objectForKey:@"commentList"];
                for (int i = 0; i<data2.count; i++) {
                    XZThemeCommentModel * model = [XZThemeCommentModel modelWithJSON:data2[i]];
                    [self.hotComments addObject:model];
                }

                for (int i = 0; i<data3.count; i++) {
                    XZThemeCommentModel * model = [XZThemeCommentModel modelWithJSON:data3[i]];
                    [self.refreshComments addObject:model];
                }
                
                [self.data addObjectsFromArray:@[ data1,self.hotComments,self.refreshComments ]];
                [self.detailTable reloadData];
                if (self.isRefresh) {
                    [self.detailTable endRefreshHeader];
                }else{
                    [self.detailTable endRefreshFooter];
                }
            }
                break;
                
            default:
                break;
        }
    }else if ([service isKindOfClass:[XZThemeDetailData class]]){
        NSLog(@"点赞。。%@",succeedHandle);
        NSDictionary * dic = (NSDictionary*)succeedHandle;
        NSDictionary * data = [dic objectForKey:@"data"];
        if ([[data objectForKey:@"affect"]intValue]==1) {
            NSArray * detailArr = [self.data firstObject];
            XZThemeListModel * model = detailArr[0];
            model.pointOfPraise = [NSString stringWithFormat:@"%d",[model.pointOfPraise intValue]+1];
            [self.detailTable reloadSection:0 withRowAnimation:UITableViewRowAnimationNone];
        }
    }
    
}
-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{
    if (self.isRefresh) {
        [self.detailTable endRefreshHeader];
    }else{
        [self.detailTable endRefreshFooter];
    }

}


#pragma mark table代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.data[section]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * detailCellId = @"detailCellId";
    static NSString * commentCellId = @"commentCellId";
    __weak typeof(self)weakSelf = self;
    if (indexPath.section==0) {
        XZThemeListCell * detailCell = [tableView dequeueReusableCellWithIdentifier:detailCellId];
        if (!detailCell) {
            detailCell = [[XZThemeListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellId];
        }
        [detailCell hideEditBtn:YES];
        detailCell.model = self.data[indexPath.section][indexPath.row];
        [detailCell agreeThemeWithBlock:^(XZThemeListModel *model, NSIndexPath *indexPath) {
            [weakSelf pointOfPraiseTopic];
        }];
        return detailCell;
    }else{
        XZThemeCommentCell * commentCell = [tableView dequeueReusableCellWithIdentifier:commentCellId];
        if (!commentCell) {
            commentCell = [[XZThemeCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCellId];
        }
      
        commentCell.model = self.data[indexPath.section][indexPath.row];
        return commentCell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.data[indexPath.section][indexPath.row];
    if (indexPath.section==0) {
          return [self.detailTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZThemeListCell class] contentViewWidth:SCREENWIDTH];
    }
    return [self.detailTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZThemeCommentCell class] contentViewWidth:SCREENWIDTH];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [UIView new];
    view.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
    if (section==0) {
        view.frame = CGRectMake(0, 0, SCREENWIDTH, 4);
    }else{
        view.backgroundColor = [UIColor whiteColor];
        view.frame = CGRectMake(0, 0, SCREENWIDTH, 30);
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 200, 29)];
        lab.text = @"热门评论";
        lab.textColor = XZFS_TEXTORANGECOLOR;
        lab.font = XZFS_S_FONT(12);
        [view addSubview:lab];
        
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 29, SCREENWIDTH, 1)];
        line.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
        [view addSubview:line];
    }
    
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==self.data.count-1) {
        return nil;
    }
    UIView * footerV = [UIView new];
    footerV.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
    footerV.frame = CGRectMake(0, 0, SCREENWIDTH, 4);
    return footerV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==self.data.count-1) {
        return 0;
    }return 4;

}

#pragma mark getter
-(XZRefreshTable *)detailTable{
    if (!_detailTable) {
        _detailTable = [[XZRefreshTable alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _detailTable.backgroundColor = XZFS_HEX_RGB(@"#ffffff");
        _detailTable.dataSource = self;
        _detailTable.delegate = self;
        _detailTable.row = 1;
        _detailTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView * footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        _detailTable.tableFooterView = footerView;
    }
    return _detailTable;
}

-(NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

-(NSMutableArray *)hotComments{
    if (!_hotComments) {
        _hotComments = [NSMutableArray array];
    }
    return _hotComments;
}
-(NSMutableArray *)refreshComments{
    if (!_refreshComments) {
        _refreshComments = [NSMutableArray array];
    }
    return _refreshComments;
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
