//
//  XZMyMasterVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyMasterVC.h"
#import "XZMyMasterWantedView.h"
#import "XZMyMasterFinishedView.h"
#import "XZFindService.h"
#import "UIButton+XZImageTitleSpacing.h"
#import "XZMasterOrderVC.h"

#import "XZMyMasterFinishedVC.h"
#import "XZMyMasterWantedVC.h"

@interface XZMyMasterVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIButton*wantBtn;//想参加的
@property (nonatomic,strong)UIButton * finishedBtn;//完成的
@property (nonatomic,strong)NSArray * listArray;
@property (nonatomic,strong)UIView * lineView;
@property (nonatomic,strong)UIScrollView * selectScroll;
@property (nonatomic,strong)XZMyMasterWantedView * wantView;
@property (nonatomic,strong)XZMyMasterFinishedView * finishView;
@property (nonatomic,strong)  XZMyMasterFinishedVC * finishVC ;
@end

@implementation XZMyMasterVC{
    BOOL isShowSelectList;//是否显示 筛选列表
    int tmpTag;//计算是否显示列表的 临时数字
    UITableView * selectList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSeg];
    [self setupScroll];
    isShowSelectList = NO;
    tmpTag = 1;
    [self setupSelectList];
    self.rightButton.backgroundColor = [UIColor redColor];
}

-(void)clickRightButton{
    [self.navigationController pushViewController:[[XZMasterOrderVC alloc]init] animated:YES];
}

-(void)setupSeg{
    self.finishedBtn.frame = CGRectMake(0, 0, SCREENWIDTH/2, 32);
    self.wantBtn.frame = CGRectMake(SCREENWIDTH/2, 0, SCREENWIDTH/2, 32);
    [self.mainView addSubview:self.finishedBtn];
    [self.mainView addSubview:self.wantBtn];
    float lineWidth = (SCREENWIDTH-20*2)/2;
    self.lineView.frame = CGRectMake(20, self.finishedBtn.bottom-0.5, lineWidth, 1);
    [self.mainView addSubview:self.lineView];

}
-(void)setupScroll{
    self.selectScroll.frame = CGRectMake(0, self.lineView.bottom, SCREENWIDTH, XZFS_MainView_H-self.lineView.bottom);
    [self.mainView addSubview:self.selectScroll];
    self.selectScroll.contentSize = CGSizeMake(self.selectScroll.width*2, self.selectScroll.height);
    
    self.finishVC = [[XZMyMasterFinishedVC alloc]init];
    self.finishVC.view.frame =CGRectMake(0, 0, self.selectScroll.width, self.selectScroll.height);
    [self addChildViewController:self.finishVC];
    [self.selectScroll addSubview:self.finishVC.view];
    
    XZMyMasterWantedVC * wantVC = [[XZMyMasterWantedVC alloc]init];
    wantVC.view.frame = CGRectMake(self.selectScroll.width, 0, self.selectScroll.width, self.selectScroll.height);
    [self addChildViewController:wantVC];
    [self.selectScroll addSubview:wantVC.view];
    
//    self.finishView = [[XZMyMasterFinishedView alloc]initWithFrame:CGRectMake(0, 0, self.selectScroll.width, self.selectScroll.height)];
//    self.finishView.weakSelfVC = self;
//    [self.selectScroll addSubview:self.finishView];
    
//    self.wantView = [[XZMyMasterWantedView alloc]initWithFrame:CGRectMake(self.selectScroll.width, 0, self.selectScroll.width, self.selectScroll.height)];
//     self.wantView.weakSelfVC = self;
//    [self.selectScroll addSubview:self.wantView];

}

-(void)setupSelectList{
   selectList = [[UITableView alloc]initWithFrame:CGRectMake(0, self.finishedBtn.bottom, SCREENWIDTH, XZFS_MainView_H-self.finishedBtn.height) style:UITableViewStylePlain];
    selectList.delegate = self;
    selectList.dataSource = self;
    selectList.hidden = YES;
    selectList.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    UIView * footV = [UIView new];
    selectList.tableFooterView = footV;
    [self.mainView addSubview:selectList];
}



