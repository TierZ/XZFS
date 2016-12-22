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
@end

@implementation XZThemeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    [self setupTable];
    [self requestThemeListWithPage:1];

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
    
//    [self.themes addObjectsFromArray:[self creatModelsWithCount:10]];
//    [self.themeListTable reloadData];
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
    [self.themes addObjectsFromArray:array];
    [self.themeListTable reloadData];
}

-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{

}
#pragma mark 假数据
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
                           @"当你的 app 没有提供 3x 的 LaunchImage 时屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；https://github.com/gsdios/SDAutoLayout然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。",
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
        int x = arc4random()%5;
        model.content =textArray[x];
        model.comments = @"阿里山的骄傲是爱上大南瓜华盛顿//@王小贱：吃不吃阿萨德";
        
        
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
