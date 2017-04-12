//
//  ZXDBaseTableCellModel.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/4/11.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import "ZXDBaseTableCellModel.h"

@implementation ZXDBaseTableCellModel
+ (instancetype)modelFromCellClass:(Class)cellClass cellHeight:(CGFloat)cellHeight cellData:(id)cellData{
    ZXDBaseTableCellModel * cellModel = [ZXDBaseTableCellModel new];
    cellModel.cellHeight = cellHeight;
    cellModel.cellData = cellData;
    cellModel.cellClass = cellClass;
    return cellModel;
}
- (instancetype)initWithCellClass:(Class)cellClass cellHeight:(CGFloat)cellHeight cellData:(id)cellData{
    return [ZXDBaseTableCellModel modelFromCellClass:cellClass cellHeight:cellHeight cellData:cellData];
}
@end
