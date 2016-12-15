//
//  XZEditInfoVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/3.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZEditInfoVC.h"
#import <AVFoundation/AVFoundation.h>

@interface XZEditInfoVC ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong)UITableView * editTable;
@property (nonatomic,strong)NSArray * editItems;
@property (nonatomic,strong)NSArray * pickerArr;

@end

@implementation XZEditInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.editTable.frame = CGRectMake(0, 7, SCREENWIDTH, SCREENHEIGHT-XZFS_STATUS_BAR_H-7);
    [self.mainView addSubview:self.editTable];
    
}

#pragma mark table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.editItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = self.editItems[indexPath.row];
    cell.textLabel.font = XZFS_S_FONT(13);
    cell.textLabel.textColor = XZFS_TEXTLIGHTGRAYCOLOR;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(cell.width-50, 2, 40, 40)];
        iv.backgroundColor = [UIColor redColor];
        iv.layer.masksToBounds = YES;
        iv.layer.cornerRadius = 20;
        [cell.contentView addSubview:iv];
    }else{
        UITextField * tf = [[UITextField alloc]initWithFrame:CGRectMake(120, 15, cell.width-130, 14)];
        tf.textColor = XZFS_TEXTBLACKCOLOR;
        tf.font = XZFS_S_FONT(14);
        [cell.contentView addSubview:tf];
        if (indexPath.row==3||indexPath.row==5) {
            tf.userInteractionEnabled = NO;
        }
    }
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    if (indexPath.row==3){
        UIPickerView * picker = [self setupPickviewWithArray:@[ @"女",@"男",@"保密" ] rect:rectInTableView];
    
        [self.mainView addSubview:picker];
    }else if (indexPath.row==5){
        UIPickerView * picker = [self setupPickviewWithArray:@[ @"北京",@"天津",@"上海",@"重庆"] rect:rectInTableView];
        [self.mainView addSubview:picker];
    }else if (indexPath.row==0){
        UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"修改头像"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:nil
                                      otherButtonTitles:@"照相机",@"本地相册",nil];
        [actionSheet showInView:self.view];
        
        NSLog(@"上传图片。。");
    }else{
    
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    footV.backgroundColor = self.mainView.backgroundColor;
    
    UIButton * footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    footBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
    [footBtn setTitle:@"保存" forState:UIControlStateNormal];
    [footBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    footBtn.titleLabel.font = XZFS_S_FONT(19);
    footBtn.frame = CGRectMake(20, 40, footV.width-40, 45);
    [footBtn addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    footBtn.layer.masksToBounds = YES;
    footBtn.layer.cornerRadius = 5;
    [footV addSubview:footBtn];
    
    return footV;
}

#pragma mark picker 代理

//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerArr.count;
}

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.pickerArr[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 20;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}
#pragma mark actionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0://照相机
        {
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
                    //			[self presentModalViewController:imagePicker animated:YES];
                    [self presentViewController:imagePicker animated:YES completion:nil];
                }
                
            }
        }
            break;
        case 1://本地相簿
        {
            UIImagePickerController*  imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
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
    
    UIImage * nowImage = [Tool thumbnailWithImageWithoutScale:croppedImage size:CGSizeMake(200, 200)];
    CGImageRelease(imageRef);
    
    __block NSData * imageData = UIImageJPEGRepresentation(nowImage, 0.0);
    
    
//    NSDictionary *dic;
//    MBProgressHUD *mbd = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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

#pragma mark action
-(void)saveInfo{

    NSLog(@"保存信息");
}

#pragma mark private
-(UIPickerView*)setupPickviewWithArray:(NSArray*)array rect:(CGRect)rect{
    for (UIView * view in self.mainView.subviews) {
        if ([view isKindOfClass:[UIPickerView class]]) {
            [view removeFromSuperview];
        }
    }
    UIPickerView * pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, rect.origin.y, self.view.bounds.size.width, 88)];
    
    pickerView.delegate = self;
   pickerView.dataSource = self;
    self.pickerArr = array;
    return pickerView;
}


#pragma mark getter
-(UITableView *)editTable{
    if (!_editTable) {
        _editTable = [[UITableView alloc] init];
        _editTable.backgroundColor = self.mainView.backgroundColor;
        _editTable.dataSource = self;
        _editTable.delegate = self;
        _editTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        UIView * footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        _editTable.tableFooterView = footerView;
    }
    return _editTable;
}

-(NSArray *)editItems{
    if (!_editItems) {
        _editItems = @[ @"头像",@"昵称",@"真实姓名",@"性别",@"年龄",@"所在城市",@"行业及个人简介" ];
    }
    return _editItems;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
