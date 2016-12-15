//
//  XZMyCouponVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/20.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyCouponVC.h"
#import "XZMyCouponCell.h"
#import "UIButton+XZImageTitleSpacing.h"

@interface XZMyCouponVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * couponTable;
@property (nonatomic,strong)NSMutableArray * coupons;
@property (nonatomic,assign)MyCoupon couponStyle;
@end

@implementation XZMyCouponVC

- (instancetype)initWithStyle:(MyCoupon)style
{
    self = [super init];
    if (self) {
        self.couponStyle = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"self.style = %lu",(unsigned long)self.couponStyle);
    self.couponTable.frame = CGRectMake(0, XZFS_STATUS_BAR_H+10, SCREENWIDTH, SCREENHEIGHT-XZFS_STATUS_BAR_H-10);
//    self.view.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
//     self.mainView.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
    [self.view addSubview:self.couponTable];
    [self setupTableHeader];
    [self setupTableFooter];
    for (int i = 0; i<4; i++) {
        MyCouponModel * model  = [[MyCouponModel alloc]init];
        model.price = @"150";
        model.time = @"2016.10.09-2016.11.09";
        model.warn = @"仅限先知客户使用";
        model.useRange = @"可用于购买大师服务,参加讲座和吉祥商城开光商品";
        [self.coupons addObject:model];
    }
    [self.couponTable reloadData];
    

}

-(void)setupTableHeader{
    if (self.couponStyle==MyCouponCanUse) {
        UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.couponTable.width, 84)];
        headerView.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
        self.couponTable.tableHeaderView = headerView;
        
        UIButton * clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clickBtn.frame =CGRectMake(0, 0, self.couponTable.width, 84);
        [headerView addSubview:clickBtn];
        clickBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
        [clickBtn setTitle:@"点击邀请好友赢大礼" forState:UIControlStateNormal];
        [clickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        clickBtn.titleLabel.font = XZFS_S_FONT(17);
        [clickBtn setImage:XZFS_IMAGE_NAMED(@"yaoqingsongli") forState:UIControlStateNormal];
        [clickBtn layoutButtonWithEdgeInsetsStyle:XZButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        [clickBtn addTarget:self action:@selector(clickSendGift) forControlEvents:UIControlEventTouchUpInside];
    }
  
  
}

-(void)setupTableFooter{
    if (self.couponStyle==MyCouponCanUse) {
        UIView * footerView = [UIView new];
        footerView.frame = CGRectMake(0, 0, SCREENWIDTH, 20);
        footerView.backgroundColor = XZFS_HEX_RGB(@"#F1EEEF");
        
        UIButton * seeCannotUsed = [UIButton buttonWithType:UIButtonTypeCustom];
        seeCannotUsed.frame = CGRectMake(footerView.width-130-40, 9, 130, 11);
        [seeCannotUsed setTitle:@"查看已失效优惠券" forState:UIControlStateNormal];
        [seeCannotUsed setTitleColor:XZFS_TEXTORANGECOLOR forState:UIControlStateNormal];
        seeCannotUsed.titleLabel.font = XZFS_S_FONT(11);
        [seeCannotUsed addTarget:self action:@selector(seeCannotUsedCoupon) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:seeCannotUsed];
        
        self.couponTable.tableFooterView = footerView;

    }else if (self.couponStyle==MyCouponDetail){
        UIView * footerView = [UIView new];
        footerView.frame = CGRectMake(20, 9, SCREENWIDTH-40, 20);
        footerView.backgroundColor = [UIColor whiteColor];
    
        UILabel * useNote = [[UILabel alloc]initWithFrame:CGRectMake(6, 8, 40, 10)];
        useNote.text = @"使用须知:";
        useNote.textColor = XZFS_TEXTBLACKCOLOR;
        useNote.font = XZFS_S_FONT(10);
        [useNote sizeToFit];
        [footerView addSubview:useNote];
        
        UILabel * noteContent = [[UILabel alloc]initWithFrame:CGRectMake(useNote.right+10, useNote.top, footerView.width-useNote.right-10-10, 100)];
        noteContent.textColor = XZFS_TEXTBLACKCOLOR;
        noteContent.text = @"· 优惠券为先知客户端专享\n· 不可叠加使用，每个订单仅限使用一个优惠券\n· 下单后在优惠券中手动选择\n· 成功下单后优惠券即作废，申请退款后无法退还\n";
        noteContent.numberOfLines = 0;
        noteContent.font = XZFS_S_FONT(10);
         [noteContent sizeToFit];
        [footerView addSubview:noteContent];
       
        
        
        UILabel * useRange = [[UILabel alloc]initWithFrame:CGRectMake(6, noteContent.bottom+25, 40, 10)];
        useRange.text = @"使用范围:";
        useRange.textColor = XZFS_TEXTBLACKCOLOR;
        useRange.font = XZFS_S_FONT(10);
        [useRange sizeToFit];
        [footerView addSubview:useRange];
        
        UILabel * rangeContent = [[UILabel alloc]initWithFrame:CGRectMake(useRange.right+10, useRange.top, footerView.width-useRange.right-10-10, 100)];
        rangeContent.textColor = XZFS_TEXTBLACKCOLOR;
        rangeContent.text = @"· 优惠券为先知客户端专享\n· 不可叠加使用，每个订单仅限使用一个优惠券\n· 下单后在优惠券中手动选择\n· 成功下单后优惠券即作废，申请退款后无法退还\n";
        rangeContent.numberOfLines = 0;
        rangeContent.font = XZFS_S_FONT(10);
        [rangeContent sizeToFit];
        [footerView addSubview:rangeContent];
        
        CGRect frame = footerView.frame;
        frame.size.height = rangeContent.bottom+8;
        footerView.frame = frame;
        
        self.couponTable.tableFooterView = footerView;
    }
   

}

#pragma mark action
-(void)clickSendGift{
    NSLog(@"点击送礼物");
}
-(void)seeCannotUsedCoupon{
    NSLog(@"查看失效优惠券");
    XZMyCouponVC * outOfDataVC = [[XZMyCouponVC alloc]initWithStyle:MyCouponOutOfData];
    outOfDataVC.titelLab.text = @"失效的优惠券";
    [self.navigationController pushViewController:outOfDataVC animated:YES];
}
#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.coupons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * couponCellId = @"couponCellId";
    
    XZMyCouponCell * couponCell = [tableView dequeueReusableCellWithIdentifier:couponCellId];
    if (!couponCell) {
        couponCell = [[XZMyCouponCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:couponCellId];
    }
    if (self.couponStyle==MyCouponOutOfData) {
         [couponCell outOfData:YES];
    }else{
     [couponCell outOfData:NO];
    }
   
    MyCouponModel * model = self.coupons[indexPath.row];
    [couponCell refreshCellWithModel:model];
    
    return couponCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 89;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.couponStyle==MyCouponCanUse) {
        XZMyCouponVC * myCouponVC = [[XZMyCouponVC alloc]initWithStyle:MyCouponDetail];
        myCouponVC.titelLab.text = @"优惠券详情";
        [self.navigationController pushViewController:myCouponVC animated:YES];
    }
}

#pragma mark getter
-(UITableView *)couponTable{
    if (!_couponTable) {
        _couponTable = [[UITableView alloc] init];
        _couponTable.backgroundColor =  XZFS_HEX_RGB(@"#F1EEEF");;
        _couponTable.dataSource = self;
        _couponTable.delegate = self;
        _couponTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _couponTable;
}

-(NSMutableArray *)coupons{
    if (!_coupons) {
        _coupons = [NSMutableArray array];
    }
    return _coupons;
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
