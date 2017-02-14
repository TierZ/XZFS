//
//  XZMyLectureVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyLectureVC.h"
#import "XZFindTable.h"
#import "XZTheMasterModel.h"
#import "XZUserCenterService.h"


@interface XZMyLectureVC ()<UIScrollViewDelegate>
@property (nonatomic,strong)UISegmentedControl * selectSeg;
@property (nonatomic,strong)NSArray * selectArray;
@property (nonatomic,strong)UIView * lineView;
@property (nonatomic,strong)UIScrollView * selectScroll;
@property (nonatomic,strong)XZFindTable * wantJoinLecture;//想参加的
@property (nonatomic,strong)XZFindTable * joinedLecture;//参加的
@end

@implementation XZMyLectureVC{
    NSString * _userCode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary * dic = GETUserdefault(@"userInfos");
    _userCode = [dic objectForKey:@"bizCode"]?:@"";
    [self drawMainSeg];
    [self drawMainScroll];
    [self requestMySignUpLecture];
//    [self showData];
    // Do any additional setup after loading the view.
}


-(void)drawMainSeg{
    self.selectSeg.frame = CGRectMake(0, 0, SCREENWIDTH, 33);
    [self.mainView addSubview:self.selectSeg];
    
    self.lineView.frame = CGRectMake(0, self.selectSeg.bottom-1, SCREENWIDTH/2, 2);
    [self.mainView addSubview:self.lineView];
}

-(void)drawMainScroll{
    [self.mainView addSubview:self.selectScroll];
    self.selectScroll.frame = CGRectMake(0, self.selectSeg.bottom, SCREENWIDTH, SCREENHEIGHT-XZFS_STATUS_BAR_H-self.selectSeg.bottom);
    self.selectScroll.contentSize = CGSizeMake(SCREENWIDTH*self.selectArray.count, self.selectScroll.height);
    self.selectScroll.contentOffset = CGPointMake(0, 0);
    
    self.joinedLecture = [[XZFindTable alloc]initWithFrame:CGRectMake(0, 0, self.selectScroll.width, self.selectScroll.height) style:XZFindLecture];
    self.joinedLecture.showLecturePrice = NO;
    self.joinedLecture.currentVC = self;
    self.joinedLecture.backgroundColor =  [UIColor whiteColor];
    [self.selectScroll addSubview:self.joinedLecture];
    
    self.wantJoinLecture = [[XZFindTable alloc]initWithFrame:CGRectMake(self.selectScroll.width, 0, self.selectScroll.width, self.selectScroll.height) style:XZFindLecture];
    self.wantJoinLecture.backgroundColor = [UIColor whiteColor];
    self.wantJoinLecture.currentVC = self;

    self.wantJoinLecture.showLecturePrice = YES;

    [self.selectScroll addSubview:self.wantJoinLecture];
 
}
//#pragma mark data
-(void)showData{
    for (int i = 0; i<20; i++) {
        XZTheMasterModel * lecture = [[XZTheMasterModel alloc]init];
        lecture.masterIcon = @"http://file.shagualicai.cn/201610/09/pic/pic_14759978965900.jpg";
        lecture.masterName = @"张三丰";
        lecture.masterDesc = @"中国道教协会会长，武当创始人，太极";
        lecture.title = @"聊聊买房买车开公司那些事";
        if (i%5==0) {
            lecture.masterName  =@"老子 ";
            lecture.title  =@"做梦解梦，你了不了解你梦到的东西";
        }
        lecture.price = @"￥99";
        lecture.startTime = @"9月18日  9:00";
        lecture.remainSeats = @"余10席";
        
        [self.wantJoinLecture.data addObject:lecture];
        [self.joinedLecture.data addObject:lecture];

    }
    [self.wantJoinLecture.table reloadData];
    [self.joinedLecture.table reloadData];
}



#pragma mark action
-(void)selectSegChanged:(UISegmentedControl*)seg{
    self.selectScroll.contentOffset =CGPointMake(seg.selectedSegmentIndex*SCREENWIDTH,0);
}

#pragma mark delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.selectSeg.selectedSegmentIndex = scrollView.contentOffset.x/SCREENWIDTH;
    CGRect frame = self.lineView.frame;
    frame.origin.x = self.lineView.width*self.selectSeg.selectedSegmentIndex;
    self.lineView.frame = frame;
    if (scrollView.contentOffset.x==0) {
        if (self.joinedLecture.data.count<=0) {
            [self requestMySignUpLecture];
        }
    }else if (scrollView.contentOffset.x==SCREENWIDTH){
        if (self.wantJoinLecture.data.count<=0) {
            [self requestMyCollectionLecture];
        }

    }
}

