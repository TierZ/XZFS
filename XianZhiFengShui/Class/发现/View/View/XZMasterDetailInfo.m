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
    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self setupView];
    }
    return self;
}

-(void)setupView{
    [self sd_addSubviews:@[self.nameLab,self.infoLab,self.locationIv,self.locationLab]];
    
    self.nameLab.sd_layout
    .leftSpaceToView(self,0)
    .rightSpaceToView(self,0)
    .topSpaceToView(self,7)
    .widthIs(self.width);
    
    self.infoLab.sd_layout
    .leftSpaceToView(self,6)
    .rightSpaceToView(self,6)
    .topSpaceToView(self.nameLab,12)
    .heightIs(self.height-6-7-32);
    
    self.locationIv.sd_layout
    .leftSpaceToView(self,6)
    .topSpaceToView(self.infoLab,2)
    .widthIs(18)
    .heightIs(17);
    
    self.locationLab.sd_layout
    .leftSpaceToView(self.locationIv,6)
    .topSpaceToView(self.infoLab,6)
    .heightIs(10.5);
    [self.locationLab setSingleLineAutoResizeWithMaxWidth:(self.width-self.locationIv.right-6)];
    
}


-(void)refreshInfoWithDic:(NSDictionary*)dic{
    if (dic) {
        
    }
}

#pragma mark getter
-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc]init];
        _nameLab.backgroundColor = [UIColor clearColor];
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
    }
    return _infoLab;
}

-(UIImageView *)locationIv{
    if (!_locationIv) {
        _locationIv = [[UIImageView alloc]init];
        _locationIv.backgroundColor = [UIColor redColor];
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
    }
    return _locationLab;
}

@end
