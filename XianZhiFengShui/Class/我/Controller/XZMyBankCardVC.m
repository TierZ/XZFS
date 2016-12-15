//
//  XZMyBankCardVC.m
//  XianZhiFengShui
//
//  Created by 左晓东 on 16/11/17.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyBankCardVC.h"
#import "XZRefreshTable.h"
#import "XZMyBankCardCell.h"
#import "XZAddBankCardVC.h"
@interface XZMyBankCardVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)XZRefreshTable * bankCardTable;
@property (nonatomic,strong)NSMutableArray * bankCards;
@end

@implementation XZMyBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"我的银行卡";
    [self setupTable];
    [self setupData];
}
#pragma mark setup
-(void)setupTable{

    self.bankCardTable.frame = CGRectMake(0, 0, SCREENWIDTH, XZFS_MainView_H);
    self.bankCardTable.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:self.bankCardTable];
    

}

-(UIView*)setupFootView{
    UIView * footV = [UIView new];
    footV.backgroundColor = [UIColor clearColor];
    footV.frame = CGRectMake(0, 0, SCREENWIDTH, 109);
    
    UIButton * addBankCard = [UIButton buttonWithType:UIButtonTypeCustom];
    addBankCard.frame = CGRectMake(18, 32, footV.width-36, 45);
    addBankCard.backgroundColor = XZFS_TEXTORANGECOLOR;
    [addBankCard setTitle:@"添加银行卡" forState:UIControlStateNormal];
    [addBankCard setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBankCard.titleLabel.font = XZFS_S_FONT(18);
    [addBankCard addTarget:self action:@selector(addBankCard:) forControlEvents:UIControlEventTouchUpInside];
    addBankCard.layer.masksToBounds = YES;
    addBankCard.layer.cornerRadius = 5;
    [footV addSubview:addBankCard];
    
    return footV;
}

#pragma mark 假数据

-(void)setupData{
    for (int i = 0; i<5; i++) {
        XZBankCardModel * model = [[XZBankCardModel alloc]init];
        model.bankCardUrl = @"";
        model.cardName = @"中国银行  储蓄卡";
        model.cardNum = @"尾号8361";
        [self.bankCards addObject:model];
    }
    NSLog(@"bankcards = %@",self.bankCards);
    [self.bankCardTable reloadData];
}

-(void)addBankCard:(UIButton*)sender{
    [self.navigationController pushViewController:[[XZAddBankCardVC alloc]init] animated:YES];
    NSLog(@"添加银行卡");
}


#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bankCards.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * bankCardCellId = @"bankCardCellId";
    XZMyBankCardCell * cell = [tableView dequeueReusableCellWithIdentifier:bankCardCellId];
    if (!cell) {
        cell = [[XZMyBankCardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bankCardCellId];
    }
    cell.model = self.bankCards[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    return  [self setupFootView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 109;
}
#pragma mark getter

-(XZRefreshTable *)bankCardTable{
    if (!_bankCardTable) {
        _bankCardTable = [[XZRefreshTable alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _bankCardTable.delegate = self;
        _bankCardTable.dataSource = self;
        UIView * footV = [UIView new];
        _bankCardTable.tableFooterView = footV;
    }
    return _bankCardTable;
}

-(NSMutableArray *)bankCards{
    if (!_bankCards) {
        _bankCards = [NSMutableArray array];
    }
    return _bankCards;
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
