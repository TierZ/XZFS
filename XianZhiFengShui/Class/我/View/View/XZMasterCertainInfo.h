//
//  XZMasterCertainInfo.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/9.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

/**
 成为大师 信息确认
 */
#import <UIKit/UIKit.h>

@interface XZMasterCertainInfo : UIView<UITableViewDelegate,UITableViewDataSource>
-(instancetype)initWithFrame:(CGRect)frame;
-(void)refreshViewWithDic:(NSDictionary*)dic;
@end
