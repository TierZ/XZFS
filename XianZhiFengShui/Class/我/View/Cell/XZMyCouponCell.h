//
//  XZMyCouponCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/21.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

///优惠券
#import <UIKit/UIKit.h>
#import "MyCouponModel.h"
@interface XZMyCouponCell : UITableViewCell
-(void)refreshCellWithModel:(MyCouponModel*)model;
-(void)outOfData:(BOOL)isOut;//是否过期
@end
