//
//  XZAddressCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/12.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZGoodsModel.h"

/**
 地址列表cell
 */
@interface XZAddressCell : UITableViewCell
@property (nonatomic,strong)XZAddressModel*model;
-(void)hideEditBar:(BOOL)isHide;
@end
