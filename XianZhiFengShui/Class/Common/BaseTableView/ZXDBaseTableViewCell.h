//
//  ZXDBaseTableViewCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/4/11.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, ZXDBaseCellType) {
    ZXDBaseCellNone,       //上下线都隐藏
    ZXDBaseCellAtFirst,    //下线隐藏,按照group样式即第一个cell,originx=0
    ZXDBaseCellAtMiddle,   //下线隐藏,按照group样式即中间cell,originx=separateLineOffset
     ZXDBaseCellAtLast,     //上下线都显示,按照group样式即最后一个cell,上线originx=separateLineOffset 下线originx=0
     ZXDBaseCellNormal,     //下线隐藏,按照plain样式,originx=separateLineOffset
     ZXDBaseCellSingle,     //上下线都显示，originx=0
};


/**
 tableviewcell 基类
 */
@interface ZXDBaseTableViewCell : UITableViewCell
/**
 *  分隔线的颜色值,默认为(208,208,208)
 */
@property (nonatomic,strong) UIColor *lineColor;

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) id zxdCellData;

/**
 *  分割线了偏移量,默认是0
 */
@property(nonatomic, assign) NSInteger separateLineOffset;

/**
 *  分隔线是上,还是下,还是中间的
 */
@property(nonatomic, assign) ZXDBaseCellType cellType;

/**
 *  上横线
 */
@property (strong, nonatomic)  UIView *topLineView;

/**
 *  下横线,都是用来分隔cell的
 */
@property (strong, nonatomic)  UIView *bottomLineView;


+ (CGFloat)cellHeightWithCellData:(id)cellData;

+ (CGFloat)cellHeightWithCellData:(id)cellData boundWidth:(CGFloat)width;


- (void)setCellData:(id)zxdCellData;


- (void)setSeperatorLine:(NSIndexPath *)indexPath numberOfRowsInSection: (NSInteger)numberOfRowsInSection;
@end
