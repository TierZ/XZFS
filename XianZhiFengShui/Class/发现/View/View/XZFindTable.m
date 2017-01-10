//
//  XZFindTable.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/11.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZFindTable.h"
#import "XZTheMasterCell.h"
#import "XZLectureCell.h"
#import "XZThemeCell.h"


#import "XZThemeListVC.h"
#import "XZLectureDetailVC.h"
#import "XZMasterDetailVC.h"


NSString * const FindMasterCellId = @"FindMasterCellId";
NSString * const FindLectureCellId = @"FindLectureCellId";
NSString * const FindThemeCellId = @"FindThemeCellId";

@implementation XZFindTable{
    XZFindStyle _style;
    NSIndexPath * tmpIndex;
}

- (instancetype)initWithFrame:(CGRect)frame style:(XZFindStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
        [self drawTable];
        self.showLecturePrice = YES;
    }
    return self;
}

-(void)drawTable{
    self.table.frame = CGRectMake(0, 0, self.width, self.height);
    [self addSubview:self.table];
    
}

-(void)pointOfPraiseMasterWithBlock:(PointOfPraiseMasterBlock)block{
    self.block = block;
}

#pragma mark tableDelegatef
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellid = [self cellIdentifierWithStyle:_style];
    switch (_style) {
        case XZFindMaster:{
            XZTheMasterCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[XZTheMasterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
                }
            [cell refreshMasterCellWithModel:self.data [indexPath.row]];
            __weak typeof(self)weakSelf = self;
            [cell agreeMasterWithBlock:^(XZTheMasterModel *model) {
                if (weakSelf.block) {
                    weakSelf.block(model.masterCode);
                }
            }];
            return cell;
        }
            break;
    case XZFindLecture:{
            XZLectureCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[XZLectureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            }
            [cell showPrice:self.showLecturePrice];
        [cell openCollectionUserInterfaced:self.showLecturePrice];
            [cell refreshLectureCellWithModel:self.data [indexPath.row]];
            return cell;
        }
            break;
            
    case XZFindTheme:{
            XZThemeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[XZThemeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            }
            
            [cell refreshThemeCellWithModel:self.data [indexPath.row]];
            return cell;
        }
            break;

            
        default:
            break;
    }
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [self cellHeightWithStyle:_style indexPath:indexPath];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XZTheMasterModel * model = self.data [indexPath.row];
    
    switch (_style) {
        case XZFindMaster:
             [self.currentVC.navigationController pushViewController:[[XZMasterDetailVC alloc]initWithMasterCode:model.masterCode] animated:YES];
            break;
        case XZFindLecture:{
            XZTheMasterModel *model =  self.data [indexPath.row];
             [self.currentVC.navigationController pushViewController:[[XZLectureDetailVC alloc]initWithModel:model] animated:YES];
        }
            break;
        case XZFindTheme:{
            [self.currentVC.navigationController pushViewController:[[XZThemeListVC alloc]initWithTypeCode:@""] animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma  mark private

-(NSString*)cellIdentifierWithStyle:(XZFindStyle)style{
    switch (style) {
        case XZFindMaster:
            return FindMasterCellId;
            break;
        case XZFindLecture:
            return FindLectureCellId;
            break;
        case XZFindTheme:
            return FindThemeCellId;
            break;
        default:
            return @"";
            break;
    }
}

-(float)cellHeightWithStyle:(XZFindStyle)style indexPath:(NSIndexPath *)indexPath{
    switch (style) {
        case XZFindMaster:{
            UITableViewCell * cell = [self tableView:self.table cellForRowAtIndexPath:indexPath];
            return cell.height;
        }
            break;
        case XZFindLecture:
            return 103;
            break;
        case XZFindTheme:
            return 68;
            break;
        default:
            return 0;
            break;
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
