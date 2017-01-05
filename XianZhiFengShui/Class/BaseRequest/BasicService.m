//
//  BasicService.m
//  ShaGuaLiCai
//
//  Created by 李清娟 on 15/12/22.
//  Copyright © 2015年 傻瓜理财. All rights reserved.
//

#import "BasicService.h"
#import "AFShareClass.h"
#import "Reachability.h"
#import "UIView+Toast.h"
#import "MBProgressHUD.h"
#import "NSString+MD5Addition.h"

@implementation BasicService
static BasicService * shareService;

+(BasicService*)sharedService{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareService = [[self alloc]init ];
    });

    return shareService;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _isShowNetErrToast = YES;
    }
    return self;
}

- (instancetype)initWithServiceTag:(int)tag{
    self = [super init];
    if (self) {
        _serviceTag = tag;
    }
    return self;
}

#pragma mark  公共参数
-(NSMutableDictionary*)getCommonDictionary{

    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithCapacity:0];
//    [mDict setObject:@"110000" forKey:@"cityCode"];
    [mDict setObject:@"ios" forKey:@"deviceType"];
//    UIDevice *device = [UIDevice currentDevice];
//    NSString *deviceName = [device model];
    //以下注释是获取UUID的方法
    //当前使用的imei字段，使用的是根据mac地址加密生成的设备唯一标识，此方案允许用户删除应用程序、重装后，仍然保持设备标识不变。
    //    NSLog(@"device name is %@", deviceName);
    //
    //    NSLog(@"UUID is %@",[QMCNet getUUID]);
    //    NSLog(@"DEVICE identifier %@",[[UIDevice currentDevice] uniqueDeviceIdentifier]);       //MAC和CFBundleIdentifiler的MD5值
    //    NSLog(@"Global identifier %@",[[UIDevice currentDevice] uniqueGlobalDeviceIdentifier]); //MAC的MD5值

    //这里可能需要判断一下IOS的版本，是否IOS7
//    if(QMC_ISHighIOS7){
//        NSLog(@"\n\n\n使用uuid idfa作为imei\n\n");
//        [mDict setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"imei"];
//    }else{
//        NSLog(@"\n\n\n使用mac加密作为imei\n\n");
//        [mDict setObject:[[UIDevice currentDevice] uniqueGlobalDeviceIdentifier]  forKey:@"imei"];
//    }
//    NSLog(@"\n\n\n最终使用的imei——%@\n\n\n",[mDict objectForKey:@"imei"]);
    return mDict;
}

#pragma mark 数据处理
//数据加密
-(NSDictionary*)dataEncryptionWithDic:(NSDictionary*)dic{
    NSMutableDictionary * lastDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [lastDic setObject:@"ios" forKey:@"deviceType"];
    NSLog(@"lastDic = %@",lastDic);
     NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:lastDic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    NSString * paras =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSString * json = [DES3Util encryptUseDES:paras key:@"tbframew"] ;
    NSString * sign = [paras stringFromMD5];
//    NSDictionary * lastDic = @{@"json":paras,@"sign":sign};
     NSLog(@"数据加个密");
    return @{@"json":paras};

   
//    return lastDic;
}

//数据解密
-(NSDictionary*)dataDecryptionWithDic:(NSDictionary*)dic{
     NSLog(@"数据解个密");
  
    return dic;
}

