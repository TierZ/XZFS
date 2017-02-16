//
//  XZSettingVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZSettingVC.h"
#import "JMessage.framework/Headers/JMessage.h"
#import "JCHATStringUtils.h"
#import "BaseLoginController.h"
#import "XZLoginVC.h"

@interface XZSettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * setTable;
@property (nonatomic,strong)NSArray * setArray;
@end

@implementation XZSettingVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.setTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"设置";
    self.mainView.backgroundColor = XZFS_HEX_RGB(@"#F0EEEF");
    
    [self.view addSubview:self.setTable];
    self.setTable.frame = CGRectMake(0, XZFS_STATUS_BAR_H+7, SCREENWIDTH, SCREENHEIGHT-XZFS_STATUS_BAR_H-7);
    [self.setTable reloadData];
    // Do any additional setup after loading the view.
}

#pragma mark action
-(void)logOut{
//    [JMSGUser logout:^(id resultObject, NSError *error) {
//        if (error) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//            });
//            [MBProgressHUD showMessage:[JCHATStringUtils errorAlert:error] view:self.view];
//        }else{
            SETUserdefault(@{}, @"userInfos");
            [self.navigationController popViewControllerAnimated:YES];
//        }
//    }];
    
  
    NSLog(@"退出登录");
}

#pragma mark table 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.setArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * setCellId = @"setCellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:setCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:setCellId];
    }
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(22, 43.5, SCREENWIDTH-44, 0.5)];
    line.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
    [cell addSubview:line];

    NSDictionary * dic = GETUserdefault(@"userInfos");
    cell.detailTextLabel.text = [dic objectForKey:@"mobilePhone"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = [self.setArray[indexPath.row]objectForKey:@"title"];
    if (indexPath.row==self.setArray.count-1) {
        line.hidden = YES;
        cell.detailTextLabel.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * logOutV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 91)];
    logOutV.backgroundColor = XZFS_HEX_RGB(@"#F0EEEF");
    UIButton * logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        logOutBtn.frame = CGRectMake(20, 45, logOutV.width-40, 45);
        [logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [logOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logOutBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
        logOutBtn.titleLabel.font = XZFS_S_FONT(19);
        [logOutBtn addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    logOutBtn.layer.masksToBounds = YES;
    logOutBtn.layer.cornerRadius  =5;
    [logOutV addSubview:logOutBtn];
    
    return logOutV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 91;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * dic = self.setArray[indexPath.row];
    
    Class  currentClass = NSClassFromString([dic objectForKey:@"class"]);
    
    BaseLoginController * jumpClass = [[currentClass alloc]init];
    if ([jumpClass respondsToSelector:@selector(setIsUserLogin:)]) {
        if (jumpClass.isUserLogin) {
            jumpClass.titelLab.text = [dic objectForKey:@"title"];
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

#pragma mark getter
-(UITableView *)setTable{
    if (!_setTable) {
        _setTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _setTable.backgroundColor = XZFS_HEX_RGB(@"#F0EEEF");
        _setTable.dataSource = self;
        _setTable.delegate = self;
        _setTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        UIView * footerView = [UIView new];
        footerView.backgroundColor = [UIColor clearColor];
        _setTable.tableFooterView = footerView;
    }
    return _setTable;
}

-(NSArray *)setArray{
    if (!_setArray) {
        _setArray = @[@{@"title":@"手机号码",@"class":@"XZPhoneVC"},@{@"title":@"修改密码",@"class":@"XZChangePwdVC"}];
    }
    
    return _setArray;
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
