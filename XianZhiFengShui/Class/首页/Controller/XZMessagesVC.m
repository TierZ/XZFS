//
//  XZMessagesVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/1.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//



#import "XZMessagesVC.h"
#import "XZMessageListCell.h"
#import "XZMessageListVC.h"



@interface XZMessagesVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * messageList;
@property (nonatomic,strong)NSMutableArray * messages;
@end

@implementation XZMessagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"消息中心";
    self.messageList.frame = CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT-XZFS_STATUS_BAR_H);
    [self.mainView addSubview:self.messageList];
    [self loadData];

}




-(void)loadData{
    for (int i = 0; i<3; i++) {
        XZMessageModel * model = [[XZMessageModel alloc]init];
        model.icon = @"pic1.jpg";
        model.time = @"2016-10-11 13:20";
        model.title = @"先知活动";
        model.detail = @"学习iOS开发一般都是从UI开始的，从只知道从IB拖控件，到知道怎么在方法里写代码，然后会显示什么样的视图，产生什么样的事件，等等";
        [self.messages addObject:model];
    }
    [self.messageList reloadData];
}
#pragma mark tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * messageCellId = @"messageCellId";
    XZMessageListCell * messageCell = [tableView dequeueReusableCellWithIdentifier:messageCellId];
    if (!messageCell) {
        messageCell = [[XZMessageListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageCellId];
    }
    messageCell.model = self.messages[indexPath.row];
    if (indexPath.row==self.messages.count-1) {
        [messageCell hideBottomLine];
    }
    return messageCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.messages[indexPath.row];
    return [self.messageList cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZMessageListCell class] contentViewWidth:SCREENWIDTH];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[[XZMessageListVC alloc]init] animated:YES];

}

#pragma mark getter
-(UITableView *)messageList{
    if (!_messageList) {
        _messageList = [[UITableView alloc] init];
        _messageList.backgroundColor = self.mainView.backgroundColor;
        _messageList.dataSource = self;
        _messageList.delegate = self;
        _messageList.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView * footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        _messageList.tableFooterView = footerView;
    }
    return _messageList;
}

-(NSMutableArray *)messages{
    if (!_messages) {
        _messages = [NSMutableArray array];
    }
    return _messages;
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
