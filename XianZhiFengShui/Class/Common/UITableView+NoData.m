//
//  UITableView+NoData.m
//  ShaGuaLiCai
//
//  Created by shagualicai on 16/5/26.
//  Copyright © 2016年 傻瓜理财. All rights reserved.
//

#import "UITableView+NoData.h"

@implementation UIView(Nodata)
- (void)showNoDataViewWithType:(NoDataType)nndType message:(NSString *)message backgroundBlock:(backgroundClikcBlock)bgBlock btnBlock:(actionBtnClickBlock)btnBlock {
    [self showNoDataViewWithType:nndType message:message position:NoDataPositionCenter backgroundBlock:bgBlock btnBlock:btnBlock];
}
- (void)showNoDataViewWithType:(NoDataType)nndType backgroundBlock:(backgroundClikcBlock)bgBlock btnBlock:(actionBtnClickBlock)btnBlock {
    [self showNoDataViewWithType:nndType message:nil position:NoDataPositionCenter backgroundBlock:bgBlock btnBlock:btnBlock];
}
- (void)showNoDataViewWithType:(NoDataType)nndType message:(NSString *)message position:(NoDataPosition)position backgroundBlock:(backgroundClikcBlock)bgBlock btnBlock:(actionBtnClickBlock)btnBlock {
    /*
     noDataView 的大小跟view一样
     */
    [self hideNoDataView];
    
    NoDataView *noView = nil;
    if (CGRectEqualToRect(self.frame, CGRectZero)) {
        // table可能是用的约束
        noView = [[NoDataView alloc] initWithType:nndType message:message position:position constraintFlag:YES backgroundBlock:bgBlock btnBlock:btnBlock];
        [self addSubview:noView];
        [noView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//            make.top.and.left.and.right.and.bottom.equalTo(self);
        }];
    } else {
        // 这个也是有这个可能
        CGRect noFrame = self.frame;
        noFrame.origin.x = 0;
        noFrame.origin.y = 0;
        noView = [[NoDataView alloc] initWithType:nndType message:message position:position constraintFlag:NO backgroundBlock:bgBlock btnBlock:btnBlock];
        noView.frame = noFrame;
        
        [self addSubview:noView];
    }
    [self bringSubviewToFront:noView];
}
- (void)hideNoDataView {
    __weak typeof(self) weakSelf = self;
    dispatch_async_on_main_queue(^{
        for (UIView *sView in weakSelf.subviews) {
            if ([sView isKindOfClass:[NoDataView class]]) {
                [sView removeFromSuperview];
            }
        }
    });
}
@end
#pragma mark - NoDataView

#define SGLC_VIEW_PX(pxValue)  ((pxValue)/2.0)
#define space       SGLC_VIEW_PX(20)
#define imgViewW    SGLC_VIEW_PX(240)
#define imgViewH    SGLC_VIEW_PX(240)
#define btnViewW    SGLC_VIEW_PX(260)
#define btnViewH    SGLC_VIEW_PX(80)
#define labViewW    SGLC_VIEW_PX(640)
#define labViewH    SGLC_VIEW_PX(100)
#define  bgViewW    SGLC_VIEW_PX(400)
#define  bgViewH    SGLC_VIEW_PX(482)
@interface NoDataView()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel     *msgLabel;
@property (nonatomic, strong) UIButton    *actionBtn;

