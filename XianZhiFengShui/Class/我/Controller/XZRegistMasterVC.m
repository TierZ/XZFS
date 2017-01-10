//
//  XZRegistMasterVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZRegistMasterVC.h"
#import "XZMasterBasicInfo.h"
#import "XZMasterIntroduce.h"
#import "XZMasterCertainInfo.h"
#import "XZMasterAudit.h"
#import "XZUserCenterService.h"
#import "XZUploadFilesService.h"

@interface XZRegistMasterVC ()
@property (nonatomic,strong)UIScrollView * mainScroll;
@property (nonatomic,strong)UIButton * nextBtn;//下一步
@property (nonatomic,strong)UIButton * backBtn;//返回修改
@property (nonatomic,strong)UIButton * submitBtn;//提交
@property (nonatomic,strong)XZMasterBasicInfo * basicInfo;//基本信息
@property (nonatomic,strong)XZMasterIntroduce * introduce;//个人介绍及认证
@property (nonatomic,strong)XZMasterCertainInfo * certainInfo;//信息确认
@property (nonatomic,strong)XZMasterAudit * audit;//审核
@property (nonatomic,strong)NSArray * tags;
@property (nonatomic,strong)NSMutableDictionary * auditInfo;//审核内容
@end

@implementation XZRegistMasterVC{
    int _page;
    BOOL isReEdit;//返回修改
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 0;
    isReEdit = NO;
    [self setupTop];
    [self setupMainScroll];
    [self setupBottonBtn];
}

#pragma mark setup
-(void)setupTop{
    NSArray * titleArray  =@[@"基本信息",@"个人介绍及认证",@"信息确认",@"审核"];
    float lineWidth = 75;
    float leftSpace = (SCREENWIDTH-4*lineWidth)/2;
    for (int i = 0; i<4; i++) {
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(leftSpace+i*lineWidth, 20, lineWidth, 9)];
        iv.image = XZFS_IMAGE_NAMED(@"chengweidashi_weijinxing");
        if (i==0) {
            iv.image = XZFS_IMAGE_NAMED(@"chengweidashi_jinxingzhong");
        }
        iv.tag = i*10+1;
        [self.mainView addSubview:iv];
        
        UILabel * titleLab = [[UILabel alloc]initWithFrame:iv.frame];
        titleLab.centerY = iv.centerY+20;
        titleLab.font = XZFS_S_FONT(10);
        titleLab.textColor = XZFS_HEX_RGB(@"#333333");
        titleLab.text = titleArray[i];
        [titleLab sizeToFit];
        CGRect frame = titleLab.frame;
        frame.origin.x = iv.right-titleLab.width/2-5;
        titleLab.frame = frame;
        if (i==0) {
            titleLab.textColor = XZFS_TEXTORANGECOLOR;
        }
        titleLab.tag = i*10+2;
        [self.mainView addSubview:titleLab];
    }

}

-(void)setupMainScroll{
    [self.mainView addSubview:self.mainScroll];
    self.mainScroll.frame = CGRectMake(0, 62, SCREENWIDTH, SCREENHEIGHT-XZFS_STATUS_BAR_H-45-62);
    self.mainScroll.contentSize = CGSizeMake(SCREENWIDTH*4, self.mainScroll.height);
    self.mainScroll.pagingEnabled = YES;
    self.mainScroll .userInteractionEnabled = YES;
    
    _basicInfo = [[XZMasterBasicInfo alloc]initWithFrame:CGRectMake(0, 0, self.mainScroll.width, 262)];
     _introduce = [[XZMasterIntroduce alloc]initWithFrame:CGRectMake(self.mainScroll.width, 0, self.mainScroll.width, self.mainScroll.height) Tags:self.tags];
    _introduce.currentVC = self;
     _certainInfo = [[XZMasterCertainInfo alloc]initWithFrame:CGRectMake(self.mainScroll.width*2, 0, self.mainScroll.width, self.mainScroll.height)];
     _audit = [[XZMasterAudit alloc]initWithFrame:CGRectMake(self.mainScroll.width*3, 0, self.mainScroll.width, self.mainScroll.height)];
    [self.mainScroll addSubview:_basicInfo];
    [self.mainScroll addSubview:_introduce];
    [self.mainScroll addSubview:_certainInfo];
    [self.mainScroll addSubview:_audit];
    _basicInfo.backgroundColor = [UIColor whiteColor];
    _introduce.backgroundColor = [UIColor clearColor];
    _certainInfo.backgroundColor = [UIColor whiteColor];
    _audit.backgroundColor = [UIColor whiteColor];
    

}
-(void)setupBottonBtn{
    [self.mainView addSubview:self.nextBtn];
    [self.mainView addSubview:self.backBtn];
    [self.mainView addSubview:self.submitBtn];
    
    self.nextBtn.frame = CGRectMake(0, SCREENHEIGHT-XZFS_STATUS_BAR_H-45, SCREENWIDTH, 45);
    self.backBtn.frame = CGRectMake(0, SCREENHEIGHT-XZFS_STATUS_BAR_H-45, SCREENWIDTH/2, 45);
     self.submitBtn.frame = CGRectMake(SCREENWIDTH/2, SCREENHEIGHT-XZFS_STATUS_BAR_H-45, SCREENWIDTH/2, 45);
    self.backBtn.hidden = YES;
    self.submitBtn.hidden = YES;
}


