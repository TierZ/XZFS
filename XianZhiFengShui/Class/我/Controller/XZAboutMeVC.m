//
//  XZAboutMeVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/8.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZAboutMeVC.h"
#import "XZAboutMeHeadView.h"
#import "BaseLoginController.h"
#import "XZLoginVC.h"
#import "XZEditInfoVC.h"
#import "XZMyCouponVC.h"

@interface XZAboutMeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * mySelfTable;
@property (nonatomic,strong)NSArray * listArray;
@end

@implementation XZAboutMeVC{
    XZAboutMeHeadView * tableHead;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    __weak typeof(self)weakSelf = self;
    [tableHead editInfoWithBlock:^{
        XZEditInfoVC * editVC = [[XZEditInfoVC alloc]init];
        if ([editVC respondsToSelector:@selector(setIsUserLogin:)]) {
            if (editVC.isUserLogin) {
                editVC.titelLab.text = @"编辑资料";
                [weakSelf.navigationController pushViewController:editVC animated:YES];
            }else{
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[XZLoginVC alloc]init]];
                nav.navigationBar.hidden = YES;
                [weakSelf.navigationController presentViewController:nav animated:YES completion:nil];
            }
        }else{
            [weakSelf.navigationController pushViewController:editVC animated:YES];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"我";
     self.view.backgroundColor = [UIColor whiteColor];
    [self initNavi];
    [self initTable];
    [self initData];
    [self.mySelfTable reloadData];
    
}

-(void)initNavi{
    self.navView.hidden = YES;
    self.navView.backgroundColor = XZFS_HEX_RGB(@"#FE5100");
    self.baseLineView.backgroundColor = XZFS_HEX_RGB(@"#FE5100");
}
-(void)initTable{
    self.mySelfTable.frame = CGRectMake(0, 0, SCREENWIDTH,SCREENHEIGHT-XZFS_Bottom_H );
    self.mainView.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
    [self.view addSubview:self.mySelfTable];
    
     tableHead = [[XZAboutMeHeadView alloc]initWithFrame:CGRectMake(0, 0, self.mySelfTable.width, 185)];
    tableHead.backgroundColor = XZFS_HEX_RGB(@"#FE5100");
    NSDictionary * dic = GETUserdefault(@"userInfos");
    
    BOOL isLogin = [[dic objectForKey:@"isLogin"]boolValue];
    [tableHead refreshInfoWithLogin:isLogin];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.mySelfTable.width, 185)];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:tableHead];
    self.mySelfTable.tableHeaderView = view;
    NSLog(@"headview = %@",view);
    
}

-(void)initData{
     NSString *meListPath = [[NSBundle mainBundle] pathForResource:@"MySelfList" ofType:@"plist"];
    self.listArray = [[NSArray alloc]initWithContentsOfFile:meListPath];
    NSLog(@"listArray = %@",self.listArray);
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollView.contentOffset.y = %.2f",scrollView.contentOffset.y);
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset<0) {

        tableHead.transform = CGAffineTransformMakeScale((185-scrollView.contentOffset.y)/185, (185-scrollView.contentOffset.y)/185);
        
        CGFloat totalOffset = 185 + ABS(yOffset);
        CGFloat f = totalOffset / 185;
        //拉伸后的图片的frame应该是同比例缩放。
        tableHead.frame =  CGRectMake(- (SCREENWIDTH * f - SCREENWIDTH) / 2, yOffset, SCREENWIDTH * f, totalOffset);
    }
    }

#pragma mark tableDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * meListCellId = @"meListCellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:meListCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:meListCellId];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary * dic = self.listArray[indexPath.section][indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"title"];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary * dic = self.listArray[indexPath.section][indexPath.row];

    Class  currentClass = NSClassFromString([dic objectForKey:@"className"]);
    
    BaseLoginController * jumpClass = [[currentClass alloc]init];
    if ([jumpClass respondsToSelector:@selector(setIsUserLogin:)]) {
        jumpClass.isUserLogin = YES;
        if (jumpClass.isUserLogin) {
            jumpClass.titelLab.text = [dic objectForKey:@"title"];
            if ([jumpClass isKindOfClass:[XZMyCouponVC class ]]) {
                XZMyCouponVC * myCouponVC = [[XZMyCouponVC alloc]initWithStyle:MyCouponCanUse];
                myCouponVC.titelLab.text = @"我的优惠券";
                [self.navigationController pushViewController:myCouponVC animated:YES];
                return;
            }
              [self.navigationController pushViewController:jumpClass animated:YES];
        }else{
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[XZLoginVC alloc]init]];
            nav.navigationBar.hidden = YES;
            [self.navigationController presentViewController:nav animated:YES completion:nil];
        }
    }else{
        [self.navigationController pushViewController:jumpClass animated:YES];
    }
    
  
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 4)];
    headView.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
    return headView;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 4;
}

#pragma mark getter
-(UITableView *)mySelfTable{
    if (!_mySelfTable) {
        _mySelfTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mySelfTable.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
        _mySelfTable.dataSource = self;
        _mySelfTable.delegate = self;
        _mySelfTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        UIView * footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        _mySelfTable.tableFooterView = footerView;
    }
    return _mySelfTable;
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
