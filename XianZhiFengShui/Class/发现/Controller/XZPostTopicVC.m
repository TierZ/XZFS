//
//  XZPostTopicVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/26.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZPostTopicVC.h"
#import "XZTagView.h"
#import "XZTextView.h"
#import "XZThemeDetailData.h"
#import "XZLoginVC.h"
#import "XZUploadFilesService.h"
#import "SwpNetworking.h"

@interface XZPostTopicVC ()<LQPhotoPickerViewDelegate,UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic,strong)UIScrollView * mainScroll;
//@property (nonatomic,strong)XZTagView * tagV;
@property (nonatomic,strong)UITextField * titleField;
@property (nonatomic,strong)XZTextView * contentTV;
@property (nonatomic,strong)UIButton *  uploadImages;

@end

@implementation XZPostTopicVC{
    UILabel * _tagLab;
    UILabel * _titleLab;
    UILabel * _contentLab;
    UILabel * _uploadImagesLab;
    UIView * tagV;
    
    float _textviewHeight;
    NSMutableString * _typeCode;
    NSString * _userCode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
    self.titelLab.text = @"发帖";
    _textviewHeight = 31;
    _typeCode = [NSMutableString string];
    [self initPicker];
    [self setupTag];
    [self setupTitle];
    [self setupContent];
    [self setupUploadImages];
    
    [self updateViewsFrame];
    
    [self setUpPostBtn];
    
    [self setupTapGesture];

}


#pragma mark setup

-(void)initPicker{
    
    self.mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,XZFS_STATUS_BAR_H, SCREENWIDTH, SCREENHEIGHT-XZFS_STATUS_BAR_H-45)];
//    self.mainScroll.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.mainScroll];
    
    
    /**
     *  依次设置
     */
    self.LQPhotoPicker_superView = self.mainScroll;
    
    self.LQPhotoPicker_imgMaxCount = 9;
    
    [self LQPhotoPicker_initPickerView];
    
    self.LQPhotoPicker_delegate = self;
}

-(void)setupTag{
    NSArray * _tags =  @[@"事业·运势",@"良辰·吉日",@"选址·乔迁",@"起名·测字",@"家居·装修",@"手相·面相",@"学业·考试",@"婚恋·情感"];
    
    _tagLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 100, 13)];
    _tagLab.text = @"话题类别";
    _tagLab.font = XZFS_S_FONT(13);
    _tagLab.textColor = XZFS_TEXTBLACKCOLOR;
    [self.mainScroll addSubview:_tagLab];
    float verticalSpace = 9;
    float btnHeight = 24;
    float btnWidth = 75;
    float leftWidth = 22;
    float lineSpace = ((self.mainScroll.width-40)-leftWidth*2-btnWidth*3)/2;
    int lineCount = _tags.count%3==0?(int)_tags.count/3:(1+(int)(_tags.count/3));
    tagV = [[UIView alloc]initWithFrame:CGRectMake(20, _tagLab.bottom+11, self.mainScroll.width-40, lineCount*btnHeight+verticalSpace*(lineCount+1))];
    tagV.layer.masksToBounds = YES;
    tagV.layer.cornerRadius = 4;
    [self.mainScroll addSubview:tagV];
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
        btn.tag = 200+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [tagV addSubview:btn];
    }
    
}


///**
// 标签
// */
//-(void)setupTag{
//    
//    _tagLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, self.mainScroll.width-40, 12)];
//    _tagLab.text = @"话题类别";
//    _tagLab.textColor = XZFS_TEXTBLACKCOLOR;
//    _tagLab.font = XZFS_S_FONT(12);
//    [self.mainScroll addSubview:_tagLab];
//    
//    _tagV = [[XZTagView alloc]initWithFrame:CGRectMake(20, _tagLab.bottom+12, self.mainScroll.width-40, 30) tagHeight:24];
//    _tagV.backgroundColor = [UIColor whiteColor];
//    _tagV.tagsArray = @[@"事业·运势",@"良辰·吉日",@"选址·乔迁",@"起名·测字",@"家居·装修",@"手相·面相",@"学业·考试",@"婚恋·情感",];
//    [_tagV setupTags];
//    [self.mainScroll addSubview:_tagV];
//    
//}



/**
 标题
 */
