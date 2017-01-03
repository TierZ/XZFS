//
//  XZHelpAndFeedbackVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZHelpAndFeedbackVC.h"
#import "XZUserCenterService.h"

@interface XZHelpAndFeedbackVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * helpTable;
@property (nonatomic,strong)NSArray * dataArray;
@end

@implementation XZHelpAndFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"帮助与反馈";
     self.mainView.backgroundColor = XZFS_HEX_RGB(@"#F0EEEF");
    [self.view addSubview:self.helpTable];
    self.helpTable.frame = CGRectMake(0, XZFS_STATUS_BAR_H+7, SCREENWIDTH, SCREENHEIGHT-XZFS_STATUS_BAR_H-7);
    [self.helpTable reloadData];
    
    [self requestFeedBackList];
}

#pragma mark 网络
-(void)requestFeedBackList{
    XZUserCenterService * feedbackListService = [[XZUserCenterService alloc]initWithServiceTag:XZHelpAndFeedbackListTag];
    feedbackListService.delegate = self;
    [feedbackListService feedbackListWithCityCode:@"11000" view:self.view];
}
-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    NSLog(@"successhandele = %@",succeedHandle);
}
-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{

}
#pragma mark table 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * helpCellId = @"helpCellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:helpCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:helpCellId];
    }
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(22, 43.5, SCREENWIDTH-44, 0.5)];
    line.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
    [cell addSubview:line];
    if (indexPath.row==self.dataArray.count-1) {
        line.hidden = YES;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [self.dataArray[indexPath.row]objectForKey:@"title"];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString * className = [dic objectForKey:@"class"];
     Class  currentClass = NSClassFromString(className);
    BaseContentController * jumpVC = [[currentClass alloc]init];
    jumpVC.titelLab.text = [dic objectForKey:@"title"];
    [self.navigationController pushViewController:jumpVC animated:YES];
}

#pragma mark getter
-(UITableView *)helpTable{
    if (!_helpTable) {
        _helpTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _helpTable.backgroundColor = XZFS_HEX_RGB(@"#F0EEEF");
        _helpTable.dataSource = self;
        _helpTable.delegate = self;
        _helpTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
        
        UIView * footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        _helpTable.tableFooterView = footerView;
    }
    return _helpTable;
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@{@"title":@"在线客服",@"class":@"XZOnLineServiceVC"},@{@"title":@"关于先知",@"class":@"XZAboutXianZhiVC"},@{@"title":@"使用帮助",@"class":@"XZHelpVC"},@{@"title":@"用户反馈",@"class":@"XZFeedBackVC"}];
    }

    return _dataArray;
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
