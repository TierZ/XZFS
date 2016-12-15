//
//  BaseViewController.h
//  ShaGuaLiCai
//
//  Created by yangshangjie on 14-12-16.
//  Copyright (c) 2014年 YangShangJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicService.h"

@interface BaseViewController : UIViewController<DataReturnDelegate>


@property(nonatomic,copy)NSString *titleLabText;
@property(nonatomic,strong)UIView *navView;
@property(nonatomic,strong)UILabel *titelLab;
@property(nonatomic,strong)UIButton * leftButton;
@property(nonatomic,strong)UIButton * rightButton;
@property(nonatomic,strong)UIButton * rightTitleBtn;
@property(nonatomic,strong)UIImageView * leftImageView;
@property(nonatomic,strong)UIImageView * rightImageView;
@property (nonatomic,strong)UIView * mainView;
@property (nonatomic,strong)UIView * baseLineView;

-(void)clickLeftButton;
-(void)clickRightButton;

- (void)setNavibarShadowHidden:(BOOL)hidden; // add by lf for 是否隐藏navView上面的灰色线条

@end
