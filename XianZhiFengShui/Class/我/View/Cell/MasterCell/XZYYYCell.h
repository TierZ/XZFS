//
//  XZYYYCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/6.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterOrderCell.h"
#import "XZMasterModel.h"
/**
 大师端 我的订单 已预约
 */
@interface XZYYYCell : XZMasterOrderCell
@property (nonatomic,strong)XZMasterOrderModel * model;
@property (nonatomic,strong)NSIndexPath * indexPath;
@end
