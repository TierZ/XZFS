//
//  XZDYYCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/6.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//


#import "XZMasterOrderCell.h"
#import "XZMasterModel.h"
/**
 大师端 我的订单 待预约
 */

typedef void(^AppointNowBlock)(XZMasterOrderModel * model,NSIndexPath * index);
typedef void(^SubmitAppointTimeBlock)(XZMasterOrderModel * model,NSIndexPath * index);

@interface XZDYYCell : XZMasterOrderCell
@property (nonatomic,strong)XZMasterOrderModel * model;
@property (nonatomic,strong)NSIndexPath * indexPath;
@property (nonatomic,copy)AppointNowBlock appointNowBlock;
@property (nonatomic,copy)SubmitAppointTimeBlock submitAppointTimeBlock;
-(void)appointNowWithBlock:(AppointNowBlock)block;
-(void)submitAppointTimeWithBlock:(SubmitAppointTimeBlock)block;
@end
