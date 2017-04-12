//
//  XZMasterServiceCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/1/4.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZMasterModel.h"
#import "ZXDBaseTableViewCell.h"
/**
 大师端 我的服务项目
 */

typedef void(^ModifyMasterServiceBlock)(XZMasterModel * model,NSIndexPath * indexPath);
typedef void(^DeleteMasterServiceBlock)(XZMasterModel * model,NSIndexPath * indexPath);
@interface XZMasterServiceCell : ZXDBaseTableViewCell
//@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,strong)XZMasterModel * model;
@property (nonatomic,copy)ModifyMasterServiceBlock modifyBlock;
@property (nonatomic,copy)DeleteMasterServiceBlock deleteBlock;
-(void)modifyServiceWithBlock:(ModifyMasterServiceBlock)block;
-(void)deleteServiceWithBlock:(DeleteMasterServiceBlock)block;
@end
