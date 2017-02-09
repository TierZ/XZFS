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
typedef NS_ENUM(NSUInteger, YYYCellBtnType) {
    YYYCellBtnSendMsg,//发送消息
    YYYCellBtnModify,//修改约见时间
    YYYCellBtnCancel,//取消约见
    YYYCellBtnOk//完成约见
};

typedef void(^YYYCellBtnActionBlock)(XZMasterOrderModel * model,NSIndexPath * indexPath,YYYCellBtnType type);


@interface XZYYYCell : XZMasterOrderCell
@property (nonatomic,strong)XZMasterOrderModel * model;
@property (nonatomic,strong)NSIndexPath * indexPath;
@property (nonatomic,copy)YYYCellBtnActionBlock block;
-(void)yyycellBtnClickWithBlock:(YYYCellBtnActionBlock)block;
@end
