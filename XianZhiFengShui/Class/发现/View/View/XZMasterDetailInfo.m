//
//  XZMasterDetailInfo.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterDetailInfo.h"

@interface XZMasterDetailInfo ()
@property (nonatomic,strong)UILabel * nameLab;
@property (nonatomic,strong)UILabel * infoLab;
@property (nonatomic,strong)UIImageView * locationIv;
@property (nonatomic,strong)UILabel * locationLab;
@end

@implementation XZMasterDetailInfo{
    NSString * _name;
    NSString * _info;
    NSString * _location;
    HeaderDetailStyle _style;
}

- (instancetype)initWithFrame:(CGRect)frame style:(HeaderDetailStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
        [self setupView];
    }
    return self;
}

-(void)setupView{
    [self sd_addSubviews:@[self.nameLab,self.infoLab,self.locationIv,self.locationLab]];
    
    self.nameLab.sd_layout
    .leftSpaceToView(self,6)
    .rightSpaceToView(self,6)
    .topSpaceToView(self,7)
    .heightIs(18);
    
    self.infoLab.sd_layout
    .leftSpaceToView(self,6)
    .rightSpaceToView(self,6)
    .topSpaceToView(self.nameLab,12)
    .autoHeightRatio(0);
    
    self.locationIv.sd_layout
    .leftSpaceToView(self,6)
    .topSpaceToView(self.infoLab,12)
    .widthIs(15)
    .heightIs(15);
    
    self.locationLab.sd_layout
    .leftSpaceToView(self.locationIv,6)
    .topSpaceToView(self.infoLab,12)
    .rightSpaceToView(self,6)
    .autoHeightRatio(0);
    
}


-(void)refreshInfoWithDic:(NSDictionary*)dic{
    if (dic) {
        if (_style==MasterHeaderDetail) {
            self.nameLab.text = [dic objectForKey:@"name"];
            self.infoLab.text = [dic objectForKey:@"desc"];
        }else if (_style==LectureHeaderDetail){
            self.nameLab.text = [dic objectForKey:@"masterName"];
        self.infoLab.text = [dic objectForKey:@"masterDesc"];
        }
        self.locationLab.text = [dic objectForKey:@"address"];
        [self setupAutoHeightWithBottomViewsArray:@[self.locationIv,self.locationLab] bottomMargin:10];
    }
}

#pragma mark getter
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.textColor =  [UIColor whiteColor];
        _nameLab.textAlignment =NSTextAlignmentCenter;
        _nameLab.font = XZFS_S_BOLD_FONT(18);
         _nameLab.text = @"--";
    }
    return _nameLab;
}

-(UILabel *)infoLab{
    if (!_infoLab) {
        _infoLab = [[UILabel alloc]init];
        _infoLab.backgroundColor = [UIColor clearColor];
        _infoLab.textColor =  [UIColor whiteColor];
        _infoLab.textAlignment =NSTextAlignmentLeft;
        _infoLab.font = XZFS_S_FONT(10.5);
         _infoLab.text = @"--";
        _infoLab.numberOfLines = 0;
    }
    return _infoLab;
}

-(UIImageView *)locationIv{
    if (!_locationIv) {
        _locationIv = [[UIImageView alloc]init];
        _locationIv.image = XZFS_IMAGE_NAMED(@"dashiweizhi");
    }
    return _locationIv;
}

-(UILabel *)locationLab{
    if (!_locationLab) {
        _locationLab = [[UILabel alloc]init];
        _locationLab.backgroundColor = [UIColor clearColor];
        _locationLab.textColor =  XZFS_TEXTBLACKCOLOR;
        _locationLab.textAlignment =NSTextAlignmentLeft;
        _locationLab.font = XZFS_S_FONT(10.5);
        _locationLab.text = @"--";
        _locationLab.numberOfLines = 0;
    }
    return _locationLab;
}

@end
