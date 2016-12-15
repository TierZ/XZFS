//
//  XZGoodsCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/8.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZGoodsModel.h"
/**
 宝贝cell
 */
@interface XZGoodsCell : UICollectionViewCell
-(void)refreshCellWithModel:(XZGoodsModel*)model;
-(void)hideExpress:(BOOL)isHide;
@end