#pragma mark action
-(void)nextStep:(UIButton*)sender{
    float xOffset = self.mainScroll.contentOffset.x/self.mainScroll.width;
    if (xOffset==0) {
        BOOL basicInfoValidate = [_basicInfo validateTfInfo];
        if (!basicInfoValidate) {
            return;
        }else{
            [self.auditInfo addEntriesFromDictionary:_basicInfo.itemsDic];
            _page++;
        }
    }else if (xOffset==1){
        BOOL introduceValidate = [_introduce validateIntroduce];
        if (introduceValidate) {
            [self.auditInfo addEntriesFromDictionary:_introduce.introduceDic];
            _page++;
            if (!isReEdit) {
                [_certainInfo refreshViewWithDic:self.auditInfo];
            }
            
        }else{
            return;
        }
    }else if (xOffset==2){
      
        _page++;
    }
    
       NSLog(@"self.auditInfo = %@",self.auditInfo);
    NSLog(@"_page = %d",_page);
    if (_page==3) {
        self.nextBtn.hidden = YES;
        self.backBtn.hidden = NO;
        self.submitBtn.hidden = NO;
    }else{
        self.nextBtn.hidden = NO;
        self.backBtn.hidden = YES;
        self.submitBtn.hidden = YES;
    }
    NSLog(@"下一步");
    [self.mainScroll setContentOffset:CGPointMake(self.mainScroll.width*_page, 0) animated:YES];

    UIImageView *iv = (UIImageView*)[self.mainView viewWithTag:(_page*10+1)];
    iv.image = XZFS_IMAGE_NAMED(@"chengweidashi_jinxingzhong");
    UILabel *lab = (UILabel*)[self.mainView viewWithTag:(_page*10+2)];
    lab.textColor = XZFS_TEXTORANGECOLOR;
}
-(void)backStep:(UIButton*)sender{
    NSLog(@"返回修改");
    isReEdit = YES;
    [self.mainScroll setContentOffset:CGPointMake(0, 0) animated:YES];
    _page=0;
    self.nextBtn.hidden = NO;
    self.backBtn.hidden = YES;
    self.submitBtn.hidden = YES;
    
    for (int i = 0; i<4; i++) {
        UIImageView *iv = (UIImageView*)[self.mainView viewWithTag:(i*10+1)];
        iv.image = XZFS_IMAGE_NAMED(@"chengweidashi_weijinxing");
        UILabel *lab = (UILabel*)[self.mainView viewWithTag:(i*10+2)];
        lab.textColor = XZFS_HEX_RGB(@"#333333");
        if (i==0) {
            iv.image = XZFS_IMAGE_NAMED(@"chengweidashi_jinxingzhong");
             lab.textColor = XZFS_TEXTORANGECOLOR;
        }
    }
}
-(void)submitInfo:(UIButton*)sender{
    [self registMasterRequest];
    NSLog(@"提交");
}

#pragma mark 网络请求
-(void)uploadImages{
    XZUploadFilesService * uploadImages = [[XZUploadFilesService alloc]initWithServiceTag:10000];
    uploadImages.delegate = self;
}

-(void)registMasterRequest{
    XZUserCenterService * registMaster = [[XZUserCenterService alloc]initWithServiceTag:XZRegistMasterTag];
    registMaster.delegate = self;
    [registMaster RegistMasterWithCityCode:@"110000" masterCode:@"" name:[self.auditInfo objectForKey:@"name"] phoneNo:[self.auditInfo objectForKey:@"phone"] email:[self.auditInfo objectForKey:@"email"] city:[self.auditInfo objectForKey:@"city"] company:[self.auditInfo objectForKey:@"company"] position:[self.auditInfo objectForKey:@"position"] nickname:@"" sex:@"" title:@"" summary:@"" descr:@"" icon:@"" serviceType:[self.auditInfo objectForKey:@"selectTags"] photoList:@[[self.auditInfo objectForKey:@"selfPhoto"]] idcardList:@[[self.auditInfo objectForKey:@"forwardCard"],[self.auditInfo objectForKey:@"backgroundCard"],[self.auditInfo objectForKey:@"cardPerson"]] view:self.mainView];
}

-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    NSLog(@"成为大师 = %@",succeedHandle);
}
-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{
    NSLog(@"error = %@",failHandle);
}
#pragma mark getter
-(UIScrollView *)mainScroll{
    if (!_mainScroll) {
        _mainScroll = [[UIScrollView alloc]init];
        _mainScroll.showsVerticalScrollIndicator = NO;
        _mainScroll.showsHorizontalScrollIndicator = NO;
        _mainScroll.scrollEnabled = NO;
    }
    return _mainScroll;
}

-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
        _nextBtn.titleLabel.font = XZFS_S_FONT(19);
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setTitle:@"返回修改" forState:UIControlStateNormal];
        _backBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
        _backBtn.titleLabel.font = XZFS_S_FONT(19);
        [_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backStep:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
        _submitBtn.titleLabel.font = XZFS_S_FONT(19);
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitInfo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

-(NSArray *)tags{
    if (!_tags) {
        NSString *meListPath = [[NSBundle mainBundle] pathForResource:@"SkillTags" ofType:@"plist"];
        _tags = [[NSArray alloc]initWithContentsOfFile:meListPath];
        NSLog(@"listArray = %@",_tags);
    }
    return _tags;
}
-(NSMutableDictionary *)auditInfo{
    if (!_auditInfo) {
        _auditInfo = [NSMutableDictionary dictionary];
    }
    return _auditInfo;
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
