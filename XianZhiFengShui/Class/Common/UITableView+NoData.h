//
//  UITableView+NoData.h
//
//  缺省页面,不仅仅针对于tableView, 所有view
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, NoDataType) {
    NoDataTypeDefault = 250,   // 250默认 暂无内容
    NoDataTypeNoMessage,       // 251无消息
    NoDataTypeNoNetwork,       // 252无网络
    NoDataTypeNoComment,       // 253无评论
    NoDataTypeNoLBDLive,       // 254直播间无直播
    NoDataTypeNoLBDVip,        // 255直播间无vip
    NoDataTypeNoLBDVideo,      // 256直播间无视频
    NoDataTypeNoLBDFAQs,       // 257直播间无问答
    NoDataTypeNoLBDTactics,    // 258直播间无策略
    NoDataTypeNoLBDRecommend,  // 259直播间无荐股
    NoDataTypeNoMyFocus,       // 260无我的关注
    NoDataTypeNoMyCollection,  // 261无我的收藏
    NoDataTypeNoMyCoupon,      // 262无我的优惠券
    NoDataTypeNoMyTactics1,    // 263无我的购买策略
    NoDataTypeNoMyTactics2,    // 264无我的授权策略
    NoDataTypeNoMyVip,         // 265无我的vip
    NoDataTypeNoMyVideo,       // 266无我的的视频
    NoDataTypeNoMyFAQs1,       // 267无我的提问
    NoDataTypeNoMyFAQs2,       // 268无我的回复
    NoDataTypeWaiting,         // 269正在获取中...
    NoDataTypeNoLogin,         // 270未登录
};
typedef NS_ENUM(NSInteger, NoDataPosition) {
    NoDataPositionTop,
    NoDataPositionCenter = 0,
    NoDataPositionBottom,
};
typedef void(^backgroundClikcBlock)();                 // 点击背景
typedef void(^actionBtnClickBlock)(NoDataType type);   // 点击按钮

#define NNDPositionTopSpace     64+20
#define NNDPositionBottomSpace  49+20

@interface UIView (Nodata)
// 可以指定信息
- (void)showNoDataViewWithType:(NoDataType)nndType message:(NSString *)message backgroundBlock:(backgroundClikcBlock)bgBlock btnBlock:(actionBtnClickBlock)btnBlock;
// 只能用设置好的信息
- (void)showNoDataViewWithType:(NoDataType)nndType backgroundBlock:(backgroundClikcBlock)bgBlock btnBlock:(actionBtnClickBlock)btnBlock;

//- (void)showNoDataViewWithType:(NoDataType)nndType position:(NoDataPosition)position backgroundBlock:(backgroundClikcBlock)bgBlock btnBlock:(actionBtnClickBlock)btnBlock;

- (void)hideNoDataView;

@end

#pragma mark - NodataView

@interface NoDataView : UIView
- (instancetype)initWithType:(NoDataType)nndType message:(NSString *)message position:(NoDataPosition)position constraintFlag:(BOOL)flag backgroundBlock:(backgroundClikcBlock)bgBlock btnBlock:(actionBtnClickBlock)btnBlock;
@end