-(void)setupTitle{
    _titleLab = [[UILabel alloc]init];
    _titleLab.text = @"话题标题";
    _titleLab.textColor = XZFS_TEXTBLACKCOLOR;
    _titleLab.font = XZFS_S_FONT(12);
    [self.mainScroll addSubview:_titleLab];

    self.titleField = [[UITextField alloc]init];
    self.titleField.backgroundColor = [UIColor whiteColor];
    self.titleField.placeholder = @"  请输入话题标题";
    self.titleField.textColor = XZFS_TEXTBLACKCOLOR;
    self.titleField.font = XZFS_S_FONT(12);
    self.titleField.delegate = self;
    self.titleField.returnKeyType = UIReturnKeyDone;
    [self.mainScroll addSubview:self.titleField];
    
}


/**
 话题内容
 */
-(void)setupContent{
    _contentLab = [[UILabel alloc]init];
    _contentLab.text = @"话题内容";
    _contentLab.textColor = XZFS_TEXTBLACKCOLOR;
    _contentLab.font = XZFS_S_FONT(12);
    [self.mainScroll addSubview:_contentLab];
    
    self.contentTV = [[XZTextView alloc]initWithFrame:CGRectMake(_tagLab.left, _contentLab.bottom+12, self.mainScroll.width-40, _textviewHeight)];
    self.contentTV.placeholder = @"请输入话题详细内容";
    self.contentTV.textColor =XZFS_TEXTBLACKCOLOR;
    self.contentTV.font = XZFS_S_FONT(12);
    self.contentTV.delegate = self;
    self.contentTV.returnKeyType = UIReturnKeyDone;
    self.contentTV.backgroundColor = [UIColor whiteColor];
    [self.mainScroll addSubview:self.contentTV];
    
    __weak typeof(self)weakSelf = self;
    [self.contentTV textHeightDidChanged:^(NSString *text, float textHeight) {
        _textviewHeight = textHeight;
        [weakSelf updateViewsFrame];
    }];
    self.contentTV.maxRow = 5;
    self.contentTV.lineSpace = 5;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5; //行距
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:12], NSParagraphStyleAttributeName:paragraphStyle};
    self.contentTV.typingAttributes = attributes;
    
}


/**
 上传图片
 */
-(void)setupUploadImages{
     _uploadImagesLab = [[UILabel alloc]init];
    _uploadImagesLab.text = @"添加图片";
    _uploadImagesLab.textColor = XZFS_TEXTBLACKCOLOR;
    _uploadImagesLab.font = XZFS_S_FONT(12);
    [self.mainScroll addSubview:_uploadImagesLab];
}


/**
 发表按钮
 */
-(void)setUpPostBtn{
    UIButton * postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    postBtn.frame = CGRectMake(0, self.mainScroll.bottom, SCREENWIDTH, 45);
    [postBtn setTitle:@"发表话题" forState:UIControlStateNormal];
    postBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
    postBtn.titleLabel.font = XZFS_S_FONT(20);
    [postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [postBtn addTarget:self action:@selector(postTopic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postBtn];
    
}

#pragma mark updateViewsFrame

-(void)updateViewsFrame{

   _titleLab.sd_layout
    .leftEqualToView(_tagLab)
    .topSpaceToView(tagV,12)
    .widthIs(200)
    .heightIs(12);
    
    self.titleField.sd_layout
    .leftEqualToView(_tagLab)
    .rightSpaceToView(self.mainScroll,20)
    .topSpaceToView(_titleLab,12)
    .heightIs(34);
    
    _contentLab.sd_layout
    .leftEqualToView(_tagLab)
    .topSpaceToView(self.titleField,12)
    .widthIs(200)
    .heightIs(12);
    
    self.contentTV.sd_layout
    .leftEqualToView(_tagLab)
    .rightSpaceToView(self.mainScroll,20)
    .topSpaceToView(_contentLab,12)
    .heightIs(_textviewHeight);
 
    
    _uploadImagesLab.sd_layout
    .leftEqualToView(_tagLab)
    .topSpaceToView(self.contentTV,12)
    .widthIs(200)
    .heightIs(12);
    
    [self LQPhotoPicker_updatePickerViewFrameY:_uploadImagesLab.bottom+12];
    self.mainScroll.contentSize = CGSizeMake(SCREENWIDTH,  [self LQPhotoPicker_getPickerViewFrame].origin.y+ [self LQPhotoPicker_getPickerViewFrame].size.height);
}

-(void)setupTapGesture{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBg:)];
    [self.view addGestureRecognizer:tap];

}


#pragma mark action
-(void)btnClick:(UIButton*)sender{
    sender.selected = !sender.selected;
    sender.layer.borderColor = sender.selected?XZFS_TEXTORANGECOLOR.CGColor:XZFS_HEX_RGB(@"#B5B6B6").CGColor;
    NSLog(@"选择的 标签--%ld",(long)sender.tag);

}

