//
//  XZHelpVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/23.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZHelpVC.h"

@interface XZHelpVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * helpTable;
@property (nonatomic,strong)NSMutableArray * helps;
@end

@implementation XZHelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showData];
    self.helpTable.frame = CGRectMake(0, 0, SCREENWIDTH, XZFS_MainView_H);
    [self.mainView addSubview:self.helpTable];
    [self.helpTable reloadData];
    
 
    
}
-(void)showData{
    for (int i = 0; i<4; i++) {
        NSDictionary * dic = @{@"title":@"[先知]",@"data":@[@"[先知]是什么",@"大师来自哪里",@"约见流程",@"约见规范"]};
        [self.helps addObject:dic];
    }
}


#pragma mark table 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.helps.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.helps[section]objectForKey:@"data"]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"helpCellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.helps[indexPath.section]objectForKey:@"data"][indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headV = [UIView new];
    headV.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
    headV.frame = CGRectMake(0, 0, SCREENWIDTH, 40);
    UILabel * title = [UILabel new];
    title.textColor = XZFS_TEXTBLACKCOLOR;
    title.font = XZFS_S_FONT(13);
    title.frame = CGRectMake(27, 17, 200, 13);
    title.text = [self.helps[section]objectForKey:@"title"];
    [headV addSubview:title];
    return headV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(UITableView *)helpTable{
    if (!_helpTable) {
        _helpTable = [[UITableView alloc] init];
        _helpTable.backgroundColor = [UIColor whiteColor];
        _helpTable.dataSource = self;
        _helpTable.delegate = self;
    
        UIView * footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        _helpTable.tableFooterView = footerView;
    }
    return _helpTable;
    
}
-(NSMutableArray *)helps{
    if (!_helps) {
        _helps = [NSMutableArray array];
    }
    return _helps;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
