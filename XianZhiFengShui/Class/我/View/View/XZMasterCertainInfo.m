//
//  XZMasterCertainInfo.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/9.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMasterCertainInfo.h"

@implementation XZMasterCertainInfo{
    NSDictionary * _dic;
    UITableView * _infoTable;
    NSMutableArray * infoArray;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        infoArray = [NSMutableArray array];
        [self setupInfo];
    }
    return self;
}

-(void)refreshViewWithDic:(NSDictionary*)dic{
    [infoArray addObject:@{@"title":@"真实姓名",@"detail":[dic objectForKey:@"name"]}];
    [infoArray addObject:@{@"title":@"手机",@"detail":[dic objectForKey:@"phone"]}];
    [infoArray addObject:@{@"title":@"邮箱",@"detail":[dic objectForKey:@"email"]}];
    [infoArray addObject:@{@"title":@"常驻城市",@"detail":[dic objectForKey:@"city"]}];
    [infoArray addObject:@{@"title":@"任职机构",@"detail":[dic objectForKey:@"location"]}];
    [infoArray addObject:@{@"title":@"职位头衔",@"detail":[dic objectForKey:@"jobTitle"]}];
    [_infoTable reloadData];
}

-(void)setupInfo{
    _infoTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
    _infoTable.dataSource = self;
    _infoTable.delegate = self;
    [self addSubview:_infoTable];
    
    UIView * footView = [UIView new];
    _infoTable.tableFooterView = footView;
}

#pragma mark table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return infoArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [[infoArray objectAtIndex:indexPath.row]objectForKey:@"title"];
    cell.detailTextLabel.text = [[infoArray objectAtIndex:indexPath.row]objectForKey:@"detail"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}


@end
