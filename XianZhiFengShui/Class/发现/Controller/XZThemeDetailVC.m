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

@interface XZThemeDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)XZRefreshTable * detailTable;
@property (nonatomic,strong)NSMutableArray * data;
@property (nonatomic,strong)NSString * topicCode;
@property (nonatomic,strong)NSMutableArray * hotComments;//热门
@property (nonatomic,strong)NSMutableArray * refreshComments;//新鲜
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
    NSLog(@"topiccode = %@",_topicCode);
    [self requestThemeDetailWithTopicCode:self.topicCode];
//    [self setupData];
}

#pragma mark 网络
-(void)requestThemeDetailWithTopicCode:(NSString*)topicCode{
    NSDictionary * dic = GETUserdefault(@"userInfos");
    NSString * userCode = [dic objectForKey:@"bizCode"];
    
    XZFindService * themeDetailService = [[XZFindService alloc]initWithServiceTag:XZThemeDetail];
    themeDetailService.delegate = self;
    [themeDetailService themeDetailWithTopicCode:topicCode userCode:userCode cityCode:@"110000" view:self.mainView];

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

            }
                break;
                
            default:
                break;
        }
    }
    
}
-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{
    
}
#pragma mark data
-(void)setupData{
    NSArray * data1 = [self creatModelsWithCount:1];
    NSArray * data2 = [self createCommentDataWithCount:3];
    for (int i = 0; i<data2.count; i++) {
        XZThemeCommentModel * model = [XZThemeCommentModel modelWithJSON:data2[i]];
        [self.hotComments addObject:model];
    }
    NSArray * data3 = [self createCommentDataWithCount:2];
    
    for (int i = 0; i<data3.count; i++) {
        XZThemeCommentModel * model = [XZThemeCommentModel modelWithJSON:data3[i]];
        [self.refreshComments addObject:model];
    }

    [self.data addObjectsFromArray:@[ data1,self.hotComments,self.refreshComments ]];
    [self.detailTable reloadData];
    
}
- (NSArray *)creatModelsWithCount:(NSInteger)count
{
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"GSD_iOS",
                            @"风口上的猪",
                            @"当今世界网名都不好起了",
                            @"我叫郭德纲",
                            @"Hello Kitty"];
    
    NSArray *textArray = @[@"当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，https://github.com/gsdios/SDAutoLayout大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，https://github.com/gsdios/SDAutoLayout等于把小屏完全拉伸。",
                           @"但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    
    
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"pic5.jpg",
                                     @"pic6.jpg",
                                     @"pic7.jpg",
                                     @"pic8.jpg"
                                     ];
    NSMutableArray *resArr = [NSMutableArray new];
    
    for (int i = 0; i < count; i++) {
        int iconRandomIndex = arc4random_uniform(5);
        int nameRandomIndex = arc4random_uniform(5);
        int contentRandomIndex = arc4random_uniform(5);
        
        XZThemeListModel *model = [XZThemeListModel new];
        model.icon = iconImageNamesArray[iconRandomIndex];
        model.issuer = namesArray[nameRandomIndex];
        model.issueTime = @"1小时前";
        model.pointOfPraise  =@"99";
        model.commentCount = @"111";
        model.isAgree = YES;
        model.isComment = NO;
        model.title = @"求大神指点能不能挣钱。。。。。挣大钱";
        int x = arc4random()%4;
        model.content =textArray[x];
        
        
        // 模拟“随机图片”
        int random = arc4random_uniform(10);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(9);
            [temp addObject:picImageNamesArray[randomIndex]];
        }
        if (temp.count) {
            model.photo = [temp copy];
        }
        
        
        [resArr addObject:model];
    }
    return [resArr copy];
}

-(NSArray*)createCommentDataWithCount:(NSInteger)count{
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (int i = 0; i<count; i++) {
        XZThemeCommentModel * model = [[XZThemeCommentModel alloc]init];
        model. avatar = @"http://file.shagualicai.cn/201610/09/pic/pic_14759978965900.jpg";
        model.commenter = @"过河不用拆桥";
        model.time = @"3小时前";
        model.agree = @"99";
        model.comment = @"99";
        model.content = @"阿萨德了卡卡那考试及的垃圾你奥is的垃圾桶里看谁大那个，现在呢，才能卡死的清垃圾垃圾费拉抠脚大汉噶";
        [tmpArr addObject:model];
    }
    return tmpArr;
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
    if (indexPath.section==0) {
        XZThemeListCell * detailCell = [tableView dequeueReusableCellWithIdentifier:detailCellId];
        if (!detailCell) {
            detailCell = [[XZThemeListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellId];
        }
        detailCell.model = self.data[indexPath.section][indexPath.row];
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
