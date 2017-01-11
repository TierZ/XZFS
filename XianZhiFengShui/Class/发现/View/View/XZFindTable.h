//
//  XZFindTable.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/11.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//


//发现界面 的3个tableview

typedef enum : NSUInteger {
    XZFindMaster = 0,//大师
    XZFindLecture,//讲座
    XZFindTheme,//话题
    XZFindOther,//其他
} XZFindStyle;

extern NSString * const FindMasterCellId;
extern NSString * const FindLectureCellId;
extern NSString * const FindThemeCellId;

#import <UIKit/UIKit.h>
#import "XZFindVC.h"
#import "XZRefreshTable.h"

typedef void(^PointOfPraiseMasterBlock)(NSString * masterCode,NSIndexPath * indexPath);
typedef void(^LectureListCollectionBlock)(NSString * lectureCode,NSIndexPath * indexPath,NSString * isCollect);
@interface XZFindTable : UIView<UITableViewDelegate,UITableViewDataSource>
- (instancetype)initWithFrame:(CGRect)frame style:(XZFindStyle)style;
@property (nonatomic,strong)XZRefreshTable * table;
@property (nonatomic,strong)NSMutableArray * data;
@property (nonatomic,weak)BaseViewController * currentVC;
@property (nonatomic,assign)BOOL showLecturePrice;
@property (nonatomic,copy)PointOfPraiseMasterBlock block;
@property (nonatomic,copy)LectureListCollectionBlock lectureCollectBlock;
-(void)pointOfPraiseMasterWithBlock:(PointOfPraiseMasterBlock)block;
-(void)lectureListCollectionWithBlock:(LectureListCollectionBlock)block;
@end