#pragma mark network
-(void)requestMySignUpLecture{
    
    XZUserCenterService * mySignUpService = [[XZUserCenterService alloc]initWithServiceTag:XZMySignupLectureTag];
    mySignUpService.delegate = self;
    [mySignUpService mySignUpLectureWithUserCode:_userCode pageNum:self.joinedLecture.table.row pageSize:10 view:self.joinedLecture ];
}

-(void)requestMyCollectionLecture{
    
    XZUserCenterService * myCollectionService = [[XZUserCenterService alloc]initWithServiceTag:XZMyCollectionLectureTag];
    myCollectionService.delegate = self;
    [myCollectionService myCollectionLectureWithUserCode:_userCode pageNum:self.wantJoinLecture.table.row pageSize:10 view:self.wantJoinLecture ];
}

-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    XZUserCenterService * lectureService = (XZUserCenterService*)service;
    switch (lectureService.serviceTag) {
        case XZMySignupLectureTag:{
            NSLog(@"参加的讲座%@",succeedHandle);
            NSArray * arr = (NSArray*)succeedHandle;
            [self showDataAfterNetRequestWithArray:arr dataTable:self.joinedLecture.table];
        }
            break;
        case XZMyCollectionLectureTag:{
            NSLog(@"收藏的讲座%@",succeedHandle);
            NSArray * arr = (NSArray*)succeedHandle;
            [self showDataAfterNetRequestWithArray:arr dataTable:self.wantJoinLecture.table];
        }
            break;
            
        default:
            break;
    }
    NSLog(@"netsculels = %@",succeedHandle);
}

-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{
    XZUserCenterService * lectureService = (XZUserCenterService*)service;
    switch (lectureService.serviceTag) {
        case XZMySignupLectureTag:{
            NSLog(@"参加的讲座%@",failHandle);
              [self showDataAfterNetRequestWithArray:@[] dataTable:self.joinedLecture.table];
//            [self.joinedLecture.table endRefreshHeader];
//            [self.joinedLecture.table endRefreshFooter];
        }
            break;
        case XZMyCollectionLectureTag:{
            NSLog(@"收藏的讲座%@",failHandle);
              [self showDataAfterNetRequestWithArray:@[] dataTable:self.wantJoinLecture.table];
//            [self.wantJoinLecture.table endRefreshHeader];
//            [self.wantJoinLecture.table endRefreshFooter];
        }
            break;
            
        default:
            break;

    }

}


-(void)showDataAfterNetRequestWithArray:(NSArray*)array dataTable:(XZRefreshTable*)table{
    if (table.row==1) {
        [table.dataArray removeAllObjects];
    }
    [table.dataArray addObjectsFromArray:array];
    [table reloadData];
    [table endRefreshHeader];
    [table endRefreshFooter];
    if (array.count<=0) {
        table.mj_footer.hidden = YES;
    }
    __weak typeof(self)weakSelf = self;
    if (table.dataArray.count<=0) {
        [table showNoDataViewWithType:NoDataTypeDefault backgroundBlock:^{
            if (table ==weakSelf.joinedLecture.table) {
                [weakSelf requestMySignUpLecture];
            }else if (table==weakSelf.wantJoinLecture.table){
                [weakSelf requestMyCollectionLecture];
            }
        } btnBlock:nil];
    }else{
        [table hideNoDataView];
    }
}

#pragma mark getter

-(NSArray *)selectArray{
    if (!_selectArray) {
        _selectArray = @[@"我参加过的讲座",@"我想参加的讲座"];
    }
    return _selectArray;
    
}

-(UISegmentedControl *)selectSeg{
    if (!_selectSeg) {
        _selectSeg =[[UISegmentedControl alloc]initWithItems:self.selectArray];
        [_selectSeg addTarget:self action:@selector(selectSegChanged:) forControlEvents:UIControlEventValueChanged];
//        _selectSeg.frame =  CGRectMake(0, 20, SCREENWIDTH, XZFS_STATUS_BAR_H-22);
        _selectSeg.tintColor=XZFS_NAVICOLOR;
        _selectSeg.backgroundColor = XZFS_NAVICOLOR;
        NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                 NSForegroundColorAttributeName: XZFS_HEX_RGB(@"#eb6000")};
        
        [_selectSeg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                   NSForegroundColorAttributeName: [UIColor blackColor]};
        [_selectSeg setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        _selectSeg.selectedSegmentIndex=0;
    }
    return _selectSeg;
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
