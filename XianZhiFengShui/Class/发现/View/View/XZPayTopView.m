//
//  XZPayTopView.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/3.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZPayTopView.h"

@implementation XZPayTopView{
    XZPayTopStyle _topStyle;
}

- (instancetype)initWithFrame:(CGRect)frame topStyle:(XZPayTopStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        _topStyle = style;
        [self setupView];
    }
    return self;
}

-(void)setupView{
    
    UILabel * title = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 100, 15)];
    title.text = @"订单详情";
    title.font = XZFS_S_FONT(15);
    title.textColor = XZFS_TEXTBLACKCOLOR;
    [self addSubview:title];
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(20, title.bottom+12, self.width-40, 0.5)];
    line.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
    [self addSubview:line];
    
    
    NSArray * leftArrs = _topStyle?@[@"咨询大师",@"服务项目",@"咨询费用"]:@[@"讲座主题",@"讲座项目",@"讲座费用"];
    for (int i = 0; i<leftArrs.count; i++) {
        UILabel * leftLab = [[UILabel alloc]initWithFrame:CGRectMake(70, line.bottom+14+i*(21+12), 100, 12)];
        leftLab.font = XZFS_S_FONT(12);
        leftLab.text = leftArrs[i];
        leftLab.textColor = XZFS_HEX_RGB(@"#252323");
        [self addSubview:leftLab];
        
        UILabel * rightLab = [[UILabel alloc]initWithFrame:CGRectMake(100, leftLab.top, self.width-100-70, 12)];
        rightLab.font = XZFS_S_FONT(12);
        rightLab.text = @"--";
        rightLab.textColor = XZFS_HEX_RGB(@"#252323");
        rightLab.tag = 100+i;
        rightLab.textAlignment = NSTextAlignmentRight;
        [self addSubview:rightLab];
    }
}

-(void)refreshTopInfo{
    NSLog(@"刷新lab");
}

@end