-(void)selectWant{
    isShowSelectList = NO;
    selectList.hidden = !isShowSelectList;
    tmpTag = 0;
      [self.finishedBtn setImage:XZFS_IMAGE_NAMED(@"xiangxia") forState:UIControlStateNormal];
    self.finishedBtn.selected = NO;
    self.wantBtn.selected = YES;
    [self.selectScroll setContentOffset:CGPointMake(self.selectScroll.width, 0) animated:YES];
}
-(void)selectFinished{
    tmpTag++;
    
    NSLog(@"tmptag = %d",tmpTag);
    if (tmpTag>1) {
        isShowSelectList = tmpTag%2==0?YES:NO;
        selectList.hidden = !isShowSelectList;
        if (isShowSelectList) {
            [self.finishedBtn setImage:XZFS_IMAGE_NAMED(@"xiangshang") forState:UIControlStateNormal];
        }else{
             [self.finishedBtn setImage:XZFS_IMAGE_NAMED(@"xiangxia") forState:UIControlStateNormal];
        }
    }
    self.finishedBtn.selected = YES;
    self.wantBtn.selected = NO;
     [self.selectScroll setContentOffset:CGPointMake(0, 0) animated:YES];
    
}

#pragma mark delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int offsetX = scrollView.contentOffset.x;
    if (offsetX==0) {
        self.finishedBtn.selected = YES;
        self.wantBtn.selected = NO;
    }else if (offsetX==SCREENWIDTH){
        self.finishedBtn.selected = NO;
        self.wantBtn.selected = YES;
    }
    
    CGRect frame = self.lineView.frame;
    frame.origin.x = 20+self.lineView.width*(offsetX/SCREENWIDTH);
    self.lineView.frame = frame;
}


#pragma mark table 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"selectListCellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.backgroundColor = XZFS_HEX_RGB(@"#FAF9F9");
    cell.textLabel.text = self.listArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 37;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击--%@",self.listArray[indexPath.row]);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.finishedBtn setImage:XZFS_IMAGE_NAMED(@"xiangxia") forState:UIControlStateNormal];
    isShowSelectList = NO;
    selectList.hidden = !isShowSelectList;
    tmpTag = 1;
    BOOL isFinished = indexPath.row==0?NO:YES;
    [self.finishVC selectDataIsFinished:isFinished];
    
}


#pragma mark getter
-(NSArray *)listArray{
    if (!_listArray) {
        _listArray = @[@"进行中",@"已约见"];
    }
    return _listArray;
}

-(UIButton *)wantBtn{
    if (!_wantBtn) {
        _wantBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wantBtn setTitle:@"我想约的大师" forState:UIControlStateNormal];
        [_wantBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         [_wantBtn setTitleColor:XZFS_HEX_RGB(@"#eb6000") forState:UIControlStateSelected];
//        [_wantBtn setImage:XZFS_IMAGE_NAMED(@"xiangxia") forState:UIControlStateNormal];
//         [_wantBtn setImage:XZFS_IMAGE_NAMED(@"xiangshang") forState:UIControlStateNormal];
        _wantBtn.titleLabel.font = XZFS_S_FONT(12);
//        [_wantBtn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleRight imageTitleSpace:5];
        [_wantBtn addTarget:self action:@selector(selectWant) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wantBtn;
}

-(UIButton *)finishedBtn{
    if (!_finishedBtn) {
        _finishedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_finishedBtn setTitle:@"我约过的大师" forState:UIControlStateNormal];
        [_finishedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_finishedBtn setTitleColor:XZFS_HEX_RGB(@"#eb6000") forState:UIControlStateSelected];
        _finishedBtn.selected = YES;
        [_finishedBtn setImage:XZFS_IMAGE_NAMED(@"xiangxia") forState:UIControlStateNormal];
        _finishedBtn.titleLabel.font = XZFS_S_FONT(12);
        [_finishedBtn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleRight imageTitleSpace:10];
        [_finishedBtn addTarget:self action:@selector(selectFinished) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishedBtn;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = XZFS_HEX_RGB(@"#eb6000");
    }
    return _lineView;
}

-(UIScrollView *)selectScroll{
    if (!_selectScroll) {
        _selectScroll = [[UIScrollView alloc]init];
        _selectScroll.delegate = self;
        _selectScroll.pagingEnabled = YES;
        _selectScroll.showsHorizontalScrollIndicator = NO;
        _selectScroll.backgroundColor = [UIColor clearColor];
    }
    return _selectScroll;
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
