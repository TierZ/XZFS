//
//  XZMyJoinedThemeVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/2/16.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMyJoinedThemeVC.h"
#import "XZRefreshTable.h"
#import "XZJoinedThemeListCell.h"
@interface XZMyJoinedThemeVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)XZRefreshTable * joinedTheme;//参与的话题
@end
NSString * const joinedThemeCellId = @"joinedThemeCellId";
@implementation XZMyJoinedThemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTable];
    // Do any additional setup after loading the view.
}

-(void)setupTable{
    self.joinedTheme  =[[XZRefreshTable alloc]initWithFrame:CGRectZero];
     [self.view addSubview:self.joinedTheme];
    self.joinedTheme.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    self.joinedTheme.dataSource = self;
    self.joinedTheme.delegate = self;
    self.joinedTheme.backgroundColor = RandomColor(1);
   
    
    [self.joinedTheme registerClass:[XZJoinedThemeListCell class] forCellReuseIdentifier:joinedThemeCellId];
    
    __weak typeof(self)weakSelf = self;
    [self.joinedTheme refreshListWithBlock:^(int page, BOOL isRefresh) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf reloadTable];
    }];
}

#pragma mark table代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.joinedTheme.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        XZJoinedThemeListCell *cell = [tableView dequeueReusableCellWithIdentifier:joinedThemeCellId];
        cell.indexPath = indexPath;
        cell.model = self.joinedTheme.dataArray[indexPath.row];
        return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        id model = self.joinedTheme.dataArray[indexPath.row];
        float cell_h = [self.joinedTheme cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZJoinedThemeListCell class] contentViewWidth:SCREENWIDTH];
        return cell_h;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

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

-(void)reloadTable{
    [self.joinedTheme.dataArray addObjectsFromArray:[self creatModelsWithCount:30]];
    [self.joinedTheme reloadData];
    [self.joinedTheme endRefreshHeader];
    [self.joinedTheme endRefreshFooter];
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
