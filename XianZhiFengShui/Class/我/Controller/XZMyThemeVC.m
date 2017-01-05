//
//  XZMyThemeVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyThemeVC.h"
#import "XZRefreshTable.h"
#import "XZThemeListCell.h"
#import "XZJoinedThemeListCell.h"
#import "XZMyFocusThemeCell.h"
#import "XZPostTopicVC.h"

NSString * const myThemeCellId = @"myThemeCellId";
NSString * const joinedThemeCellId = @"joinedThemeCellId";
NSString * const focusThemeCellId = @"focusThemeCellId";

@interface XZMyThemeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray * themeArray;
@property (nonatomic,strong)UISegmentedControl * themeSeg;
@property (nonatomic,strong)UIScrollView * themeScroll;
@property (nonatomic,strong)UIView * lineView;
@property (nonatomic,strong)XZRefreshTable * myTheme;//发起的话题
@property (nonatomic,strong)XZRefreshTable * joinedTheme;//参与的话题
@property (nonatomic,strong)XZRefreshTable * focusTheme;//关注的话题
@end

@implementation XZMyThemeVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = RandomColor(1);
    [self setupSeg];
    [self setupScroll];
    
    [self reloadTable];
}

#pragma mark setup
-(void)setupSeg{
    self.themeSeg.frame = CGRectMake(0, 0, SCREENWIDTH, 32);
    [self.mainView addSubview:self.themeSeg];
    self.lineView.frame = CGRectMake(0, self.themeSeg.bottom, SCREENWIDTH/self.themeArray.count, 1);
    [self.mainView addSubview:self.lineView];
}

-(void)setupScroll{
    self.themeScroll.frame = CGRectMake(0, self.lineView.bottom, SCREENWIDTH, XZFS_MainView_H-self.lineView.bottom);
    
    self.themeScroll.contentSize = CGSizeMake(SCREENWIDTH*self.themeArray.count, self.themeScroll.height);
    [self.mainView addSubview:self.themeScroll];
    
    self.myTheme  =[[XZRefreshTable alloc]initWithFrame:CGRectMake(0, 0, self.themeScroll.width, self.themeScroll.height)];
    self.myTheme.dataSource = self;
    self.myTheme.delegate = self;
    self.myTheme.backgroundColor = RandomColor(1);
    
    self.joinedTheme = [[XZRefreshTable alloc]initWithFrame:CGRectMake(SCREENWIDTH, 0, self.themeScroll.width, self.themeScroll.height)];
    self.joinedTheme.dataSource = self;
    self.joinedTheme.delegate = self;
    self.joinedTheme.backgroundColor = RandomColor(1);
    
     self.focusTheme = [[XZRefreshTable alloc]initWithFrame:CGRectMake(SCREENWIDTH*2, 0, self.themeScroll.width, self.themeScroll.height)];
    self.focusTheme.dataSource = self;
    self.focusTheme.delegate = self;
    self.focusTheme.backgroundColor = RandomColor(1);
    [self.themeScroll sd_addSubviews:@[ self.myTheme,self.joinedTheme,self.focusTheme]];
    
    [self.myTheme registerClass:[XZThemeListCell class] forCellReuseIdentifier:myThemeCellId];
    [self.joinedTheme registerClass:[XZJoinedThemeListCell class] forCellReuseIdentifier:joinedThemeCellId];
    [self.focusTheme registerClass:[XZMyFocusThemeCell class] forCellReuseIdentifier:focusThemeCellId];
    
    [self.myTheme refreshListWithBlock:^(int page, BOOL isRefresh) {
        
    }];
    
    [self.joinedTheme refreshListWithBlock:^(int page, BOOL isRefresh) {
        
    }];
    
    [self.focusTheme refreshListWithBlock:^(int page, BOOL isRefresh) {
        
    }];
}