#pragma mark  get请求
- (void)getRequestWithUrl:(NSString *)url parmater:(NSDictionary *)requestData view:(UIView*)currentView  isOpenHUD:(BOOL)isOpenHUD  Block:(void (^)(NSData *data))block failBlock:(void (^)(NSError *error))errorBlock
{
//    NSMutableDictionary *mDict = [self getCommonDictionaryWithHaveAuthKey:isHaveAuthkey];
    NSMutableDictionary * mDict = [NSMutableDictionary dictionary];
    [mDict addEntriesFromDictionary:requestData];  //在通用数据后附加本次请求的数据
    if ([self isNetWorkConnectionAvailable]) {
        AFShareClass * afShare = [AFShareClass sharedClient];
        
        if (isOpenHUD) {
            [BasicService startActivityWithView:currentView];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//            currentView.hidden= NO;
        }
        [afShare GET:url parameters:mDict progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            block(responseObject);
            if (isOpenHUD == YES) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [BasicService stopActivityWithView:currentView];
            }
            [BasicService stopActivityWithView:currentView];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
            if (isOpenHUD == YES) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [BasicService stopActivityWithView:currentView];
                //                currentView.hidden = YES;
            }
            [BasicService stopActivityWithView:currentView];

        }];
        
    } else {
//        currentView.hidden = YES;
        NSLog(@"BasicService GET 判断无网络 [%@]", url);
        if (_isShowNetErrToast) {
            CGPoint pt = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2);
            NSValue *nspt = [NSValue valueWithCGPoint:pt];
    //        [currentView makeToast:ToastMSG_NetworkErr duration:3.0f position:nspt];
            [ToastManager showToastOnView:currentView position:nspt flag:NO message:ToastMSG_NetworkErr];
        }
        errorBlock(nil);
    }
}

#pragma mark post 请求

- (void)postRequestWithUrl:(NSString *)url parmater:(NSDictionary *)requestData view:(UIView*)currentView isOpenHUD:(BOOL)isOpenHUD  Block:(void (^)(NSDictionary *data))block failBlock:(void (^)(NSError *error))errorBlock
{
    NSMutableDictionary *mDict = [self getCommonDictionary];
    [mDict addEntriesFromDictionary:requestData];  //在通用数据后附加本次请求的数据
    if ([self isNetWorkConnectionAvailable]) {
        AFShareClass * afShare = [AFShareClass sharedClient];
        if (isOpenHUD) {
            [BasicService startActivityWithView:currentView];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//            currentView.hidden= NO;
        }
        [afShare POST:url parameters:mDict progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary * resultDic = [self dataDecryptionWithDic:dic];
           BOOL isSuccess =  [self showFailInfoWithDic:resultDic view:currentView];
            if (isSuccess) {
                block(resultDic);
            }else{
                NSError *error;
                errorBlock(error);
            }
            if (isOpenHUD == YES) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [BasicService stopActivityWithView:currentView];
                //                currentView.hidden = YES;
            }
            [BasicService stopActivityWithView:currentView];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
            if (isOpenHUD == YES) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [BasicService stopActivityWithView:currentView];
                //                currentView.hidden = YES;
            }
            NSLog(@"error 内容 = %@",error);
            [BasicService stopActivityWithView:currentView];
            UIViewController * vc = (UIViewController*)[self getCurrentVC];
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:[error.userInfo objectForKey:@"NSLocalizedDescription" ] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            [alert addAction:defaultAction];
            [vc presentViewController:alert animated:true completion:^{
                
            }];

        }];
    } else {
        NSLog(@"BasicService POS 判断无网络 [%@]", url);
        if (_isShowNetErrToast) {
            CGPoint pt = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2);
            NSValue *nspt = [NSValue valueWithCGPoint:pt];
            //        [currentView makeToast:ToastMSG_NetworkErr duration:3.0f position:nspt];
            [ToastManager showToastOnView:currentView position:nspt flag:NO message:ToastMSG_NetworkErr];
        }
        errorBlock(nil);
    }
}



#pragma mark 上传单文件

