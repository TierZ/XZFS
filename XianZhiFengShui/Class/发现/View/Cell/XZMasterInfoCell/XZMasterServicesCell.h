//
//  XZMasterServicesCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

// 大师详情 大师服务项目
#import "XZMasterInfoBaseCel.h"
typedef void(^AppointmentBlock)(XZMasterInfoServiceModel * model);
@interface XZMasterServicesCell : XZMasterInfoBaseCel
@property (nonatomic,strong)XZMasterInfoServiceModel * model;
@property (nonatomic,copy)AppointmentBlock appointBlock;
-(void)appointWithBlock:(AppointmentBlock)block;
@end
