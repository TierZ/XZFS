//
//  XZMasterDetailTable.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterDetailTable.h"

#import "XZMasterInfoArticleCell.h"
#import "XZMasterInfoEvaluateCell.h"
#import "XZMasterServicesCell.h"

#import "XZArticleDetailVC.h"
#import "XZPayVC.h"
#import "XZLoginVC.h"


NSString * const MasterServiceCellId = @"MasterServiceCellId";
NSString * const MasterEvaluateCellId = @"MasterEvaluateCellId";
NSString * const MasterArticleCellId = @"MasterArticleCellId";

@interface XZMasterDetailTable ()
 @property (nonatomic,assign)MasterDetailType style;
@end
@implementation XZMasterDetailTable{
    NSIndexPath * tmpIndex;
   
}

- (instancetype)initWithFrame:(CGRect)frame style:(MasterDetailType)style
{
    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
        [self drawTable];
    }
    return self;
}

-(void)drawTable{
    self.table.frame = CGRectMake(0, 0, self.width, self.height);
    [self addSubview:self.table];
    [self setupRefresh];
}

-(void)setupRefresh{
    
    __weak typeof(self)weakSelf = self;
    [self.table refreshListWithBlock:^(int page, BOOL isRefresh) {
        if (weakSelf.block) {
            weakSelf.block(weakSelf.style,page,isRefresh);
        }
    }];

}
-(void)refreshDataWithBlock:(MasterDetailRefreshBlock)block{
    self.block = block;
}

#pragma mark tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellid = [self cellIdentifierWithStyle:_style];
    switch (_style) {
        case MasterInfoServices:{
            XZMasterServicesCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[XZMasterServicesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            }
            BOOL isLogin = [[GETUserdefault(@"userInfos")objectForKey:@"isLogin"]boolValue];
            __weak typeof(self)weakSelf = self;
                [cell appointWithBlock:^(XZMasterInfoServiceModel *model) {
                    if (isLogin) {
                        XZPayVC * payVC = [[XZPayVC alloc]initWithPayStyle:XZMasterPay];
                        [weakSelf.currentVC.navigationController pushViewController:payVC animated:YES];
                    }else{
                        [ToastManager showToastOnView:self position:CSToastPositionCenter flag:NO message:@"还未登录，请先去登录"];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[XZLoginVC alloc]init]];
                            nav.navigationBar.hidden = YES;
                            [weakSelf.currentVC.navigationController presentViewController:nav animated:YES completion:nil];
                        });
                    }
                }];
            cell.model =self.data [indexPath.row];
            return cell;
        }
            break;
        case MasterInfoEvaluate:{
            XZMasterInfoEvaluateCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[XZMasterInfoEvaluateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            }
            
           cell.model =self.data [indexPath.row];
            return cell;
        }
            break;
            
        case MasterInfoArticle:{
            XZMasterInfoArticleCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[XZMasterInfoArticleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            }
            
           cell.model =self.data [indexPath.row];
            return cell;
        }
            break;
        default:{
            return nil;
        }
            break;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self cellHeightWithStyle:_style indexPath:indexPath];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (_style) {
        case MasterInfoServices:
            
            break;
        case MasterInfoEvaluate:
            
            break;
        case MasterInfoArticle:{
            XZMasterInfoArticleModel * model = self.data[indexPath.row];
            [self.currentVC.navigationController pushViewController:[[XZArticleDetailVC alloc]initWithBizCode:model.bizCode] animated:YES];
            NSLog(@"bizcode = %@",model.bizCode);
        }
            break;
            
        default:
            break;
    }
    
}

#pragma  mark private

-(NSString*)cellIdentifierWithStyle:(MasterDetailType)style{
    switch (style) {
        case MasterInfoServices:
            return MasterServiceCellId;
            break;
        case MasterInfoArticle:
            return MasterArticleCellId;
            break;
        case MasterInfoEvaluate:
            return MasterEvaluateCellId;
            break;
        default:
            return @"";
            break;
    }
}

-(float)cellHeightWithStyle:(MasterDetailType)style indexPath:(NSIndexPath *)indexPath{
    id model = self.data[indexPath.row];
    
    if (style==MasterInfoServices) {
         return [self.table cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZMasterServicesCell class] contentViewWidth:SCREENWIDTH];
    }else if (style==MasterInfoEvaluate){
         return [self.table cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZMasterInfoEvaluateCell class] contentViewWidth:SCREENWIDTH];
    }else if (style==MasterInfoArticle){
         return [self.table cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZMasterInfoArticleCell class] contentViewWidth:SCREENWIDTH];
    }else{
        return 0;
    }
   
   
}

#pragma mark getter

-(XZRefreshTable *)table{
    if (!_table) {
        _table= [[XZRefreshTable alloc] init];
        _table.backgroundColor = [UIColor clearColor];
        _table.dataSource = self;
        _table.delegate = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView * footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        _table.tableFooterView = footerView;
    }
    return _table;
}

-(NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

@end
