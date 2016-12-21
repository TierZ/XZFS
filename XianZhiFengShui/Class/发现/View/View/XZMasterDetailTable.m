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



NSString * const MasterServiceCellId = @"MasterServiceCellId";
NSString * const MasterEvaluateCellId = @"MasterEvaluateCellId";
NSString * const MasterArticleCellId = @"MasterArticleCellId";

@implementation XZMasterDetailTable{
    NSIndexPath * tmpIndex;
    MasterDetailType _style;
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
    
}

#pragma mark tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"self.data = %@",self.data);
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
        case MasterInfoArticle:
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

-(UITableView *)table{
    if (!_table) {
        _table= [[UITableView alloc] init];
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
