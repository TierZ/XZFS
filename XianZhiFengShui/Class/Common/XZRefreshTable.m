//
//  XZRefreshTable.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/27.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZRefreshTable.h"

@implementation XZRefreshTable

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setupRefresh];
    }
    return self;
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    
    self.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self.mj_header beginRefreshing];
        self.row = 1;
        if (self.block) {
            self.block(1,YES);
        }
    }];
    
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.mj_footer beginRefreshing];
        self.row++;
        if (self.block) {
            self.block(self.row,NO);
        }
        
    }];
}

-(void)refreshListWithBlock:(RefreshListBlock)block{
    self.block = block;
}

-(void)endRefreshHeader{
    [self.mj_header endRefreshing];
}
-(void)endRefreshFooter{
    [self.mj_footer endRefreshingWithNoMoreData];
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
