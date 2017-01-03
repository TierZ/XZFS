//
//  BaseLoginController.m
//  ShaGuaLiCai
//
//  Created by 李清娟 on 15/12/16.
//  Copyright © 2015年 傻瓜理财. All rights reserved.
//

#import "BaseLoginController.h"
#import "XZLoginVC.h"
#import "Custom_tabbar.h"

@interface BaseLoginController ()

@end

@implementation BaseLoginController

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary * userDic =GETUserdefault(@"userInfos");
        self.isUserLogin = [KISDictionaryHaveKey(userDic, @"isLogin")boolValue];
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
 }


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.leftButton setTitle:@"" forState:UIControlStateNormal];
    [[Custom_tabbar showTabBar]hideTabBar:YES];

   


    
}


-(void)clickLeftButton{
    [super clickLeftButton];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    NSLog(@"====baseLoginDealloc ===%@",NSStringFromClass([self class]));
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
