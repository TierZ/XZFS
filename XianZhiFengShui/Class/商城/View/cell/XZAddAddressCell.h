//
//  XZAddAddressCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/14.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 添加地址 cell
 */
@interface XZAddAddressCell : UITableViewCell
-(void)refreshCellWithDic:(NSDictionary*)dic indexPath:(NSIndexPath*)path;
-(void)refreshContent:(NSString*)content;
@end
