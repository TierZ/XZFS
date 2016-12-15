//
//  XZShoppingCartHeaderView.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/12.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZGoodsModel.h"

/**
 购物车 头部
 */
@interface XZShoppingCartHeaderView : UITableViewHeaderFooterView
@property (nonatomic,strong)XZGoodsModel * model;
@end
