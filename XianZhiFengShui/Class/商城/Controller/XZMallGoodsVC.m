//
//  XZMallGoodsVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/8.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMallGoodsVC.h"
#import "XZGoodsCell.h"
#import "XZGoodsDetailVC.h"

@interface XZMallGoodsVC () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView * goodsCV;
@property (nonatomic,strong)NSMutableArray * array;
@property (nonatomic,assign)BOOL isCollection;
@end

@implementation XZMallGoodsVC

- (instancetype)initWithCollection:(BOOL)isCollection
{
    self = [super init];
    if (self) {
        _isCollection = isCollection;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollection];
    self.array = [NSMutableArray array];
    [self setupData];
    [self setupRefresh];
    // Do any additional setup after loading the view.
}

-(void)setupData{
    for (int i = 0; i<15; i++) {
        XZGoodsModel * model = [[XZGoodsModel alloc]init];
        model.image = @"http://file.shagualicai.cn/201610/09/pic/pic_14759978965900.jpg";
        model.name = @"宏泰翔  8寸风水罗盘";
        model.price = @"3800";
        model.expressPrice = @"10";
        model.comment = @"1314";
        model.wellComment = @"93%";
        [self.array addObject:model];
    }
    [self.goodsCV reloadData];
    
}

-(void)setupCollection{
    float space = 23;
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((SCREENWIDTH-space*3)/2, (SCREENWIDTH-space*3)/2+65);
    layout.sectionInset = UIEdgeInsetsMake(5, 17.25, 5, 17.25);
    
    self.goodsCV = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
//    CGRect frame = self.goodsCV.frame;
//    frame.size.height = SCREENHEIGHT-XZFS_STATUS_BAR_H-XZFS_Bottom_H-35;//为了在父vc上显示全，
//    self.goodsCV.frame = frame;
    self.goodsCV.delegate = self;
    self.goodsCV.dataSource = self;
    self.goodsCV.backgroundColor = [UIColor whiteColor];
    [self.goodsCV registerClass:[XZGoodsCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.view addSubview:self.goodsCV];
}

-(void)setupRefresh{
    self.goodsCV.mj_header =  [MJRefreshGifHeader headerWithRefreshingBlock:^{
        NSLog(@"下拉刷新");
        [self.goodsCV.mj_header beginRefreshing];
    }];
    
    self.goodsCV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"上啦加载");
        [self.goodsCV.mj_footer beginRefreshing];
    }];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    XZGoodsCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    [cell hideExpress:self.isCollection];
    [cell refreshCellWithModel:self.array[indexPath.row]];
    return cell;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XZGoodsDetailVC * detailvc = [[XZGoodsDetailVC alloc]initWithGoodsId:@"12313"];
    [self.parentViewController.navigationController pushViewController:detailvc animated:YES];
    NSLog(@"点击 indexpath = %ld",(long)indexPath.row);
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
