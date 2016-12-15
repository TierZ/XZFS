//
//  BaseContentController.m
//  ShaGuaLiCai
//
//  Created by 李清娟 on 15/12/16.
//  Copyright © 2015年 傻瓜理财. All rights reserved.
//

#import "BaseContentController.h"



#import "Appdelegate.h"

@interface BaseContentController ()
@end

@implementation BaseContentController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.leftButton setTitle:@"" forState:UIControlStateNormal];
     
    [[Custom_tabbar showTabBar]hideTabBar:YES];
    
//    int i = 0;
//    for (foo('A'); foo('B')&&(i<2); foo('C')) {
//        i++;
//        NSLog(@"i==%d",i);
//        foo('D');
//    }

    
    // Do any additional setup after loading the view.
}

//int foo(char c){
//    printf("--%c",c);
//    return -1;
//}

/**
 *  idx 从右起第idx位置,无非就0/1
 */
//- (void)createNaviMsgBtn:(NSInteger)idx {
//    // navi右边消息按钮 并监听
//    _naviMsgBtn = [[SGLCButton alloc] init];
//    _naviMsgBtn.backgroundColor = [UIColor clearColor];
//    [_naviMsgBtn setImage:[UIImage imageNamed:@"living_news_icon_news"] forState:UIControlStateNormal];
//    [_naviMsgBtn addTarget:self action:@selector(naviMsgBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.navView addSubview:_naviMsgBtn];
//    if (!idx) {
//        _naviMsgBtn.frame = CGRectMake(SCREENWIDTH-50, 20, 50, 44);
//        _naviMsgBtn.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
//        self.rightButton.hidden = YES;
//    } else {
//        _naviMsgBtn.frame = CGRectMake(SCREENWIDTH - 80, 20, 40, 44);
//        _naviMsgBtn.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, -16);
//    }
//    // 检查当前badge
//    
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    UITabBarController *tbVC = app.custom_tabbar;
//    UINavigationController *liveNaviVC = [tbVC.viewControllers objectAtIndex:1];
//    NSString *currentBadge = liveNaviVC.tabBarItem.badgeValue;
//    if (currentBadge) {
//        self.naviMsgBtn.pointHidden = NO;
//    }
//    // 注册新消息的提醒
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(naviMsgBtnDidReceiveNoti:) name:m_naviMsgBtnNeedShowRemind object:nil];
//}
//- (void)naviMsgBtnDidReceiveNoti:(NSNotification *)noti {
//    self.naviMsgBtn.pointHidden = NO;
//}
//- (void)naviMsgBtnDidClick:(UIButton *)sender {
//    
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    UITabBarController *tbVC = app.custom_tabbar;
//
//    [self.navigationController popToRootViewControllerAnimated:NO];
//
//    [tbVC setSelectedIndex:1];
//    UINavigationController *liveNaviVC = [tbVC.viewControllers objectAtIndex:1];
//
//    UIViewController *liveVC = liveNaviVC.topViewController;
//    if ([liveVC isKindOfClass:[LiveBroadCastController class]] ) {
//        LiveBroadCastController *vc = (LiveBroadCastController *)liveVC;
//        [vc setTitleSegSelectIndex:0 style:0];
//    } else {
//        
//    }
//}
/**
 *  end
 */
-(void)clickLeftButton{
  [super clickLeftButton];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    NSLog(@"--- [%@] dealloc <BaseContentController show>---",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
