//
//  XZMasterDetailInfo2.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterDetailInfo2.h"
#import "UIButton+XZImageTitleSpacing.h"
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
    NSArray * icons = @[ @"level1",@"yidianzan",@"chengdanshu",@"yishoucang"];
    for (int i = 0; i<icons.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*self.width/icons.count, 0, self.width/icons.count, self.height);
//        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:XZFS_TEXTLIGHTGRAYCOLOR forState:UIControlStateNormal];
        btn.titleLabel.font = XZFS_S_FONT(16);
        [btn setImage:XZFS_IMAGE_NAMED(icons[i]) forState:UIControlStateNormal];
        [btn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:6];
        [self addSubview:btn];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)refreshInfoWithDic:(NSDictionary*)dic{
    UIButton * levelBtn = (UIButton*)[self viewWithTag:10];
    UIButton * agreeBtn = (UIButton*)[self viewWithTag:11];
    UIButton * appointBtn = (UIButton*)[self viewWithTag:12];
    UIButton * collectBtn = (UIButton*)[self viewWithTag:13];
    
    int levelInt = [[dic objectForKey:@"level"]intValue];
    NSString * levelStr = [NSString stringWithFormat:@"level%d",levelInt];
    [levelBtn setImage:XZFS_IMAGE_NAMED(levelStr) forState:UIControlStateNormal];
    
    [agreeBtn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"pointOfPraise"]] forState:UIControlStateNormal];
    [appointBtn setTitle:[NSString stringWithFormat:@"%@人约过",[dic objectForKey:@"appoint"]] forState:UIControlStateNormal];
    [collectBtn setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"collection"]] forState:UIControlStateNormal];
}

-(void)btnClick:(UIButton*)sender{
    NSLog(@"sender.title = %@",sender.titleLabel.text);
    NSLog(@"sender.tag = %ld",(long)sender.tag);
    if (sender.tag==11||sender.tag==13) {
        if (self.block) {
            self.block((int)sender.tag);
        }
    }
}
-(void)btnClickWithBlock:(MasterMiddleBtnClickBlock)block{
    self.block = block;
}

@end
