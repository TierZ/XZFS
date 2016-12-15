//
//  XZMyEvaluateVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/17.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyEvaluateVC.h"
#import "XZRefreshTable.h"
#import "XZMyEvaluateCell.h"
#import "XZMarkScoreVC.h"
@interface XZMyEvaluateVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)XZRefreshTable * evaluateTable;

@end

@implementation XZMyEvaluateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"我的评价";
    [self setupTable];
    [self showData];
}

-(void)setupTable{
    self.evaluateTable = [[XZRefreshTable alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, XZFS_MainView_H) style:UITableViewStylePlain];
    self.evaluateTable.delegate = self;
    self.evaluateTable.dataSource = self;
    [self.mainView addSubview:self.evaluateTable];
    
    UIView * footv = [UIView new];
    self.evaluateTable.tableFooterView = footv;
}

//假数据
-(void)showData{
    for (int i = 0; i<10; i++) {
        XZMyEvaluateModel * model = [[XZMyEvaluateModel alloc]init];
        model.photo = @"http://file.shagualicai.cn/201610/09/pic/pic_14759978965900.jpg";
        model.name = @"张三丰";
        model.time = @"2016-11-17";
        model.service = @"服务项目：商务风水-办公大楼选址";
        model.evaluate =@"可见，代码复用也是分类别的，如果当初只是出于代码复用的目的而不区分类别和场景，就采用继承是不恰当的。我们应当考虑以上3点要素看是否符合，才能决定是否使用继承。就目前大多数的开发任务来看，继承出现的场景不多，主要还是代码复用的场景比较多，然而通过组合去进行代码复用显得要比继承麻烦一些，因为组合要求你有更强的抽象能力，继承则比较符合直觉。然而从未来可能产生的需求变化和维护成本来看，使用组合其实是很值得的。另外，当你发现你的继承超过2层的时候，你就要好好考虑是否这个继承的方案了，第三层继承正是滥用的开端。确定有必要之后，再进行更多层次的继承。";
        if (i%3==0) {
            model.name = @"龙虎山茅山道术第38代传人";
            model.evaluate = @"相对于 CPU 来说，GPU 能干的事情比较单一：接收提交的纹理（Texture）和顶点描述（三角形），应用变换（transform）、混合并渲染，然后输出到屏幕上。通常你所能看到的内容，主要也就是纹理（图片）和形状（三角模拟的矢量图形）两类";
        }
        [self.evaluateTable.dataArray addObject:model];
    }
    [self.evaluateTable reloadData];
}
#pragma mark table 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.evaluateTable.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * evaluateCellId = @"evaluateCellId";
    XZMyEvaluateCell * cell = [tableView dequeueReusableCellWithIdentifier:evaluateCellId];
    if (!cell) {
        cell = [[XZMyEvaluateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:evaluateCellId];
    }
    cell.model = self.evaluateTable.dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   id model = self.evaluateTable.dataArray[indexPath.row];
    return [self.evaluateTable cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZMyEvaluateCell class] contentViewWidth:SCREENWIDTH];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XZMarkScoreVC * markVC = [[XZMarkScoreVC alloc]init];
    [self.navigationController pushViewController:markVC animated:YES];
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
