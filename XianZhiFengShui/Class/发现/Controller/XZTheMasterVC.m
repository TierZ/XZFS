//
//  XZTheMasterVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/3/14.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZTheMasterVC.h"
#import "XZTheMasterView.h"
@interface XZTheMasterVC ()
@property (nonatomic,strong)XZTheMasterView * mastView;//大师

@end

@implementation XZTheMasterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mastView = [[XZTheMasterView alloc]initWithFrame:self.view.bounds curVC:self];
    [self.view addSubview:self.mastView];
    self.mastView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0,0,0,0));
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
