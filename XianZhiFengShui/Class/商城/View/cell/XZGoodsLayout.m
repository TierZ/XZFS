//
//  XZGoodsLayout.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/8.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZGoodsLayout.h"

@implementation XZGoodsLayout


- (id)initWith{
    self = [super init];
    if (self) {
        
        //设置每一个Cell的尺寸
        self.itemSize = CGSizeMake(200, 200);
        //设置滚动方向
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        //设置每行的间距
        self.minimumLineSpacing = 20;
        //设置collectionView内容据上下左右的距离
        self.sectionInset = UIEdgeInsetsMake(20, 20, 0, 20);
      }
    return self;
}


@end
