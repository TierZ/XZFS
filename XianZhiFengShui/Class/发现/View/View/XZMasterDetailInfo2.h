//
//  XZMasterDetailInfo2.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

//大师详情  客户评价的信息（等级 点赞 ，想约 收藏）
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, BtnTag) {
    LevelTag = 10,
    PointOfPraiseTag,
   SingleVolumeTag ,
    CollectedTag,
};
typedef void(^MasterMiddleBtnClickBlock)(BtnTag tag);
@interface XZMasterDetailInfo2 : UIView
- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray*)titles;
@property (nonatomic,copy)MasterMiddleBtnClickBlock block;

-(void)btnClickWithBlock:(MasterMiddleBtnClickBlock)block;
-(void)refreshInfoWithDic:(NSDictionary*)dic;
@end
