//
//  XZMyMasterCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/16.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

/**
 我的大师（基类）
 */

#import <UIKit/UIKit.h>
#import "XZTheMasterModel.h"

@interface XZMyMasterCell : UITableViewCell
@property (nonatomic,strong)UIImageView * photo;
@property (nonatomic,strong)UILabel * name;
@property (nonatomic,strong)UILabel * levelLab;
@property (nonatomic,strong)UILabel * timeLab;
@property (nonatomic,strong)UILabel * service;
@property (nonatomic,strong)UILabel * price;
@property (nonatomic,strong)UIImageView * levelIv;
@property (nonatomic,strong)UIImageView * timeIv;

@end
