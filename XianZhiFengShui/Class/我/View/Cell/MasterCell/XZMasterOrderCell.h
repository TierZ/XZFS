//
//  XZMasterOrderCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/6.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZMasterOrderCell : UITableViewCell
@property (nonatomic,strong)UIImageView * icon;
@property (nonatomic,strong)UILabel * service;
@property (nonatomic,strong)UILabel * time;
@property (nonatomic,strong)UILabel * address;
@property (nonatomic,strong)UIView * line;
@property (nonatomic,strong)UIView * bottomV;
-(UILabel*)setupLabelWithFont:(int)font textColor:(UIColor*)color text:(NSString*)text isBold:(BOOL)isBold;
-(UIButton*)setupBtnWithTitle:(NSString*)title font:(int)font textColor:(UIColor*)color selector:(SEL)selector;
@end
