//
//  FPSUtil.m
//  NormalProject
//
//  Created by shagualicai on 2016/11/25.
//  Copyright © 2016年 BAT. All rights reserved.
//

#import "FPSUtil.h"
#import "YYFPSLabel.h"
@interface FPSUtil ()
@property (nonatomic, strong) YYFPSLabel *toolbar;
@end
@implementation FPSUtil
static FPSUtil *instance = nil;
+ (FPSUtil *)sharedFPSUtil {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FPSUtil alloc] init];
    });
    return instance;
}
- (instancetype)init {
    if (self = [super init]) {
        // 这里往往放一些要初始化的变量，比如单例对象具有一个字典属性，那么就要在此处初始化
    };
    return self;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized(self) {
        instance = [super allocWithZone:zone];
    }
    return instance;
}
- (id)copyWithZone:(NSZone *)zone {
    return self;
}
- (id)copy {
    return self;
}

+ (void)showFPS {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *fpsView = [FPSUtil sharedFPSUtil].toolbar;
    fpsView.bottom = window.height - 51;
    [window addSubview:fpsView];
    [window bringSubviewToFront:fpsView];
}
+ (void)hideFPS {
    UIView *fpsView = [FPSUtil sharedFPSUtil].toolbar;
    [fpsView removeFromSuperview];
}
- (YYFPSLabel *)toolbar {
    if (!_toolbar) {
        _toolbar = [YYFPSLabel new];
        _toolbar.frame = CGRectMake(2, 0, 60, 30);
    }
    return _toolbar;
}
@end
