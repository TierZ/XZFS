//
//  XZMessageListVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/1.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMessageListVC.h"
#import "XZMessageDetailListCell.h"
@interface XZMessageListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * listTable;
@property (nonatomic,strong)NSMutableArray * lists;
@end

@implementation XZMessageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"服务通知";
    self.listTable.frame = CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT-XZFS_STATUS_BAR_H);
    [self.mainView addSubview:self.listTable];
    [self loadData];
    // Do any additional setup after loading the view.
}

-(void)loadData{
    for (int i = 0; i<3; i++) {
        NSMutableArray * array = [NSMutableArray array];
        XZMessageModel  * model = [[XZMessageModel alloc]init];
        model.content = @"亲爱的用户:\n 您已经是我们的高级VIP了，您碉堡了，再强调一遍，您已经碉堡了......";
        [array addObject:model];
        [self.lists addObject:array];
    }
    [self.listTable reloadData];
    NSLog(@"self.list = %@",self.lists);
}

#pragma mark table 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.lists.count>0) {
         return self.lists.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.lists[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * messageiList = @"messageList";
    XZMessageDetailListCell * cell = [tableView dequeueReusableCellWithIdentifier:messageiList];
    if (!cell) {
        cell = [[XZMessageDetailListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageiList];
    }
    cell.model = self.lists[indexPath.section][indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.lists[indexPath.section][indexPath.row];
    return [self.listTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZMessageDetailListCell class] contentViewWidth:SCREENWIDTH];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [UIView new];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 27.5);
    
    UILabel * timeLab = [UILabel new];
    timeLab.backgroundColor = XZFS_HEX_RGB(@"#B5B6B6");
    timeLab.text = @"2016-10-29";
    timeLab.textColor = XZFS_TEXTBLACKCOLOR;
    timeLab.font = XZFS_S_FONT(14);
    timeLab.frame = CGRectMake(0, 7, SCREENWIDTH, 16);
    [timeLab sizeToFit];
    timeLab.centerX = headerView.centerX;
    [headerView addSubview:timeLab];
    
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 27.5;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y > 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else {
        if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

#pragma mark getter
-(UITableView *)listTable{
    if (!_listTable) {
        _listTable = [[UITableView alloc] init];
        _listTable.backgroundColor = self.mainView.backgroundColor;
        _listTable.dataSource = self;
        _listTable.delegate = self;
        
        UIView * footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        _listTable.tableFooterView = footerView;
    }
    return _listTable;
}

-(NSMutableArray *)lists{
    if (!_lists) {
        _lists = [NSMutableArray array];
    }
    return _lists;
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
