//
//  XZMyMasterInProgressCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/16.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

/**
 我约见的大师，（进行中）
 */

#import <UIKit/UIKit.h>
#import "XZMyMasterCell.h"

typedef void(^PrivateMessageBlock)(XZTheMasterModel * model);//私信
typedef void(^CancelBlock)(XZTheMasterModel * model);//取消
typedef void(^ModifyBlock)(XZTheMasterModel * model);//修改
@interface XZMyMasterInProgressCell : XZMyMasterCell
@property (nonatomic,strong)XZTheMasterModel * model;
@property (nonatomic,copy)PrivateMessageBlock privateBlock;
@property (nonatomic,copy)ModifyBlock modifyBlock;
@property (nonatomic,copy)CancelBlock cancelBlock;

-(void)messageWithBlock:(PrivateMessageBlock)block;
-(void)cancelWithBlock:(CancelBlock)block;
-(void)modifyWithBlock:(ModifyBlock)block;

@end
