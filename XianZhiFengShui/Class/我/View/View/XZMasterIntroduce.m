//
//  XZMasterIntroduce.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/9.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterIntroduce.h"
#import <AVFoundation/AVFoundation.h>

@interface XZMasterIntroduce ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
}
@end

@implementation XZMasterIntroduce{
    NSMutableArray * tagsSelectedArr;
    NSArray * _tags;
    UIView * tagV ;
    UIButton * uploadSelfPhotoBtn;
    
    UIButton * clickTempBtn;//临时button 上传图片用
}

- (instancetype)initWithFrame:(CGRect)frame Tags:(NSArray*)tags
{
    self = [super initWithFrame:frame];
    if (self) {
        _tags = tags;
        tagsSelectedArr = [NSMutableArray array];
        
        [self setupView];
    }
    return self;
}

-(void)setupView{
    [self setupTag];
    [self setupSelfPhoto];
    [self setupCerCard];
}

-(void)setupTag{
    UILabel * tagLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 13)];
    tagLab.text = @"擅长领域";
    tagLab.font = XZFS_S_FONT(13);
    tagLab.textColor = XZFS_TEXTBLACKCOLOR;
    [self addSubview:tagLab];
    float verticalSpace = 9;
    float btnHeight = 24;
    float btnWidth = 75;
    float leftWidth = 22;
    float lineSpace = ((self.width-40)-leftWidth*2-btnWidth*3)/2;
    int lineCount = _tags.count%3==0?(int)_tags.count/3:(1+(int)(_tags.count/3));
    tagV = [[UIView alloc]initWithFrame:CGRectMake(20, tagLab.bottom+11, self.width-40, lineCount*btnHeight+verticalSpace*(lineCount+1))];
    tagV.layer.masksToBounds = YES;
    tagV.layer.cornerRadius = 4;
    [self addSubview:tagV];
    tagV.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i<_tags.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(leftWidth+(i%3)*(btnWidth+lineSpace), verticalSpace+(i/3)*(btnHeight+verticalSpace), 75, 24);
        [btn setTitle:_tags[i] forState:UIControlStateNormal];
        [btn setTitleColor:XZFS_HEX_RGB(@"#B5B6B6") forState:UIControlStateNormal];
        [btn setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateSelected];
        btn.titleLabel.font = XZFS_S_FONT(12);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius  =5;
        btn.layer.borderColor = XZFS_HEX_RGB(@"#B5B6B6").CGColor;
        btn.layer.borderWidth = 1;
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [tagV addSubview:btn];
    }
    
}

