//
//  XZOrderDetailVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/12/13.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZOrderDetailVC.h"
#import "XZAddressCell.h"
#import "XZOrderDetailCell.h"
#import "XZBuyCountCell.h"
#import "XZPayView.h"
#import "XZAddressListVC.h"
#import "XZGoodsDetailVC.h"
@interface XZOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation XZOrderDetailVC{
    UITableView * _orderDetail;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titelLab.text = @"订单确认";
    self.dataArray = [NSMutableArray array];
    [self setupData];
    [self setupTable];
    [self setupBottom];
    [_orderDetail reloadData];
    // Do any additional setup after loading the view.
}

-(void)setupData{
    XZAddressModel * orderModel = [[XZAddressModel alloc]init];
    orderModel.consignee  =@"张三丰";
    orderModel.phone = @"13812321993";
    orderModel.address = @"武当山具体在襄阳市和十堰市铁路和高速公路的中间地带，即丹江口市境内的中央 武当派紫霄宫302室";
    NSArray * orderArr = @[orderModel];
    
    XZGoodsModel * goodsModel = [[XZGoodsModel alloc]init];
    goodsModel.storeName = @"全聚德";
    goodsModel.image = @"http://file.shagualicai.cn/201610/09/pic/pic_14759978965900.jpg";
    goodsModel.name = @"宏泰翔  8寸风水罗盘";
    goodsModel.introduce = @"俺家的呢那是得去玩喝喝该看书的你卡上的太和街阿萨德";
    goodsModel.price = @"3800";
    NSArray * goodsArr = @[goodsModel];
    
    XZGoodsModel * countModel = [[XZGoodsModel alloc]init];
    countModel.selectCount = @"3";
    XZGoodsModel * expressModel = [[XZGoodsModel alloc]init];
    expressModel.expressPrice = @"10";
    NSArray * countArray = @[countModel,expressModel];
    
    [self.dataArray addObjectsFromArray:@[orderArr,goodsArr,countArray]];
    
    
}


-(void)setupTable{
    _orderDetail = [[UITableView alloc]initWithFrame:CGRectMake(0, 4, SCREENWIDTH, XZFS_MainView_H-4-45) style:UITableViewStylePlain];
    _orderDetail.backgroundColor = self.mainView.backgroundColor;
    _orderDetail.delegate = self;
    _orderDetail.dataSource = self;
    [self.mainView addSubview:_orderDetail];
    

    
    XZPayView * payView = [[XZPayView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200)];
    payView.backgroundColor = self.mainView.backgroundColor;
    _orderDetail.tableFooterView = payView;
}



-(void)setupBottom{
    UIView * bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, XZFS_MainView_H-45, SCREENWIDTH, 45);
    [self.mainView addSubview:bottomView];
    
    UILabel * _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(25, 14, 200, 17)];
    _priceLab.textColor = XZFS_TEXTBLACKCOLOR;
    _priceLab.font = XZFS_S_FONT(17);
    [bottomView addSubview:_priceLab];
    
    UIButton* payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [payBtn setTitle:@"支付" forState:UIControlStateNormal];
    [payBtn setTitleColor:XZFS_TEXTBLACKCOLOR forState:UIControlStateNormal];
    payBtn.titleLabel.font = XZFS_S_FONT(17);
    payBtn.frame = CGRectMake(SCREENWIDTH*0.6, 0, SCREENWIDTH*0.4, 45);
    payBtn.backgroundColor = XZFS_TEXTORANGECOLOR;
    [payBtn addTarget:self action:@selector(payNow:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:payBtn];
}

#pragma mark action
-(void)payNow:(UIButton*)sender{
    NSLog(@"去支付")
}

#pragma mark table 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    int nums = self.dataArray.count>0?(int)self.dataArray.count:1;
    NSLog(@"count = %d",nums);
    return nums;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"array= %@",self.dataArray);
    return [self.dataArray[section] isKindOfClass:[NSArray class]]?[self.dataArray[section]count]:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * addressId = @"addressId";
    static NSString * goodsDetailId = @"goodsDetailId";
    static NSString * countId = @"countId";
    static NSString * expressId = @"expressId";
    
    if (indexPath.section==0) {
        XZAddressCell * addressCell = [tableView dequeueReusableCellWithIdentifier:addressId];
        if (!addressCell) {
            addressCell = [[XZAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:addressId];
        }
        XZAddressModel * model = self.dataArray[indexPath.section][indexPath.row];
        model.isHideEditBar = YES;
        addressCell.model = model;
        return addressCell;
    }else if (indexPath.section==1){
        XZOrderDetailCell * detailCell = [tableView dequeueReusableCellWithIdentifier:goodsDetailId];
        if (!detailCell) {
            detailCell = [[XZOrderDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsDetailId];
        }
        detailCell.model = self.dataArray[indexPath.section][indexPath.row];
        return detailCell;
    }if (indexPath.section==2) {
        if (indexPath.row==0) {
            XZBuyCountCell * buyCountCell  = [tableView dequeueReusableCellWithIdentifier:countId];
            if (!buyCountCell) {
                buyCountCell = [[XZBuyCountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:countId];
            }
            buyCountCell.model = self.dataArray[indexPath.section][indexPath.row];
            return buyCountCell;
        }else{
            UITableViewCell * expressCell = [tableView dequeueReusableCellWithIdentifier:expressId];
            if (!expressCell) {
                expressCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:expressId];
            }
            expressCell.selectionStyle = UITableViewCellSelectionStyleNone;
            expressCell.textLabel.font = XZFS_S_FONT(15);
             expressCell.detailTextLabel.font = XZFS_S_FONT(15);
            expressCell.textLabel.text = @"运费";
              XZGoodsModel*model = self.dataArray[indexPath.section][indexPath.row];
            expressCell.detailTextLabel.text = [NSString stringWithFormat:@"%@元",model.expressPrice ];
            return expressCell;
        }
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        XZAddressModel * model = self.dataArray[indexPath.section][indexPath.row];
        model.isHideEditBar = YES;
        return [_orderDetail cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZAddressCell class] contentViewWidth:SCREENWIDTH];
    }else if (indexPath.section==1){
        id model = self.dataArray[indexPath.section][indexPath.row];
        return [_orderDetail cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[XZOrderDetailCell class] contentViewWidth:SCREENWIDTH];
    }else{
        return 44;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footView = [UIView new];
    footView.backgroundColor = self.mainView.backgroundColor;
    footView.frame = CGRectMake(0, 0, SCREENWIDTH, 4);
    return footView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 4;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        XZAddressModel * model = self.dataArray[indexPath.section][indexPath.row];
        XZAddressListVC * addressList = [[XZAddressListVC alloc]init];
        [self.navigationController pushViewController:addressList animated:YES];
    }else if (indexPath.section==1){
        XZGoodsDetailVC * goodsDetail = [[XZGoodsDetailVC alloc]init];
        [self.navigationController pushViewController:goodsDetail animated:YES];
    }
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
