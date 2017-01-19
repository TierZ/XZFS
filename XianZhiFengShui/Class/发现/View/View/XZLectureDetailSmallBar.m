//
//  XZLectureDetailSmallBar.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/19.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZLectureDetailSmallBar.h"
#import "UIButton+XZImageTitleSpacing.h"

@implementation XZLectureDetailSmallBar{
    UILabel * _timeLab;
    UILabel * _timeLengthLab;
    UILabel * _addressLab;
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
    NSArray * icons = @[@"calendar",@"shijian",@"weizhi"];
    float space = (SCREENWIDTH-21*2)/(int)(icons.count);

    for (int i = 0; i<icons.count; i++) {
//        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
////        btn.backgroundColor = RandomColor(1);
//         btn.frame = CGRectMake(21+space*i, 0, space, 12);
//        btn.imageView.size = CGSizeMake(12, 12);
//        [btn setImage:XZFS_IMAGE_NAMED(icons[i]) forState:UIControlStateNormal];
//        [btn setTitle:@"--" forState:UIControlStateNormal];
//        btn.titleLabel.font =XZFS_S_FONT(10);
//        [btn setTitleColor:XZFS_HEX_RGB(@"#CACBCB") forState:UIControlStateNormal];
//        [btn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:8];
//        [self addSubview:btn];
        
        UIImageView * iv = [[UIImageView alloc]init];
        iv.image = XZFS_IMAGE_NAMED(icons[i]);
        iv.frame = CGRectMake(21+space*i, 0, 12, 12);
//        if (i==1) {
//            iv.centerX = self.centerX;
//        }else if (i==2){
//            iv.frame = CGRectMake(SCREENWIDTH/2+space, 0, 12, 12);
//        }
        [self addSubview:iv];
        
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(iv.right+8, 0, 200, 10)];
        lab.textColor = XZFS_HEX_RGB(@"#CACBCB");
        lab.font = XZFS_S_FONT(10);
        lab.tag = 10+i;
        [self addSubview:lab];
        lab.text = @"--";
    }
}

-(void)refreshViewWithDic:(NSDictionary *)dic{
    _timeLab = (UILabel*)[self viewWithTag:10];
    _timeLengthLab = (UILabel*)[self viewWithTag:11];
    _addressLab = (UILabel*)[self viewWithTag:12];
    _timeLab.text = KISDictionaryHaveKey(dic, @"startTime");
    _timeLengthLab.text = KISDictionaryHaveKey(dic, @"");
    _addressLab.text = KISDictionaryHaveKey(dic, @"address");
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
