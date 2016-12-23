//
//  XZMallVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/8.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMallVC.h"
#import "XZBindingPhoneVC.h"
#import "XZPersonCertificationVC.h"
#import "JCHATConversationController.h"
#import "XZMallGoodsVC.h"
#import "XZShoppingCartVC.h"
#import "XZOrderVC.h"
#import "XZAddressListVC.h"

//#import "JCHATConversationViewController.h"
@interface XZMallVC ()<UIScrollViewDelegate>
@property (nonatomic,strong)UISegmentedControl * seg;
@property (nonatomic,strong)UIScrollView * scroll;
@property (nonatomic,strong)NSArray * titleArray;
@property (nonatomic,strong)UIView * lineView;
@end

@implementation XZMallVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"商城";
     self.view.backgroundColor = [UIColor yellowColor];
    self.leftButton.hidden = YES;
    
    self.rightButton .backgroundColor = [UIColor redColor];

    
    [self setupHeader];
}

-(void)setupHeader{
    self.seg.frame = CGRectMake(0, 0, SCREENWIDTH, 34);
    [self.mainView addSubview:self.seg];
    self.lineView.frame = CGRectMake(0, self.seg.bottom-0.5, 84, 1);
    self.lineView.centerX = self.seg.centerX/4;
    [self.mainView addSubview:self.lineView];
    self.scroll.frame = CGRectMake(0, self.seg.bottom+1, SCREENWIDTH, XZFS_MainView_H-XZFS_Bottom_H-self.seg.bottom-1);
    self.scroll.contentSize = CGSizeMake(SCREENWIDTH*self.titleArray.count, self.scroll.height);
    [self.mainView addSubview:self.scroll];
    
    XZMallGoodsVC * goodsVC = [[XZMallGoodsVC alloc]initWithCollection:NO];
    [self addChildViewController:goodsVC];
    CGRect frame = goodsVC.view.frame;
    frame.origin.x = SCREENWIDTH;
    goodsVC.view.frame = CGRectMake(0, 0, SCREENWIDTH,XZFS_MainView_H-XZFS_Bottom_H-self.seg.bottom-1 );
    [self.scroll addSubview:goodsVC.view];
    
    XZShoppingCartVC * cartVC = [[XZShoppingCartVC alloc]init];
    [self addChildViewController:cartVC];
    cartVC.view.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH,SCREENHEIGHT-XZFS_STATUS_BAR_H-XZFS_Bottom_H-35-80 );
    [self.scroll addSubview:cartVC.view];
    
    
    XZMallGoodsVC * collectionVC = [[XZMallGoodsVC alloc]initWithCollection:YES];
    [self addChildViewController:collectionVC];
    collectionVC.view.frame = CGRectMake(SCREENWIDTH*2, 0, SCREENWIDTH,SCREENHEIGHT-XZFS_STATUS_BAR_H-XZFS_Bottom_H-35-80 );
    [self.scroll addSubview:collectionVC.view];
    
    XZOrderVC * orderVC = [[XZOrderVC alloc]init];
    [self addChildViewController:orderVC];
    orderVC.view.frame = CGRectMake(SCREENWIDTH*3, 0, SCREENWIDTH,SCREENHEIGHT-XZFS_STATUS_BAR_H-XZFS_Bottom_H-35-80 );
    [self.scroll addSubview:orderVC.view];
    
    
}

-(void)clickRightButton{
    [self.navigationController pushViewController:[[XZAddressListVC alloc]init] animated:YES];
    
//    __block JCHATConversationController *sendMessageCtl = [[JCHATConversationController alloc] init];
//    sendMessageCtl.superViewController = self;
//    
//    //    sendMessageCtl.hidesBottomBarWhenPushed = YES;
//    __weak __typeof(self)weakSelf = self;
//    [JMSGConversation createSingleConversationWithUsername:@"asdfg" appKey:JMESSAGE_APPKEY completionHandler:^(id resultObject, NSError *error) {
//        
//        if (error == nil) {
//            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//            __strong __typeof(weakSelf) strongSelf = weakSelf;
//            sendMessageCtl.conversation = resultObject;
//            [strongSelf.navigationController pushViewController:sendMessageCtl animated:YES];
//        } else {
//            [MBProgressHUD showMessage:[error.userInfo objectForKey:@"NSLocalizedDescription" ] view:self.mainView];
//        }
//        
//    }];
}

#pragma mark action
-(void)titleSegChanged:(UISegmentedControl*)seg{
    [self.scroll setContentOffset:CGPointMake(SCREENWIDTH*seg.selectedSegmentIndex, 0) animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.seg.selectedSegmentIndex = self.scroll.contentOffset.x/SCREENWIDTH;
    CGRect frame = self.lineView.frame;
    frame.origin.x = self.lineView.width*self.seg.selectedSegmentIndex;
    self.lineView.frame = frame;
    self.lineView.centerX = self.seg.selectedSegmentIndex*(2*(SCREENWIDTH-4*84)/8+84)+self.seg.centerX/4;
}

#pragma mark getter
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"宝贝",@"购物车",@"收藏",@"订单"];
    }
    return _titleArray;
    
}


-(UISegmentedControl *)seg{
    if (!_seg) {
        _seg =[[UISegmentedControl alloc]initWithItems:self.titleArray];
        [_seg addTarget:self action:@selector(titleSegChanged:) forControlEvents:UIControlEventValueChanged];
        _seg.frame =  CGRectMake(0, 20, SCREENWIDTH, XZFS_STATUS_BAR_H-22);
        _seg.tintColor=XZFS_NAVICOLOR;
        _seg.backgroundColor = XZFS_NAVICOLOR;
        NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                 NSForegroundColorAttributeName: XZFS_TEXTORANGECOLOR};
        
        [_seg setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                   NSForegroundColorAttributeName: XZFS_TEXTLIGHTGRAYCOLOR};
        [_seg setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        _seg.selectedSegmentIndex=0;
    }
    return _seg;

}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, XZFS_STATUS_BAR_H-1, SCREENWIDTH/3, 2)];
        _lineView.backgroundColor = XZFS_HEX_RGB(@"#eb6000");
    }
    return _lineView;
}

-(UIScrollView *)scroll{
    if (!_scroll) {
        _scroll = [[UIScrollView alloc]init];
        _scroll.delegate = self;
        _scroll.pagingEnabled = YES;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.backgroundColor = [UIColor clearColor];
    }
    return _scroll;
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