- (void)postAddFileWithUrl:(NSString *)url parmater:(NSDictionary *)requestData fileName:(NSString *)fileName fileData:(NSData *)fileData view:(UIView*)currentView isOpenHUD:(BOOL)isOpenHUD  Block:(void (^)(NSDictionary *data))block failBlock:(void (^)(NSError *error))errorBlock{
    NSMutableDictionary *mDict = [self getCommonDictionary];
    [mDict addEntriesFromDictionary:requestData];  //在通用数据后附加本次请求的数据
    if ([self isNetWorkConnectionAvailable]) {
        AFShareClass * afShare = [AFShareClass sharedClient];
        if (isOpenHUD) {
            [BasicService startActivityWithView:currentView];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
        [afShare POST:url parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:fileData name:fileName fileName:@"picture.png" mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary * resultDic = [self dataDecryptionWithDic:dic];
            BOOL isSuccess =  [self showFailInfoWithDic:resultDic view:currentView];
            if (isSuccess) {
                block(resultDic);
            }else{
                NSError *error;
                errorBlock(error);
            }
            if (isOpenHUD == YES) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [BasicService stopActivityWithView:currentView];
                //                currentView.hidden = YES;
            }
            [BasicService stopActivityWithView:currentView];

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
            if (isOpenHUD == YES) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [BasicService stopActivityWithView:currentView];
                //                currentView.hidden = YES;
            }
            NSLog(@"error 内容 = %@",error);
            [BasicService stopActivityWithView:currentView];
            UIViewController * vc = (UIViewController*)[self getCurrentVC];
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:[error.userInfo objectForKey:@"NSLocalizedDescription" ] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            [alert addAction:defaultAction];
            [vc presentViewController:alert animated:true completion:^{
                
            }];
        }];
    } else {
        NSLog(@"BasicService POS 判断无网络 [%@]", url);
        if (_isShowNetErrToast) {
            CGPoint pt = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2);
            NSValue *nspt = [NSValue valueWithCGPoint:pt];
            //        [currentView makeToast:ToastMSG_NetworkErr duration:3.0f position:nspt];
            [ToastManager showToastOnView:currentView position:nspt flag:NO message:ToastMSG_NetworkErr];
        }
        errorBlock(nil);
    }
}

#pragma mark 上传文件名相同的多文件

- (void)postAddFiles:(NSString *)URLString parameters:(NSDictionary *)parameters fileName:(NSString *)fileName fileDatas:(NSArray *)fileDatas  view:(UIView*)currentView isOpenHUD:(BOOL)isOpenHUD  Block:(void (^)(NSDictionary *data))block failBlock:(void (^)(NSError *error))errorBlock{
    NSMutableDictionary *mDict = [self getCommonDictionary];
    [mDict addEntriesFromDictionary:parameters];  //在通用数据后附加本次请求的数据
    if ([self isNetWorkConnectionAvailable]) {
        AFShareClass * afShare = [AFShareClass sharedClient];
        if (isOpenHUD) {
            [BasicService startActivityWithView:currentView];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
        [afShare POST:URLString parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (int i=0; i<fileDatas.count; i++) {
                NSString *imageName = [NSString stringWithFormat:@"%@[%i]", fileName, i];
                [formData appendPartWithFileData:fileDatas[i] name:imageName fileName:imageName mimeType:@"image/png"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary * resultDic = [self dataDecryptionWithDic:dic];
            BOOL isSuccess =  [self showFailInfoWithDic:resultDic view:currentView];
            if (isSuccess) {
                block(resultDic);
            }else{
                NSError *error;
                errorBlock(error);
            }
            if (isOpenHUD == YES) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [BasicService stopActivityWithView:currentView];
                //                currentView.hidden = YES;
            }
            [BasicService stopActivityWithView:currentView];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
            if (isOpenHUD == YES) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [BasicService stopActivityWithView:currentView];
                //                currentView.hidden = YES;
            }
            NSLog(@"error 内容 = %@",error);
            [BasicService stopActivityWithView:currentView];
            UIViewController * vc = (UIViewController*)[self getCurrentVC];
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:[error.userInfo objectForKey:@"NSLocalizedDescription" ] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            [alert addAction:defaultAction];
            [vc presentViewController:alert animated:true completion:^{
                
            }];
        }];
    } else {
        NSLog(@"BasicService POS 判断无网络 [%@]",URLString );
        if (_isShowNetErrToast) {
            CGPoint pt = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2);
            NSValue *nspt = [NSValue valueWithCGPoint:pt];
            //        [currentView makeToast:ToastMSG_NetworkErr duration:3.0f position:nspt];
            [ToastManager showToastOnView:currentView position:nspt flag:NO message:ToastMSG_NetworkErr];
        }
        errorBlock(nil);
    }

}

#pragma mark 上传文件名不同 的 多文件

