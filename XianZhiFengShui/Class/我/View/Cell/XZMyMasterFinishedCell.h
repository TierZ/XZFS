//
//  XZMyMasterFinishedCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/16.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

/**
 我约见的大师，（已约见）
 */

#import <UIKit/UIKit.h>
#import "XZMyMasterCell.h"
typedef void(^EvaluateMasterBlock)(XZTheMasterModel * model);//修改
@interface XZMyMasterFinishedCell : XZMyMasterCell
@property (nonatomic,strong)XZTheMasterModel * model;
@property (nonatomic,copy)EvaluateMasterBlock block;

-(void)evaluateMasterWithBlock:(EvaluateMasterBlock)block;
@end
