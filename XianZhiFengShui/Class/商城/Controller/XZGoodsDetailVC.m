//
//  XZGoodsDetailVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZGoodsDetailVC.h"
#import "UIButton+XZImageTitleSpacing.h"
#import "XZOrderDetailVC.h"
#import "WTShareManager.h"
#import "WTShareContentItem.h"


@interface XZGoodsDetailVC ()
@property (nonatomic,strong)NSString * goodsId;
@property (nonatomic,strong)UIWebView * infoWeb;
@end

@implementation XZGoodsDetailVC{
    UIView * bottomView ;
}

- (instancetype)initWithGoodsId:(NSString*)goodsId
{
    self = [super init];
    if (self) {
        _goodsId = goodsId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"宝贝详情";
    [self setupNavi];
    [self setupWeb];
    [self setupBottom];
}

-(void)setupNavi{
    [self.rightButton setImage:XZFS_IMAGE_NAMED(@"fenxiang") forState:UIControlStateNormal];
}

-(void)setupWeb{
    self.infoWeb = [[UIWebView alloc]initWithFrame:CGRectMake(20, 4, SCREENWIDTH-40, XZFS_MainView_H-4-50)];
    self.infoWeb.backgroundColor = [UIColor redColor];
    [self.mainView addSubview:self.infoWeb];
}

-(void)setupBottom{
     bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, XZFS_MainView_H-50, SCREENWIDTH, 50);
    [self.mainView addSubview:bottomView];
    
    NSArray * normalTitles = @[@"收藏",@"加入购物车"];
    NSArray * selectTitles = @[@"已收藏",@"加入购物车"];
    NSArray * normalImages = @[@"weishoucang",@"gouwuche_big"];
    NSArray * selectImages = @[@"yishoucang",@"gouwuche_big"];
    for (int i = 0; i<normalTitles.count; i++) {
        UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(i*(SCREENWIDTH/4), 9, SCREENWIDTH/4, 32);
        [leftBtn setImage:XZFS_IMAGE_NAMED(normalImages[i]) forState:UIControlStateNormal];
        [leftBtn setImage:XZFS_IMAGE_NAMED(selectImages[i]) forState:UIControlStateSelected];
        [leftBtn setTitle:normalTitles[i] forState:UIControlStateNormal];
        [leftBtn setTitle:selectTitles[i] forState:UIControlStateSelected];
        [leftBtn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
        leftBtn.titleLabel.font = XZFS_S_FONT(12);
        [leftBtn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleTop imageTitleSpace:4];
        [bottomView addSubview:leftBtn];
        [leftBtn addTarget:self action:@selector(clickBottomBtn:) forControlEvents:UIControlEventTouchUpInside];
        leftBtn.tag = 100+i;
    }
    
    UIButton  *buyNowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyNowBtn.frame = CGRectMake(SCREENWIDTH/2, 0, SCREENWIDTH/2, 50);
    [buyNowBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyNowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buyNowBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
    buyNowBtn.titleLabel.font = XZFS_S_FONT(18);
    [bottomView addSubview:buyNowBtn];
    [buyNowBtn addTarget:self action:@selector(buynow:) forControlEvents:UIControlEventTouchUpInside];
    
 }

#pragma mark action

-(void)clickRightButton{
    NSLog(@"分享");
    UIButton * sender;
    if (sender.tag == WTShareTypeWeiBo) {
        
        [WTShareManager wt_shareWithContent:[WTShareContentItem shareWTShareContentItem] shareType:WTShareTypeWeiBo shareResult:^(NSString *shareResult) {
            NSLog(@"🐒🐒🐒🐒🐒🐒---%@", shareResult);
        }];
        
    }else if (sender.tag == WTShareTypeQQ){
        [WTShareManager wt_shareWithContent:[WTShareContentItem shareWTShareContentItem] shareType:WTShareTypeQQ shareResult:^(NSString *shareResult) {
            NSLog(@"🐒🐒🐒🐒🐒🐒---%@", shareResult);
        }];
    }else if (sender.tag == WTShareTypeQQZone){
        [WTShareManager wt_shareWithContent:[WTShareContentItem shareWTShareContentItem] shareType:WTShareTypeQQZone shareResult:^(NSString *shareResult) {
            NSLog(@"🐒🐒🐒🐒🐒🐒---%@", shareResult);
        }];
    }else if (sender.tag == WTShareTypeWeiXinTimeline){
        [WTShareManager wt_shareWithContent:[WTShareContentItem shareWTShareContentItem] shareType:WTShareTypeWeiXinTimeline shareResult:^(NSString *shareResult) {
            NSLog(@"🐒🐒🐒🐒🐒🐒---%@", shareResult);
        }];
    }else if (sender.tag == WTShareTypeWeiXinSession){
        [WTShareManager wt_shareWithContent:[WTShareContentItem shareWTShareContentItem] shareType:WTShareTypeWeiXinSession shareResult:^(NSString *shareResult) {
            NSLog(@"🐒🐒🐒🐒🐒🐒---%@", shareResult);
        }];
    }else if (sender.tag == WTShareTypeWeiXinFavorite){
        [WTShareManager wt_shareWithContent:[WTShareContentItem shareWTShareContentItem] shareType:WTShareTypeWeiXinFavorite shareResult:^(NSString *shareResult) {
            NSLog(@"🐒🐒🐒🐒🐒🐒---%@", shareResult);
        }];
    }

    
}

-(void)clickBottomBtn:(UIButton*)sender{
    if (sender.tag==100) {
        sender.selected = !sender.selected;
        NSLog(@"收藏");
    }else{
        NSLog(@"加入购物车");
    }
    
}
-(void)buynow:(UIButton*)sender{
    XZOrderDetailVC * orderDetailvc = [[XZOrderDetailVC alloc]init];
    [self.navigationController pushViewController:orderDetailvc animated:YES];
    NSLog(@"立即购买");
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
