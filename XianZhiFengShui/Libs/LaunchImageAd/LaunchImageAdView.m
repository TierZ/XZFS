//
//  LBLaunchImageAdView.m
//  LBLaunchImageAd
//
//  Created by 李清娟 on 16/4/21.
//  Copyright © 2016年 傻瓜理财. All rights reserved.
//


#import "LaunchImageAdView.h"

@interface LaunchImageAdView()
{
    NSTimer *countDownTimer;
}
@property (strong, nonatomic) NSString *isClick;
@end

@implementation LaunchImageAdView

- (instancetype)initWithWindow:(UIWindow *)window andType:(NSInteger)type andImgUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        self.window = window;
        _adTime = 3;
        [window makeKeyAndVisible];
        //获取启动图片
        CGSize viewSize = window.bounds.size;
        //横屏请设置成 @"Landscape"
        NSString *viewOrientation = @"Portrait";
        
        NSString *launchImageName = nil;
        
        NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
        for (NSDictionary* dict in imagesDict)
        {
            CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
            if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
            {
                launchImageName = dict[@"UILaunchImageName"];
            }
        }
        UIImage * launchImage = [UIImage imageNamed:launchImageName];
        self.backgroundColor = [UIColor colorWithPatternImage:launchImage];
        self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        if (type == FullScreenAdType) {
            self.aDImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
            
        }else{
            //暂时没定 宽高，先不做
//            self.aDImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - SCREENWIDTH/3)];
        }
        
//        self.skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.skipBtn.frame = CGRectMake(SCREENWIDTH - 70, 20, 60, 30);
//        self.skipBtn.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.6];
//        [self.skipBtn setTitle:@"跳过广告" forState:UIControlStateNormal];
//        self.skipBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        self.skipBtn.layer.masksToBounds = YES;
//        self.skipBtn.layer.cornerRadius = 4;
//        
//        [self.skipBtn addTarget:self action:@selector(skipBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.aDImgView addSubview:self.skipBtn];
   
        if(url){
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
//            [manager downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//                if (image) {
//                    [self.aDImgView setImage:[self imageCompressForWidth:image targetWidth:SCREENWIDTH]];
//                }
//            }];
        }
        
        self.aDImgView.tag = 1101;
        self.aDImgView.backgroundColor = [UIColor colorWithPatternImage:launchImage];
        [self addSubview:self.aDImgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(activiTap:)];
        // 允许用户交互
        self.aDImgView.userInteractionEnabled = YES;
        [self.aDImgView addGestureRecognizer:tap];
        
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.duration = 1;
        opacityAnimation.fromValue = [NSNumber numberWithFloat:0.0];
        opacityAnimation.toValue = [NSNumber numberWithFloat:1];
        
        opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        [self.aDImgView.layer addAnimation:opacityAnimation forKey:@"animateOpacity"];
        countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
        [self.window addSubview:self];
    }
    return self;
}

#pragma mark - 点击广告
- (void)activiTap:(UITapGestureRecognizer*)recognizer{
    _isClick = @"1";
    [self startcloseAnimation];
}

#pragma mark - 开启关闭动画
- (void)startcloseAnimation{
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 0.5;
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.3];
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    
    [self.aDImgView.layer addAnimation:opacityAnimation forKey:@"animateOpacity"];
    [NSTimer scheduledTimerWithTimeInterval:opacityAnimation.duration
                                     target:self
                                   selector:@selector(closeAddImgAnimation)
                                   userInfo:nil
                                    repeats:NO];
    
}

- (void)skipBtnClick{
    _isClick = @"2";
    [self startcloseAnimation];
}

#pragma mark - 关闭动画完成时处理事件
-(void)closeAddImgAnimation
{
    [countDownTimer invalidate];
    countDownTimer = nil;
    self.hidden = YES;
    self.aDImgView.hidden = YES;
    [self removeFromSuperview];
    if ([_isClick integerValue] == 1) {
        
        if (self.clickBlock) {//点击广告
            self.clickBlock(1100);
        }
    }else if([_isClick integerValue] == 2){
        if (self.clickBlock) {//点击跳过
            self.clickBlock(1101);
        }
    }else{
        if (self.clickBlock) {//点击跳过
            self.clickBlock(1102);
        }
    }
    
   
}

- (void)onTimer {
    _adTime--;
    self.backgroundColor = [UIColor whiteColor];
    if (_adTime == 0) {
        [countDownTimer invalidate];
        countDownTimer = nil;
        [self startcloseAnimation];
        
    }else{
//        [self.skipBtn setTitle:[NSString stringWithFormat:@"%@ | 跳过",@(_adTime--)] forState:UIControlStateNormal];
        
    }
    
}

#pragma mark - 指定宽度按比例缩放
- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    //    UIGraphicsBeginImageContext(size);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)setLocalAdImgName:(NSString *)localAdImgName{
    _localAdImgName = localAdImgName;
    if (_localAdImgName) {
        self.aDImgView.image = [UIImage imageNamed:_localAdImgName];
    }
}

@end
