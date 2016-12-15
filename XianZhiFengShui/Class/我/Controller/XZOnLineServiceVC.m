//
//  XZOnLineServiceVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/7.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZOnLineServiceVC.h"
#import "UIButton+XZImageTitleSpacing.h"
@interface XZOnLineServiceVC ()

@end

@implementation XZOnLineServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"客服电话";
    [self setupView];
    // Do any additional setup after loading the view.
}
-(void)setupView{
    UILabel * tipLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 28, 300, 14)];
    tipLab.textColor = XZFS_HEX_RGB(@"#C2C3C4");
    tipLab.font = XZFS_S_FONT(14);
    tipLab.text  =@"客服电话（工作日9：00-17：00）";
    [self.mainView addSubview:tipLab];
    
    UIButton * dailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dailBtn.frame = CGRectMake(0, tipLab.bottom+30, SCREENWIDTH, 30);
    [dailBtn setTitle:@"010-57128702" forState:UIControlStateNormal];
    [dailBtn setTitleColor:XZFS_HEX_RGB(@"#9AD569") forState:UIControlStateNormal];
    [dailBtn setImage:XZFS_IMAGE_NAMED(@"kefu") forState:UIControlStateNormal];
    [dailBtn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:25];
    [dailBtn addTarget:self action:@selector(dailService) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:dailBtn];
}

-(void)dailService{
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:010-57128702"]];
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
