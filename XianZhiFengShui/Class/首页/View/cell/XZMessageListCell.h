//
//  XZMessageListCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/1.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

/**
 消息首页cell
 */
#import <UIKit/UIKit.h>
#import "XZMessageModel.h"
@interface XZMessageListCell : UITableViewCell
@property (nonatomic,strong)XZMessageModel * model;
-(void)hideBottomLine;
@end
