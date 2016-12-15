//
//  XZTagView.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/11.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

/*
//使用步骤
 
 XZTagView * tagV = [[XZTagView alloc]initWithFrame:CGRectMake(100, 200, 200, 30) tagHeight:12];
 tagV.backgroundColor = [UIColor yellowColor];
 tagV.tagsArray = @[@"123",@"456",@"年后打开了发掘爱上的你好吗啊对asdasdasdad",@"2",@"是不是。。。"];
 [tagV setupTags];
 [self.view addSubview:tagV];
 
*/

//标签view
#import <UIKit/UIKit.h>

@interface XZTagView : UIView
- (instancetype)initWithFrame:(CGRect)frame tagHeight:(float)tagHeight;
@property (nonatomic,strong)NSArray * tagsArray;
-(void)setupTags;
@end