@property (nonatomic, strong) NSDictionary *titleDic;
@property (nonatomic, strong) NSDictionary *messageDic;
@property (nonatomic, strong) NSDictionary *imageDic;
@property (nonatomic, copy)   backgroundClikcBlock bgBlock;
@property (nonatomic, copy)   actionBtnClickBlock  btnBlock;
@property (nonatomic, assign) NoDataPosition       poistion;
@end
@implementation NoDataView
- (NSDictionary *)titleDic {
    if (!_titleDic) {
        _titleDic = @{@"250":@"", \
                      @"251":@"去关注更多高手", \
                      @"252":@"重新加载", \
                      @"253":@"", \
                      @"254":@"", \
                      @"255":@"", \
                      @"256":@"", \
                      @"257":@"", \
                      @"258":@"", \
                      @"259":@"", \
                      @"260":@"去关注更多高手", \
                      @"261":@"", \
                      @"262":@"", \
                      @"263":@"", \
                      @"264":@"", \
                      @"265":@"", \
                      @"266":@"", \
                      @"267":@"", \
                      @"268":@"", \
                      @"269":@"", \
                      @"270":@"立即登录"
                      };
    }
    return _titleDic;
}
- (NSDictionary *)messageDic {
    if (!_messageDic) {
        _messageDic = @{@"250":@"暂无内容 ", \
                       @"251":@"一点消息都没有", \
                       @"252":@"网络请求失败,请检查您的网络", \
                       @"253":@"暂无评论", \
                       @"254":@"直播已关闭", \
                       @"255":@"老师暂未开通该服务,敬请期待", \
                       @"256":@"老师还未录制视频课程,敬请期待", \
                       @"257":@"高手坐镇为您解题答惑", \
                       @"258":@"老师正在奋笔疾书中,敬请期待...", \
                       @"259":@"老师正则挑选牛股中,请等待...", \
                       @"260":@"您还未关注任何高手", \
                       @"261":@"还没有收藏过内容哦~", \
                       @"262":@"没有优惠券了", \
                       @"263":@"还没有购买过策略哦~", \
                       @"264":@"还没有购被授权策略哦~", \
                       @"265":@"还没有购买过VIP哦~", \
                       @"266":@"还没有购买过视频哦~", \
                       @"267":@"还没有收到回答哦~", \
                       @"268":@"还没有提问过问题哦~", \
                       @"269":@"正在获取数据中,请稍等待...", \
                       @"270":@"您还没有登录哦"
                       };
    }
    return _messageDic;
}
- (NSDictionary *)imageDic {
    if (!_imageDic) {
        _imageDic = @{@"250":@"ideo_img_-blank", \
                      @"251":@"living_news_img_blank", \
                      @"252":@"disconnection_img_blank", \
                      @"253":@"comment_img_blank", \
                      @"254":@"直播已关闭", \
                      @"255":@"VIP_img_blank", \
                      @"256":@"video_img_blank", \
                      @"257":@"living-room_Q-&-A_img_-blank", \
                      @"258":@"living-room_strategy_img_-blank", \
                      @"259":@"living-room_jiangu_img_-blank", \
                      @"260":@"concern_img_blank", \
                      @"261":@"ideo_img_-blank", \
                      @"262":@"discount-coupon_img_-blank", \
                      @"263":@"ideo_img_-blank", \
                      @"264":@"ideo_img_-blank", \
                      @"265":@"ideo_img_-blank", \
                      @"266":@"ideo_img_-blank", \
                      @"267":@"ideo_img_-blank", \
                      @"268":@"ideo_img_-blank", \
                      @"269":@"wating_img", \
                      @"270":@"login_img_blank"
                      };
    }
    return _imageDic;
}
- (instancetype)initWithType:(NoDataType)nndType message:(NSString *)message position:(NoDataPosition)position constraintFlag:(BOOL)flag backgroundBlock:(backgroundClikcBlock)bgBlock btnBlock:(actionBtnClickBlock)btnBlock
{
    self = [super init];
    if (self) {
        _bgBlock  = bgBlock;
        _btnBlock = btnBlock;
        _poistion = position;
        
        // 点击背景，没啥用吧
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
        
        [self initSubViewWithType:nndType message:message constraintFlag:flag];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)initSubViewWithType:(NoDataType)nndType message:(NSString *)message constraintFlag:(BOOL)flag {
    NSString *index = [NSString stringWithFormat:@"%zd", nndType];
    UIView *bgView = [[UIView alloc] init]; // 所有看到的子视图的背景
    bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgView];
    
    _imgView = [[UIImageView alloc] init];
    _imgView.userInteractionEnabled = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    _imgView.image = [UIImage imageNamed:self.imageDic[index]];
    [bgView addSubview:_imgView];
    
    _msgLabel = [[UILabel alloc] init];
    _msgLabel.numberOfLines = 0;
    _msgLabel.backgroundColor = [UIColor clearColor];
    _msgLabel.font = XZFS_S_FONT(15);
    _msgLabel.textColor = XZFS_HEX_RGB(@"#999999");
    _msgLabel.text = message?message:[NSString stringWithFormat:@"%@\n点击屏幕重试一下吧~",self.messageDic[index]];
    _msgLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:_msgLabel];
    
    if (![self.titleDic[index] isEqualToString:@""]) {
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionBtn.backgroundColor =XZFS_HEX_RGB(@"#ed725e");
        _actionBtn.tag = nndType;
        _actionBtn.layer.cornerRadius =5;
        _actionBtn.titleLabel.font = XZFS_S_FONT(17);
        [_actionBtn setTitle:self.titleDic[index] forState:UIControlStateNormal];
        [_actionBtn setTitleColor:XZFS_HEX_RGB(@"#ffffff") forState:UIControlStateNormal];
        [_actionBtn addTarget:self action:@selector(actionBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        if (nndType == NoDataTypeNoNetwork) {
            _actionBtn.layer.borderColor = XZFS_HEX_RGB(@"#cacaca").CGColor;
            _actionBtn.layer.borderWidth = 0.5;
            _actionBtn.backgroundColor = XZFS_HEX_RGB(@"#ffffff");
            [_actionBtn setTitleColor:XZFS_HEX_RGB(@"#999999") forState:UIControlStateNormal];
        }
        [bgView addSubview:_actionBtn];
    }
    // 不管哪种，都用frame也行
    if (flag) {
        // 可以用约束, 不管位置是哪，都暂时只显示到距离顶部 108
        __weak typeof(self) weakSelf = self;
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf).with.offset(64);
            make.size.mas_equalTo(CGSizeMake(bgViewW, bgViewH));
            make.centerX.equalTo(weakSelf);//.with.offset(SCREENWIDTH/2);
        }];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView).with.offset(SGLC_VIEW_PX(0));
            make.size.mas_equalTo(CGSizeMake(imgViewW, imgViewH));
            make.centerX.equalTo(bgView);
        }];
        [_msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imgView.mas_bottom).with.offset(SGLC_VIEW_PX(20));
            make.size.mas_equalTo(CGSizeMake(labViewW, labViewH));
            make.centerX.equalTo(bgView);
        }];
        if (_actionBtn) {
            [_actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_msgLabel.mas_bottom).with.offset(SGLC_VIEW_PX(20));
                make.size.mas_equalTo(CGSizeMake(btnViewW, btnViewH));
                make.centerX.equalTo(bgView);
            }];
        }
    } else {
        bgView.frame = CGRectMake(0, SGLC_VIEW_PX(128), bgViewW, bgViewH);
        bgView.centerX = SCREENWIDTH/2; // 这里按说应该self.centerX但是怕frame = 0,self.bounds.size.width/2
        
        _imgView.frame = CGRectMake(0, 0, imgViewW, imgViewH);
        _imgView.centerX = bgViewW/2;
        _msgLabel.frame = CGRectMake(0, _imgView.bottom+SGLC_VIEW_PX(20), labViewW, labViewH);
        _msgLabel.centerX = bgView.width/2;
        if (_actionBtn) {
            _actionBtn.frame = CGRectMake(0, _msgLabel.bottom+SGLC_VIEW_PX(20), btnViewW, btnViewH);
            _actionBtn.centerX = bgView.width/2;
        }
    }
    
}
- (void)tapClick {
    NSLog(@"noDataView点击了背景");
    if (self.bgBlock) {
        self.bgBlock();
    }
}
- (void)actionBtnDidClick:(UIButton *)sender {
    NSLog(@"noDataView点击了按钮");
    if (self.btnBlock) {
        self.btnBlock(sender.tag);
    }
}
@end
