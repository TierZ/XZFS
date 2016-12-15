//
//  XZTagView.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/11.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZTagView.h"

@implementation XZTagView{
    float _tagHeight;
}

- (instancetype)initWithFrame:(CGRect)frame tagHeight:(float)tagHeight
{
    self = [super initWithFrame:frame];
    if (self) {
        _tagHeight = tagHeight;
    }
    return self;
}

-(void)setupTags{
    float x = 0;
    float y = 0;
    [self removeAllSubviews];
    for (int i = 0; i<self.tagsArray.count; i++) {
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 50, _tagHeight)];
        lab.text = self.tagsArray[i];
        lab.backgroundColor = [UIColor whiteColor];
     
       
        if (_tagHeight-8>4) {
             lab.font = XZFS_S_FONT(_tagHeight-8);
        }else{
            lab.font = XZFS_S_FONT(_tagHeight);
        }
        [lab sizeToFit];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.layer.masksToBounds = YES;
        lab.layer.cornerRadius = 5;
        lab.layer.borderWidth = 0.5;
        lab.layer.borderColor = XZFS_TEXTORANGECOLOR.CGColor;
        lab.textColor = XZFS_TEXTORANGECOLOR;
        lab.frame = CGRectMake(x, y, lab.width+18, _tagHeight);
        x+=lab.width+10;
        [self addSubview:lab];
        if (x>self.width-10) {
            y+=_tagHeight+5;
            x=0;
           lab.frame = CGRectMake(x, y, lab.width, _tagHeight);
            if (lab.width>=self.width) {
                lab.width = self.width;
            }
            x+=lab.width+10;
        }
        
    }
    self.height = y+_tagHeight;
}

@end
