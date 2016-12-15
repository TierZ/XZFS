//
//  XZJoinedThemeListCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/16.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//
/**
 我参与的话题
 */

#import <UIKit/UIKit.h>
#import "XZThemeListModel.h"


@interface XZJoinedThemeListCell : UITableViewCell
@property (nonatomic,strong)XZThemeListModel * model;
@property (nonatomic,strong)NSIndexPath * indexPath;
@end
