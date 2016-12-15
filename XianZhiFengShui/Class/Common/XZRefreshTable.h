//
//  XZRefreshTable.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/27.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//



#import <UIKit/UIKit.h>

/**
 带刷新 的 tableview

 @param page      页码
 @param isRefresh 是否为刷新
 */
typedef void(^RefreshListBlock)(int page,BOOL isRefresh);
@interface XZRefreshTable : UITableView
@property (nonatomic,copy)RefreshListBlock block;
@property (nonatomic,assign)int row;
@property (nonatomic,strong)NSMutableArray * dataArray;
-(void)refreshListWithBlock:(RefreshListBlock)block;
-(void)endRefreshHeader;
-(void)endRefreshFooter;
@end
