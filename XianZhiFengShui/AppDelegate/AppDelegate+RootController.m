//
//  AppDelegate+RootController.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/8.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "AppDelegate+RootController.h"
#import "Custom_tabbar.h"
@implementation AppDelegate (RootController)

#pragma mark - 引导页
- (void)createLoadingScrollView
{//引导页
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:self.window.bounds];
    sc.pagingEnabled = YES;
    sc.delegate = self;
    sc.showsHorizontalScrollIndicator = NO;
    sc.showsVerticalScrollIndicator = NO;
    [self.window.rootViewController.view addSubview:sc];
    
    NSArray *arr = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
    for (NSInteger i = 0; i<arr.count; i++)
    {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH*i, 0, SCREENWIDTH, self.window.frame.size.height)];
        img.image = [UIImage imageNamed:arr[i]];
        [sc addSubview:img];
        img.userInteractionEnabled = YES;
        if (i == arr.count - 1)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake((self.window.frame.size.width/2)-50, SCREENHEIGHT-110, 100, 40);
            btn.backgroundColor = [UIColor redColor];
            [btn setTitle:@"开始体验" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(goToMain) forControlEvents:UIControlEventTouchUpInside];
            [img addSubview:btn];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor redColor].CGColor;
        }
    }
    sc.contentSize = CGSizeMake(SCREENWIDTH*arr.count, self.window.frame.size.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x>SCREENWIDTH *4+30)
    {
        [self goToMain];
    }
}

- (void)goToMain
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:@"isOne" forKey:@"isOne"];
    [user synchronize];
    [self setRoot];
    // self.window.rootViewController = self.viewController;
}


- (void)setRootViewController
{
    if ([XZUserDefault objectForKey:@"isOne"] )
    {//不是第一次安装
        [self setRoot];
    }
    else
    {
        UIViewController *emptyView = [[ UIViewController alloc ]init ];
        self. window .rootViewController = emptyView;
        [self createLoadingScrollView];
    }
}

-(void)setRoot{
    Custom_tabbar *tabbarVC = [[ Custom_tabbar alloc ]init ];
    self. window .rootViewController = tabbarVC;
    [self.window makeKeyAndVisible];

}


@end