-(void)postTopic:(UIButton*)sender{
    if ([self checkLoginState]) {
        if ([self checkInputData]) {
//            [self confirmTopic];
            [self uploadFiles];
             NSLog(@"发表");
        }
    }
   
}
-(void)clickLeftButton{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)tapBg:(UITapGestureRecognizer*)tap{
    if ([self.titleField becomeFirstResponder]) {
        [self.titleField resignFirstResponder];
    }
    if ([self.contentTV becomeFirstResponder]) {
        [self.contentTV resignFirstResponder];
    }
}
#pragma mark textviewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //判断加上输入的字符，是否超过界限
    NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
    if (str.length > 300)
    {
        UIAlertView * textAlert;
        if (textAlert == nil) {
            textAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"字符个数不能大于300" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            textAlert.tag = 19;
            [textAlert show];
        }
        textView.text = [textView.text substringToIndex:140];
        return NO;
    }
    
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [self tapBg:nil];
        return NO;
    }
    return YES;
}

#pragma mark textfield 代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self tapBg:nil];
    return YES;
}


#pragma mark  LQPhotoPicker 代理
- (void)LQPhotoPicker_pickerViewFrameChanged{
    [self updateViewsFrame];
}


#pragma mark 网络
-(void)uploadFiles{
//    XZUploadFilesService * uploadServ = [[XZUploadFilesService alloc]initWithServiceTag:10000];
//    uploadServ.delegate = self;
    NSArray * picArr = [self LQPhotoPicker_getSmallDataImageArray];
//    [uploadServ uploadFilesWithFiles:picArr fileNames:@[@"file"] view:self.view];
    [SwpNetworking swpPOSTAddFiles:@"http://api.xianzhifengshui.com/file/upload" parameters:@{} fileName:@"file" fileDatas:picArr swpNetworkingSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSLog(@"resultObject = %@",resultObject);
    } swpNetworkingError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"errorMessage = %@",errorMessage);
    }];
    

   
}

-(void)confirmTopic{
    XZThemeDetailData * confirmTopic = [[XZThemeDetailData alloc]initWithServiceTag:XZConfirmTopicTag];
    confirmTopic.delegate = self;
    NSArray * picArr = [self LQPhotoPicker_getBigImageDataArray];
    [confirmTopic confirmTopicWithCityCode:@"110000" userCode:_userCode title:_titleField.text content:_contentTV.text typeCode:_typeCode picList:picArr view:self.view];
  
}
-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
   
    if ([service isKindOfClass:[XZUploadFilesService class]]) {
        NSLog(@"上传 = %@",succeedHandle);
    }else if ([service isKindOfClass:[XZThemeDetailData class]]){
         NSLog(@"succhandle = %@",succeedHandle);
        NSDictionary *dic = (NSDictionary*)succeedHandle;
        if ([[[dic objectForKey:@"data"]objectForKey:@"affect"]boolValue]==1) {
            [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:YES message:[dic objectForKey:@"message"]];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:YES message:[dic objectForKey:@"message"]];
        }
    }

}
-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{
    NSLog(@"failHandle = %@",failHandle)
}
#pragma mark private
-(BOOL)checkLoginState{
    NSDictionary * dic = GETUserdefault(@"userInfos");
    BOOL isLogin = [[dic objectForKey:@"isLogin"]boolValue];
    _userCode = [dic objectForKey:@"bizCode"];
    if (!isLogin) {
        [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:NO message:@"未登录，请先去登录"];
        __weak typeof(self)weakself = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[[XZLoginVC alloc]init]];
            navi.navigationBar.hidden = YES;
            [weakself.navigationController presentViewController:navi animated:YES completion:nil];
        });
    }
    return isLogin;
}

-(BOOL)checkInputData{
    for (UIButton*btn in tagV.subviews) {
        if (btn.selected) {
            [_typeCode appendString:btn.titleLabel.text];
        }
    }
    if ([_typeCode isEqualToString:@""]) {
        [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:NO message:@"话题类型不能为空"];
        return NO;
    }else if ([_titleField.text isEqualToString:@""]){
         [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:NO message:@"标题不能为空"];
        return NO;
    }else if ([_contentTV.text isEqualToString:@""]){
         [ToastManager showToastOnView:self.view position:CSToastPositionCenter flag:NO message:@"话题内容不能为空"];
        return NO;
    }
    return YES;
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
