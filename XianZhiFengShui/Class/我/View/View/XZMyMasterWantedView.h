//
//  XZMyMasterWantedView.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/18.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZRefreshTable.h"
#import "XZMyMasterVC.h"
/**
 我想约的大师
 */
@interface XZMyMasterWantedView : UIView
@property (nonatomic,strong)XZRefreshTable * hopeTable;//
@property (nonatomic,weak)XZMyMasterVC * weakSelfVC;
@end
