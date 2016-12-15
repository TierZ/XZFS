//
//  XZMasterDetailInfo2.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterDetailInfo2.h"

@implementation XZMasterDetailInfo2{
    NSArray * _titles;
}

- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray*)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        _titles = titles;
        [self setupView];
    }
    return self;
}

-(void)setupView{
    NSArray * icons = @[ @"",@"",@"",@""];
    for (int i = 0; i<icons.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*self.width/icons.count, 0, self.width/icons.count, self.height);
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:XZFS_TEXTLIGHTGRAYCOLOR forState:UIControlStateNormal];
        btn.titleLabel.font = XZFS_S_FONT(12);
        [self addSubview:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)btnClick:(UIButton*)sender{
    NSLog(@"sender.title = %@",sender.titleLabel.text);
    NSLog(@"sender.tag = %ld",(long)sender.tag);
}

@end
