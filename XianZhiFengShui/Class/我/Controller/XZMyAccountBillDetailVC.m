//
//  XZMyAccountBillDetailVC.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/11/17.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZMyAccountBillDetailVC.h"
#import "XZMyAccountService.h"
@interface XZMyAccountBillDetailVC ()
@property (nonatomic,copy)NSString * tradeNo;
@end

@implementation XZMyAccountBillDetailVC{
    UIView * _infoView;
    UILabel * _price;//交易价格
    UIView * _line;
    UILabel * _style;//类型
    UILabel * _time;//时间
    UILabel * _orderId;//订单编号
    UILabel * _balance;//余额
    UILabel * _payStyle;//支付方式
}

- (instancetype)initWithTradeNo:(NSString*)tradeNo
{
    self = [super init];
    if (self) {
        _tradeNo = tradeNo;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titelLab.text = @"账单详情";
    [self setupInfo];
    [self setupDetail];
    [self refreshDetail];
    [self requestBillDetail];
    // Do any additional setup after loading the view.
}

-(void)setupInfo{
    _infoView = [UIView new];
    _infoView.backgroundColor = [UIColor whiteColor];
    _infoView.frame = CGRectMake(0, 0, SCREENWIDTH, 207);
    [self.mainView addSubview:_infoView];
    
    UILabel * priceLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 12, 100, 14)];
    priceLab.text = @"账单金额";
    priceLab.font = XZFS_S_BOLD_FONT(14);
    priceLab.textColor = XZFS_TEXTBLACKCOLOR;
    [_infoView addSubview:priceLab];
    
    _price = [[UILabel alloc]initWithFrame:CGRectMake(priceLab.right, 12, _infoView.width-priceLab.right-22, 14)];
    _price.text = @"--";
    _price.font = XZFS_S_BOLD_FONT(14);
    _price.textAlignment = NSTextAlignmentRight;
    _price.textColor = XZFS_TEXTBLACKCOLOR;
    [_infoView addSubview:_price];
    
    _line = [UIView new];
    _line.backgroundColor = XZFS_HEX_RGB(@"#F2F3F3");
    _line.frame = CGRectMake(22, _price.bottom+14, _infoView.width-44, 0.5);
    [_infoView addSubview:_line];

}

-(void)setupDetail{
    NSArray * leftTitles = @[ @"类      型",@"时      间",@"交易单号",@"账户余额",@"支付方式" ];
    for (int i = 0; i<leftTitles.count; i++) {
        UILabel * leftTitle = [UILabel new];
        leftTitle.textColor = XZFS_TEXTBLACKCOLOR;
        leftTitle.font = XZFS_S_FONT(12);
        leftTitle.text = leftTitles[i];
        leftTitle.frame = CGRectMake(31, _line.bottom+13+i*(20+12), 100, 12);
        [_infoView addSubview:leftTitle];
        
        UILabel * detail = [UILabel new];
        detail.textAlignment = NSTextAlignmentRight;
        detail.textColor = XZFS_TEXTBLACKCOLOR;
        detail.font = XZFS_S_FONT(12);
        detail.text  =@"--";
        detail.frame = CGRectMake(_infoView.width-200-22, _line.bottom+13+i*(20+12), 200, 12);
        detail.tag = 10+i;
        [_infoView addSubview:detail];
    }
    _style =(UILabel*) [_infoView viewWithTag:10];
    _time =(UILabel*) [_infoView viewWithTag:11];
    _orderId =(UILabel*) [_infoView viewWithTag:12];
    _balance =(UILabel*) [_infoView viewWithTag:13];
    _payStyle =(UILabel*) [_infoView viewWithTag:14];
  
}

#pragma mark 网络
-(void)requestBillDetail{
    XZMyAccountService  * billDetail = [[XZMyAccountService alloc]initWithServiceTag:XZAccountOrderDetailTag];
    billDetail.delegate = self;
    [billDetail myAccountOrderDetailWithTradeNo:_tradeNo view:self.mainView];
}
-(void)netSucceedWithHandle:(id)succeedHandle dataService:(id)service{
    NSLog(@"详情 = %@",succeedHandle);
}

-(void)netFailedWithHandle:(id)failHandle dataService:(id)service{
    
}

-(void)refreshDetail{
    _price.text = @"100";
    _style.text = @"收入";
    _time.text = @"2016-11-17 14:45:44";
    _orderId.text = @"20112315801231";
    _balance.text = @"1000,00.00";
    _payStyle.text = @"中国银行";

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
