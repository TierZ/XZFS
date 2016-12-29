//
//  XZTheMasterCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/10.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

// 大师cell


#import "XZFindCell.h"
#import "XZTheMasterModel.h"

typedef void(^AgreeMasterBlock)(XZTheMasterModel * model);

@interface XZTheMasterCell : XZFindCell
-(void)refreshMasterCellWithModel:(XZTheMasterModel*)model;
@property (nonatomic,copy)AgreeMasterBlock agreeBlock;
-(void)agreeMasterWithBlock:(AgreeMasterBlock)block;
@end
