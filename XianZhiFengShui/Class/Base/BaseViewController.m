//
//  BaseViewController.m
//  ShaGuaLiCai
//
//  Created by yangshangjie on 14-12-16.
//  Copyright (c) 2014年 YangShangJie. All rights reserved.
//

#import "BaseViewController.h"
#import "AFShareClass.h"
#import "Custom_tabbar.h"
#import "IQKeyboardReturnKeyHandler.h"

@interface BaseViewController ()
@property (nonatomic, strong) IQKeyboardReturnKeyHandler    *returnKeyHandler;
@end

@implementation BaseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
//    BasicService * basic = [BasicService sharedService];
//    basic.delegate =self;
    [self makeNav];
    
    
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    
  
}

-(void)makeNav{
    
//    [self.navigationController.navigationBar addSubview:self.navView];

    [self.view addSubview:self.navView];
    [self.navView addSubview:self.leftButton];
    [self.navView addSubview:self.rightButton];
    [self.navView addSubview:self.titelLab];
    [self.navView addSubview:self.baseLineView];
    [self.view addSubview:self.mainView];
    [self.leftButton addSubview:self.leftImageView];
    [self.rightButton addSubview:self.rightImageView];
    [self.navView addSubview:self.rightTitleBtn];
    self.rightTitleBtn.hidden = YES;
}

-(void)viewDidLayoutSubviews{
    
    self.navView.frame =CGRectMake(0, 0, SCREENWIDTH, XZFS_STATUS_BAR_H);
    self.leftButton.frame = CGRectMake(0, 0, 80, 60);
//     self.rightButton.frame = CGRectMake(SCREENWIDTH-80, 0, 80, 60); // 2016-08-18 LF 因为要在rightBtn前面加个按钮
    self.rightButton.frame = CGRectMake(SCREENWIDTH-50, 20, 50, 44);
    self.rightTitleBtn.frame = CGRectMake(SCREENWIDTH-80, 20, 80, 44);
    self.baseLineView.frame =CGRectMake(0, self.navView.bottom-0.5, SCREENWIDTH, 0.5);
    self.mainView.frame = CGRectMake(0, XZFS_STATUS_BAR_H, SCREENWIDTH, SCREENHEIGHT-XZFS_STATUS_BAR_H);
    self.titelLab.frame =CGRectMake(0, 30, SCREENWIDTH, 20);
    self.leftImageView.frame  = CGRectMake(18, 24, 30, 30);
    self.rightImageView.frame  = CGRectMake(15,22 , 37, 37);
    
}
- (void)setNavibarShadowHidden:(BOOL)hidden {
    self.baseLineView.hidden = hidden;
}
#pragma mark 点击事件
-(void)clickLeftButton{

    
}

-(void)clickRightButton{
    
}

#pragma mark get 方法
-(UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc]init];
        
        _navView.userInteractionEnabled = YES;
        _navView.backgroundColor = XZFS_NAVICOLOR;
    }
    return _navView;
}



-(UIView *)baseLineView{
    if (!_baseLineView) {
        _baseLineView = [[UIView alloc]init];
        _baseLineView.backgroundColor = XZFS_HEX_RGB(@"#C9C9CA");
    }
    return _baseLineView;
}

-(UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc]init];
        _mainView.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
        _mainView.userInteractionEnabled = YES;
    }
    return _mainView;
}

-(UILabel *)titelLab{
    if (!_titelLab) {
        _titelLab = [[UILabel alloc]init];
        _titelLab.textAlignment = NSTextAlignmentCenter;
//        _titelLab.font = SGLC_FONT(@"FZLanTingHeiS-L-GB", 18);
        _titelLab.font = XZFS_S_FONT(18);
        _titelLab.text = self.titleLabText;
        _titelLab.textColor =XZFS_NAVITITLECOLOR;
        
    }
    return _titelLab;
}

-(UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setBackgroundColor:[UIColor clearColor]];
        _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _leftButton.titleLabel.font = XZFS_S_FONT(14);
        _leftButton.contentEdgeInsets = UIEdgeInsetsMake(0,19, -25, 0);
//        _leftButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [_leftButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
        [_leftButton setImage:XZFS_IMAGE_NAMED(@"zuojiantou") forState:UIControlStateNormal];
    }
    return _leftButton;
}
-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setBackgroundColor:[UIColor clearColor]];
//        _rightButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        _rightButton.titleLabel.font = XZFS_S_FONT(14);
//        _rightButton.contentEdgeInsets = UIEdgeInsetsMake(0,0, -25, 19);// 2016-08-18 LF
        _rightButton.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 16);
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

-(UIButton *)rightTitleBtn{
    if (!_rightTitleBtn) {
        _rightTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightTitleBtn.titleLabel.font =  XZFS_S_FONT(14);
        [_rightTitleBtn addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightTitleBtn;

}
-(UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]init];
        _leftImageView.backgroundColor = [UIColor clearColor];
        _leftImageView.layer.masksToBounds = YES;
        _leftImageView.layer.cornerRadius = 15;
    }
    return _leftImageView;
}

-(UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]init];
        _rightImageView.backgroundColor = [UIColor clearColor];
    }
    return _rightImageView;
}



-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
