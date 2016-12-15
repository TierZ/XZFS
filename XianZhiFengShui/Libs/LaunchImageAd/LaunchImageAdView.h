//
//  LaunchImageAdView.h
//  LaunchImageAd
//
//  Created by 李清娟 on 16/4/21.
//  Copyright © 2016年 傻瓜理财. All rights reserved.
//
typedef enum {
    
    FullScreenAdType = 1,//全屏的广告
    LogoAdType = 0,//带logo的广告
    
}AdType;


#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"


typedef void (^LBClick) (NSInteger tag);
@interface LaunchImageAdView : UIView

@property (strong, nonatomic) UIImageView *aDImgView;
@property (strong, nonatomic) UIWindow *window;
@property (assign, nonatomic) NSInteger adTime; //倒计时总时长,默认6秒
@property (strong, nonatomic) UIButton *skipBtn;
@property (strong, nonatomic) NSString *localAdImgName;//本地图片名字
@property (nonatomic, copy)LBClick clickBlock;

- (instancetype)initWithWindow:(UIWindow *)window andType:(NSInteger)type andImgUrl:(NSString *)url;

@end
