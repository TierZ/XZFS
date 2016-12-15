//
//  XZCertifyPhoneVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/6.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZCertifyPhoneVC.h"

@interface XZCertifyPhoneVC ()

@end

@implementation XZCertifyPhoneVC{
    NSString * _phoneNum;
    UIView * _certifyView;
}

- (instancetype)initWithPhoneNum:(NSString*)phoneNum
{
    self = [super init];
    if (self) {
        _phoneNum = phoneNum;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)setupCertifyView{
    _certifyView = [[UIView alloc]initWithFrame:CGRectMake(0, 8, SCREENWIDTH, 115)];
    _certifyView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:_certifyView];
    
    UILabel * sendLab = [[UILabel alloc]initWithFrame:CGRectMake(25, 10, _certifyView.width-50, 100)];
    sendLab.textColor = XZFS_TEXTLIGHTGRAYCOLOR;
    sendLab.font = XZFS_S_FONT(14);
//    NSMutableAttributedString * att = [NSMutableAttributedString alloc]initWithString:<#(nonnull NSString *)#>
    
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
