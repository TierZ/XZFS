//
//  XZLectureCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/12.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

// 发现 讲座cell
#import "XZFindCell.h"
#import "XZTheMasterModel.h"

@interface XZLectureCell : XZFindCell
-(void)refreshLectureCellWithModel:(XZTheMasterModel*)model;
-(void)showPrice:(BOOL)isShow;//是否显示 价格 剩余 和 收藏
-(void)openCollectionUserInterfaced:(BOOL)isOpen;//收藏按钮是否可点击
@end
