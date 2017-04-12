//
//  ZXDTableViewConverter.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/4/11.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 tableview 中间转换器
 */

typedef NS_ENUM(NSUInteger, ZXDTableViewConvertType) {
    /*默认模式，使用注册方式处理tableView的一些协议
    默认使用以下方法:
    -(void)registTableviewWithMethod:(SEL)selector Params:(paramsBlock)block
     */
   ZXDTableViewConverter_Register = 0,
    
    /*响应默认，优先使用 加载tableView的ViewController 中的tableView的协议
    使用tableview 代理的原生方法 （如果设置了Response类型 registTableviewWithMethod:selector :block  方法将失效）
     */
    ZXDTableViewConverter_Response,
};


typedef id(^paramsBlock) (NSArray*params);//参数数组

@interface ZXDTableViewConverter : NSObject<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign)ZXDTableViewConvertType convertType;

/**
 初始化 转换器

 @param carrier tableview载体
 @param dataSource 数据
 @return ZXDTableViewConverter 实例
 */
- (instancetype)initWithTableViewCarrier:(id)carrier dataSource:(NSMutableArray*)dataSource;

/**
 调用 tableview 的代理方法
 @param selector tableview代理方法
 @param block 代理方法的参数
 */
-(void)registTableviewWithMethod:(SEL)selector Params:(paramsBlock)block;
@end

@class ZXDBaseTableViewCell;
@interface UITableView (ZXDIdentificerCell)
-(ZXDBaseTableViewCell*)setupCellWithIndexPath:(NSIndexPath*)indexPath cellClass:(Class)cellClass;


@end

