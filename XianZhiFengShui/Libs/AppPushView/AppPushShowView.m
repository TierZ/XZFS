//
//  AppPushShowView.m
//  ShaGuaLiCai
//
//  Created by 李清娟 on 16/2/1.
//  Copyright © 2016年 YangShangJie. All rights reserved.
//

#import "AppPushShowView.h"

@implementation AppPushShowView
-(instancetype)initWithFrame:(CGRect)frame title:(NSString*)title{
    self = [super initWithFrame:frame];
    if (self) {
           self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        [self drawViewWithTitle:title];
     
    }
    return self;
}

-(void)drawViewWithTitle:(NSString*)title{
    UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 25, 25)];
    iv.backgroundColor = [UIColor clearColor];
    iv.layer.masksToBounds = YES;
    iv.layer.cornerRadius = 5;
    iv.image = [UIImage imageNamed:@"200"];
    [self addSubview:iv];
    
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(iv.right+10, 28, 200, 15)];
    nameLabel.text = @"傻瓜理财";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont fontWithName:LABElFONT size:12];
    nameLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:nameLabel];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(iv.right+10, 45, self.width-iv.right, 20)];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:LABElFONT size:12];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.numberOfLines = 0;
    [titleLabel sizeToFit];
    [self addSubview:titleLabel];
    self.frame = CGRectMake(0, 0, SCREENWIDTH, titleLabel.bottom+25);

    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPushView:)];
    [self addGestureRecognizer:tap];
    UISwipeGestureRecognizer * swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [swip setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self addGestureRecognizer:swip];
    
    
 }

-(void)show{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
    
    
}

-(void)tapPushView:(UITapGestureRecognizer*)tap{
    
    [self show];
    
    if (self.block) {
        self.block();
    }

}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
      if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
        
        NSLog(@"swipe down");
        //执行程序
    }
    if(recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
        [self show];
        NSLog(@"swipe up");
        //执行程序
    }
}

-(void)appPushWithBlock:(appPushBlock)block{
    self.block = block;
}

@end