- (void)postAddWithFiles:(NSString *)URLString parameters:(NSDictionary *)parameters fileNames:(NSArray *)fileNames fileDatas:(NSArray *)fileDatas view:(UIView*)currentView isOpenHUD:(BOOL)isOpenHUD  Block:(void (^)(NSDictionary *data))block failBlock:(void (^)(NSError *error))errorBlock{
    NSMutableDictionary *mDict = [self getCommonDictionary];
    [mDict addEntriesFromDictionary:parameters];  //在通用数据后附加本次请求的数据
    if ([self isNetWorkConnectionAvailable]) {
        AFShareClass * afShare = [AFShareClass sharedClient];
        if (isOpenHUD) {
            [BasicService startActivityWithView:currentView];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
        [afShare POST:URLString parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (int i=0; i<fileDatas.count; i++) {
                [formData appendPartWithFileData:fileDatas[i] name:fileNames[i] fileName:fileNames[i] mimeType:@"image/png"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary * resultDic = [self dataDecryptionWithDic:dic];
            BOOL isSuccess =  [self showFailInfoWithDic:resultDic view:currentView];
            if (isSuccess) {
                block(resultDic);
            }else{
                NSError *error;
                errorBlock(error);
            }
            if (isOpenHUD == YES) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [BasicService stopActivityWithView:currentView];
                //                currentView.hidden = YES;
            }
            [BasicService stopActivityWithView:currentView];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
            if (isOpenHUD == YES) {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [BasicService stopActivityWithView:currentView];
                //                currentView.hidden = YES;
            }
            NSLog(@"error 内容 = %@",error);
            [BasicService stopActivityWithView:currentView];
            UIViewController * vc = (UIViewController*)[self getCurrentVC];
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:[error.userInfo objectForKey:@"NSLocalizedDescription" ] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            [alert addAction:defaultAction];
            [vc presentViewController:alert animated:true completion:^{
                
            }];
        }];
    } else {
        NSLog(@"BasicService POS 判断无网络 [%@]",URLString );
        if (_isShowNetErrToast) {
            CGPoint pt = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2);
            NSValue *nspt = [NSValue valueWithCGPoint:pt];
            //        [currentView makeToast:ToastMSG_NetworkErr duration:3.0f position:nspt];
            [ToastManager showToastOnView:currentView position:nspt flag:NO message:ToastMSG_NetworkErr];
        }
        errorBlock(nil);
    }

  
 
}


#pragma mark  判断网络
- (BOOL)isNetWorkConnectionAvailable
{
    BOOL isExistenceNetwork = YES;

    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    
    
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown          = -1,
         AFNetworkReachabilityStatusNotReachable     = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G|4G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                break;
            default:
                break;
        }
    }];
    
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            
            break;
    }
    return isExistenceNetwork;
}

#pragma mark 获取当前vc
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWindow in windows)
        {
            if (tmpWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWindow;
                break;
            }
        }
    }
    
    UIView *forntView = [[window subviews]objectAtIndex:0];
    id nextResponder = [forntView nextResponder];
    if ([nextResponder isMemberOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


#pragma hud显示及消失

+ (void)startActivityWithView:(id)view{
    UIView * currentView = (UIView*)view;
    MBProgressHUD * mbd = [MBProgressHUD showHUDAddedTo:currentView animated:YES];
    mbd.opacity = 0;
    
    mbd.mode = MBProgressHUDModeCustomView;

    mbd.label.text = @"加载中";
    

//    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 34, 16)];
//    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=12; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%02lu", (unsigned long)i]];
//        [refreshingImages addObject:image];
//    }
//    gifImageView.animationImages = refreshingImages; //动画图片数组
//    gifImageView.animationDuration = 12*0.1; //执行一次完整动画所需的时长
//    gifImageView.animationRepeatCount = 0;  //动画重复次数
//    [gifImageView startAnimating];
//    mbd.customView = gifImageView;
  
}

+(void)stopActivityWithView:(id)view{
    UIView * currentView = (UIView*)view;
    [MBProgressHUD hideHUDForView:currentView animated:YES];


}

-(BOOL)showFailInfoWithDic:(NSDictionary*)dic view:(id)view{
    if ([[dic objectForKey:@"statusCode"]intValue]!=200 ) {
        [ToastManager showToastOnView:view position:CSToastPositionCenter flag:NO message:[dic objectForKey:@"status"]];
        return NO;
    }
    return YES;
}


@end