-(void)reloadTable{
    [self.myTheme.dataArray addObjectsFromArray:[self creatModelsWithCount:10]];
    [self.joinedTheme.dataArray addObjectsFromArray:[self creatModelsWithCount:10]];
    [self.focusTheme.dataArray addObjectsFromArray:[self creatModelsWithCount:10]];
    
 
    [self.myTheme reloadData];
    [self.joinedTheme reloadData];
    [self.focusTheme reloadData];
    
    [self.myTheme endRefreshHeader];
    [self.joinedTheme endRefreshHeader];
    [self.focusTheme endRefreshHeader];
    
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


#pragma mark table代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.myTheme) {
        return self.myTheme.dataArray.count;
    }else if (tableView==self.joinedTheme){
        return self.joinedTheme.dataArray.count;
    }else if(tableView==self.focusTheme){
        return self.focusTheme.dataArray.count;
    }return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.myTheme) {
        XZThemeListCell *cell = [tableView dequeueReusableCellWithIdentifier:myThemeCellId];
        [cell hideEditBtn:NO];
        cell.indexPath = indexPath;
        cell.model = self.myTheme.dataArray[indexPath.row];
        __weak typeof(self)weakSelf = self;
        [cell editThemeWithBlock:^(XZThemeListModel *model, NSIndexPath *indexPath) {
            NSLog(@"编辑block");
            [weakSelf.navigationController pushViewController:[[XZPostTopicVC alloc]init] animated:YES];
        }];
        [cell deleteThemeWithBlock:^(XZThemeListModel *model, NSIndexPath *indexPath) {
            NSLog(@"删除block");
        }];
        [cell agreeThemeWithBlock:^(XZThemeListModel *model, NSIndexPath *indexPath) {
            NSLog(@"点赞block");
        }];
        [cell commentThemeWithBlock:^(XZThemeListModel *model, NSIndexPath *indexPath) {
            NSLog(@"评论block");
        }];
        
        
        return cell;
    }else if (tableView==self.joinedTheme){
        XZJoinedThemeListCell *cell = [tableView dequeueReusableCellWithIdentifier:joinedThemeCellId];
        cell.indexPath = indexPath;
        cell.model = self.joinedTheme.dataArray[indexPath.row];
        return cell;
    }else if (tableView==self.focusTheme){
        XZMyFocusThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:focusThemeCellId];
        cell.model = self.focusTheme.dataArray[indexPath.row];
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.myTheme) {
        id model = self.myTheme.dataArray[indexPath.row];
        return [self.myTheme cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZThemeListCell class] contentViewWidth:SCREENWIDTH];
    }else if (tableView==self.joinedTheme){
        id model = self.joinedTheme.dataArray[indexPath.row];
        float cell_h = [self.joinedTheme cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZJoinedThemeListCell class] contentViewWidth:SCREENWIDTH];
        return cell_h;

    }else if (tableView==self.focusTheme){
        id model = self.focusTheme.dataArray[indexPath.row];
        return [self.focusTheme cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZMyFocusThemeCell class] contentViewWidth:SCREENWIDTH];
    }return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark action
-(void)selectSegChanged:(UISegmentedControl*)seg{
 self.themeScroll.contentOffset =CGPointMake(seg.selectedSegmentIndex*SCREENWIDTH,0);
}

#pragma mark scroll代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==self.themeScroll) {
        self.themeSeg.selectedSegmentIndex = scrollView.contentOffset.x/SCREENWIDTH;
        CGRect frame = self.lineView.frame;
        frame.origin.x = self.lineView.width*self.themeSeg.selectedSegmentIndex;
        self.lineView.frame = frame;
    }
   
}

#pragma mark getter

-(NSArray *)themeArray{
    if (!_themeArray) {
        _themeArray = @[ @"我发起的话题",@"我参与的话题",@"我关注的话题" ];
    }
    return _themeArray;
}

-(UISegmentedControl *)themeSeg{
    if (!_themeSeg) {
        _themeSeg =[[UISegmentedControl alloc]initWithItems:self.themeArray];
        [_themeSeg addTarget:self action:@selector(selectSegChanged:) forControlEvents:UIControlEventValueChanged];
        _themeSeg.tintColor=XZFS_NAVICOLOR;
        _themeSeg.backgroundColor = XZFS_NAVICOLOR;
        NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                 NSForegroundColorAttributeName: XZFS_HEX_RGB(@"#eb6000")};
        
        [_themeSeg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                   NSForegroundColorAttributeName: [UIColor blackColor]};
        [_themeSeg setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        _themeSeg.selectedSegmentIndex=0;

    }
    return _themeSeg;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = XZFS_TEXTORANGECOLOR;
    }
    return _lineView;
}

-(UIScrollView *)themeScroll{
    if (!_themeScroll) {
        _themeScroll = [[UIScrollView alloc]init];
        _themeScroll.backgroundColor = [UIColor redColor];
        _themeScroll.pagingEnabled = YES;
        _themeScroll.delegate = self;
    }
    return _themeScroll;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