-(void)setupSelfPhoto{
    UILabel * selfPhotoLab = [[UILabel alloc]initWithFrame:CGRectMake(20, tagV.bottom+16, 150, 13)];
    selfPhotoLab.text = @"上传个人风采照";
    selfPhotoLab.font = XZFS_S_FONT(13);
    selfPhotoLab.textColor = XZFS_TEXTBLACKCOLOR;
    [self addSubview:selfPhotoLab];
    
    uploadSelfPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadSelfPhotoBtn.frame = CGRectMake(selfPhotoLab.left, selfPhotoLab.bottom+13, 68, 68);
    uploadSelfPhotoBtn.tag = 9;
    [uploadSelfPhotoBtn setImage:XZFS_IMAGE_NAMED(@"tianjiatupian_big") forState:UIControlStateNormal];
    uploadSelfPhotoBtn.layer.masksToBounds = YES;
    uploadSelfPhotoBtn.layer.cornerRadius  =5;
    [uploadSelfPhotoBtn addTarget:self action:@selector(uploadSelfPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:uploadSelfPhotoBtn];

}

-(void)setupCerCard{
    UILabel * cerCardLab = [[UILabel alloc]initWithFrame:CGRectMake(20, uploadSelfPhotoBtn.bottom+16, 300, 13)];
    cerCardLab.text = @"上传身份证（身份证正反面及手持身份证照片）";
    cerCardLab.font = XZFS_S_FONT(13);
    cerCardLab.textColor = XZFS_TEXTBLACKCOLOR;
    [self addSubview:cerCardLab];
    
    for (int i = 0; i<3; i++) {
       UIButton *  uploadCerCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        uploadCerCardBtn.frame = CGRectMake(cerCardLab.left+i*(68+34), cerCardLab.bottom+13, 68, 68);
        [uploadCerCardBtn setImage:XZFS_IMAGE_NAMED(@"tianjiatupian_big") forState:UIControlStateNormal];
        uploadCerCardBtn.layer.masksToBounds = YES;
        uploadCerCardBtn.layer.cornerRadius  =5;
        uploadCerCardBtn.tag = 10+i;
        [uploadCerCardBtn addTarget:self action:@selector(uploadCerCard:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:uploadCerCardBtn];
    }
    self.contentSize = CGSizeMake(SCREENWIDTH, cerCardLab.bottom+13+10);

}

-(void)btnClick:(UIButton*)sender{

    sender.selected = !sender.selected;
    sender.layer.borderColor = sender.selected?XZFS_TEXTORANGECOLOR.CGColor:XZFS_HEX_RGB(@"#B5B6B6").CGColor;
    if (sender.selected) {
        [tagsSelectedArr addObject:sender.titleLabel.text];
    }else{
        [tagsSelectedArr removeObject:sender.titleLabel.text];
    }
    NSLog(@"tag = %ld  title = %@",(long)sender.tag,sender.titleLabel.text);
}
-(void)uploadSelfPhoto{
    NSLog(@"上传照片");
    clickTempBtn = uploadSelfPhotoBtn;
    [self uploadImage];
}

-(void)uploadCerCard:(UIButton*)sender{
    NSLog(@"上传身份证  -%ld",(long)sender.tag);
    clickTempBtn = sender;
    [self uploadImage];
}

-(BOOL)validateIntroduce{
    [self.introduceDic setObject:tagsSelectedArr forKey:@"selectTags"];
    if (tagsSelectedArr.count<=0) {
        [ToastManager showToastOnView:self position:CSToastPositionCenter flag:NO message:@"请选择擅长的领域"];
        return NO;
    }else if ([[self.introduceDic allKeys]count]<4){
        [ToastManager showToastOnView:self position:CSToastPositionCenter flag:NO message:@"请按要求上传图片"];
        return NO;
    }
    return YES;
}

#pragma mark 上传照片

-(void)uploadImage{
    UIAlertController * actionSheetVC = [UIAlertController alertControllerWithTitle:@"修改头像" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.currentVC dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"照相机"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(XZFS_IS_IOS7)
        {
            //判断相机是否能够使用
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if(status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在手机的“设置-隐私-相机”中允许访问相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                
            } else {
                UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self.currentVC presentViewController:imagePicker animated:YES completion:nil];
            }
            
        }
    }];
     UIAlertAction * albumAction = [UIAlertAction actionWithTitle:@"相册"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         UIImagePickerController*  imagePicker = [[UIImagePickerController alloc] init];
         imagePicker.delegate = self;
         imagePicker.allowsEditing = YES;
         imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
         //			[self presentModalViewController:imagePicker animated:YES];
         [self.currentVC presentViewController:imagePicker animated:YES completion:nil];

     }];
    
    [actionSheetVC addAction:cancelAction];
    [actionSheetVC addAction:cameraAction];
    [actionSheetVC addAction:albumAction];
    [self.currentVC presentViewController:actionSheetVC animated:YES completion:nil];
    
    NSLog(@"上传图片。。");
}
#pragma mark imagePicker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage * image1 = [editingInfo objectForKey:UIImagePickerControllerOriginalImage];//取原图片
    UIImage * image2 = [Tool fixOrientation:image1];
    NSValue * value = [editingInfo objectForKey:UIImagePickerControllerCropRect];
    //
    CGRect rect = [value CGRectValue];
    CGImageRef imageRef = CGImageCreateWithImageInRect([image2 CGImage], rect) ;
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];//获取截取后的图片
    
    UIImage * nowImage = [self thumbnailWithImageWithoutScale:croppedImage size:CGSizeMake(200, 200)];
    CGImageRelease(imageRef);
    
    __block NSData * imageData = UIImageJPEGRepresentation(nowImage, 0.0);
    switch (clickTempBtn.tag) {
        case 9:
            [self.introduceDic setObject:imageData forKey:@"selfPhoto"];
            break;
        case 10:
             [self.introduceDic setObject:imageData forKey:@"forwardCard"];
            break;
        case 11:
            [self.introduceDic setObject:imageData forKey:@"backgroundCard"];
            break;
        case 12:
            [self.introduceDic setObject:imageData forKey:@"cardPerson"];
            break;
            
        default:
            break;
    }
    [clickTempBtn setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
   
#warning 上传 需重新修改
    
//    NSDictionary *dic;
//    MBProgressHUD *mbd = [MBProgressHUD showHUDAddedTo:self animated:YES];
//    mbd.dimBackground = YES;
//    mbd.labelText = @"上传中";
//    __weak PersonalCenterViewController * vc = self;
//    [SwpNetworking swpPOSTAddFile:@"http://nupload.shagualicai.cn/file/upload" parameters:dic fileName:@"key" fileData:imageData swpNetworkingSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
//        NSLog(@"resultObject = %@",resultObject);
//        if ([resultObject isKindOfClass:[NSDictionary class]]) {
//            
//            int code = [KISDictionaryHaveKey(resultObject, @"code")intValue];
//            if (code==1) {
//                imageData = nil;
//                NSDictionary * picKey = [[resultObject objectForKey:@"data"]objectForKey:@"key"];
//                NSString * picName = KISDictionaryHaveKey(picKey, @"savename");
//                NSString * picPath = KISDictionaryHaveKey(picKey, @"savepath");
//                NSString * savePath = [NSString stringWithFormat:@"/%@%@",picPath,picName];
//                [vc uploadAvatarWithSavePath:savePath];
//            }
//        }
//    } swpNetworkingError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
//        NSLog(@"errorMessage = %@",errorMessage);
//    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark  保持原来的长宽比，生成一个缩略图
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

#pragma mark getter
-(NSMutableDictionary *)introduceDic{
    if (!_introduceDic) {
        _introduceDic = [NSMutableDictionary dictionary];
    }
    return _introduceDic;
}

@end
