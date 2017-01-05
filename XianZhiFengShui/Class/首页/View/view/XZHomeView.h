//
//  XZHomeView.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/24.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZTheMasterModel.h"
#import "XZRefreshTable.h"
@interface XZHomeView : UIView
@property (nonatomic,strong)XZRefreshTable * xzHomeTable;
@property (nonatomic,strong)NSMutableArray * xzHomeData;

-(void)refreshHeadView;
@end
