//
//  XZLectureDetailMiddleBar.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/21.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZLectureDetailMiddleBar.h"
#import "LPLevelView.h"
#import "UIButton+XZImageTitleSpacing.h"
@implementation XZLectureDetailMiddleBar{
    UILabel * _levelLab;
    UIImageView * _levelIv;
    LPLevelView * _starLevel;
    UIButton * _appointmentBtn;
    UIButton * _collectionBtn;
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
    _levelLab = [[UILabel alloc]initWithFrame:CGRectMake(20, (self.height-12)/2, 30, 12)];
    _levelLab.font = XZFS_S_FONT(12);
    _levelLab.text = @"--";
    _levelLab.textColor = XZFS_TEXTORANGECOLOR;
    [self addSubview:_levelLab];
    
    _starLevel = [[LPLevelView alloc]init];
    _starLevel.frame = CGRectMake(_levelLab.right+8, (self.height-12)/2, 56, 11);
    _starLevel.backgroundColor = [UIColor clearColor];
    _starLevel.canScore = YES;
    _starLevel.animated = YES;
    _starLevel.level = 3;
    _starLevel.iconSize = CGSizeMake(11, 11);
    _starLevel.iconFull = [UIImage imageNamed:@"xingxing_full"];
    _starLevel.iconHalf = [UIImage imageNamed:@"xingxing_empty"];
    _starLevel.iconEmpty = [UIImage imageNamed:@"xingxing_empty"];
    [self addSubview:_starLevel];
    
    _appointmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _appointmentBtn.frame = CGRectMake((self.width-84)/2, (self.height-12)/2, 84, 12);
    [_appointmentBtn setImage:XZFS_IMAGE_NAMED(@"chengdanshu") forState:UIControlStateNormal];
    [_appointmentBtn setTitle:@"--人约过" forState:UIControlStateNormal];
    [_appointmentBtn setTitleColor:XZFS_HEX_RGB(@"#F80025") forState:UIControlStateNormal];
    _appointmentBtn.titleLabel.font = XZFS_S_FONT(12);
    [_appointmentBtn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    [self addSubview:_appointmentBtn];
    
    _collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectionBtn.frame = CGRectMake(self.width-40-23, (self.height-12)/2, 40, 12);
    [_collectionBtn setImage:XZFS_IMAGE_NAMED(@"yishoucang") forState:UIControlStateNormal];
    [_collectionBtn setTitle:@"--" forState:UIControlStateNormal];
    [_collectionBtn setTitleColor:XZFS_HEX_RGB(@"#F80025") forState:UIControlStateNormal];
    _collectionBtn.titleLabel.font = XZFS_S_FONT(12);
    [_collectionBtn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:10];
    [self addSubview:_collectionBtn];
}

-(void)refreshWithDic:(NSDictionary*)dic{
    _levelLab.text = [dic objectForKey:@"level"];
    _starLevel.level = _levelLab.text.intValue;
    NSString * appoint = [NSString stringWithFormat:@"%@",[dic objectForKey:@"appoint"]]?:@"--";
    NSString * collection =[NSString stringWithFormat:@"%@",[dic objectForKey:@"collection"]] ?:@"--";
    [_appointmentBtn setTitle:appoint forState:UIControlStateNormal];
    [_collectionBtn setTitle:collection forState:UIControlStateNormal];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
