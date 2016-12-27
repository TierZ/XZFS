//
//  XZArticleDetailVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/27.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZArticleDetailVC.h"
#import "XZMasterDetailListData.h"

@interface XZArticleDetailVC ()
@property(nonatomic,strong)NSString * bizCode;
@end

@implementation XZArticleDetailVC{
    UILabel * _articleTitleLab;
    UIImageView * _avatarIv;
    UILabel * _nameLab;
    YYTextView * _contentTV;
}

- (instancetype)initWithBizCode:(NSString*)bizCode
{
    self = [super init];
    if (self) {
        _bizCode = bizCode;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"文章详情";
    [self setupView];
    [self setupData];
    // Do any additional setup after loading the view.
}
-(void)setupView{
    
    self.mainView.backgroundColor = [UIColor whiteColor];
    
    _articleTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, SCREENWIDTH-40, 14)];
    _articleTitleLab.font = XZFS_S_FONT(14);
    _articleTitleLab.textColor = XZFS_TEXTBLACKCOLOR;
    [self.mainView addSubview:_articleTitleLab];
    
    _avatarIv = [[UIImageView alloc]initWithFrame:CGRectMake(_articleTitleLab.left, _articleTitleLab.bottom+14, 35, 35)];
    _avatarIv.backgroundColor = XZFS_TEXTLIGHTGRAYCOLOR;
    _avatarIv.layer.cornerRadius = 17.5;
    _avatarIv.layer.masksToBounds = YES;
    [self.mainView addSubview:_avatarIv];
    
    _nameLab = [[UILabel alloc]initWithFrame:CGRectMake(_avatarIv.right+15, _avatarIv.top+10    ,200, 10)];
    _nameLab.font = XZFS_S_FONT(10);
    _nameLab.centerY = _avatarIv.centerY;
    _nameLab.textColor = XZFS_HEX_RGB(@"#BABBBB");
    [self.mainView addSubview:_nameLab];
    
    _contentTV = [[YYTextView alloc]initWithFrame:CGRectMake(20, _avatarIv.bottom+12, SCREENWIDTH-40, XZFS_MainView_H-_avatarIv.bottom-12-10)];
    _contentTV.backgroundColor = [UIColor whiteColor];
    _contentTV.editable = NO;
    [self.mainView addSubview:_contentTV];

}


-(void)setupData{
    XZMasterDetailListData * articleDetailData = [[XZMasterDetailListData alloc]
                                                  initWithServiceTag:XZMasterArticleDetail];
    [articleDetailData articleDetailWithCityCode:@"110000" articleCode:_bizCode view:self.mainView successBlock:^(NSDictionary *data) {
        if (data) {
            self.titelLab.text = [data objectForKey:@"title"];
            _articleTitleLab.text = [data objectForKey:@"title"];
            _nameLab.text = [NSString stringWithFormat:@"%@ · %@",[data objectForKey:@"masterName"],[data objectForKey:@"createTime"]];
            _contentTV.text = [data objectForKey:@"content"];
        }
        NSLog(@"data = %@",data);
        [self.mainView hideNoDataView];
    } failBlock:^(NSError *error) {
        [self.mainView showNoDataViewWithType:NoDataTypeDefault backgroundBlock:nil btnBlock:nil];
    }];
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
