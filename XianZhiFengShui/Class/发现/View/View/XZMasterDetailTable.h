//
//  XZMasterDetailTable.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//


typedef enum : NSUInteger {
    MasterInfoServices = 0,//服务项目
    MasterInfoAbout,//关于大师
    MasterInfoEvaluate,//客户评价
    MasterInfoArticle,//大师文章
    MasterInfoOther,//其他
} MasterDetailType;

#import <UIKit/UIKit.h>

@interface XZMasterDetailTable : UIView<UITableViewDelegate,UITableViewDataSource>
- (instancetype)initWithFrame:(CGRect)frame style:(MasterDetailType)style;
@property (nonatomic,strong)UITableView * table;
@property (nonatomic,strong)NSMutableArray * data;
//@property (nonatomic,weak)XZFindVC * currentVC;
@end
