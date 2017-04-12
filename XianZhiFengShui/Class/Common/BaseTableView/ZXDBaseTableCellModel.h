//
//  ZXDBaseTableCellModel.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/4/11.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 tableviewcell 的基类model
 */
@interface ZXDBaseTableCellModel : NSObject

@property (nonatomic, strong) id cellData;                      //cell的数据源
@property (nonatomic, assign) Class cellClass;                  //cell的Class
@property (nonatomic, weak)   id delegate;                      //cell的代理
@property (nonatomic, assign) CGFloat cellHeight;               //cell的高度，提前计算好

+ (instancetype)modelFromCellClass:(Class)cellClass cellHeight:(CGFloat)cellHeight cellData:(id)cellData;
- (instancetype)initWithCellClass:(Class)cellClass cellHeight:(CGFloat)cellHeight cellData:(id)cellData;
@end
