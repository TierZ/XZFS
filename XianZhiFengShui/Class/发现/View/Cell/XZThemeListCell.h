//
//  XZThemeListCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/20.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

//分类话题 cell、

#import <UIKit/UIKit.h>
#import "XZThemeListModel.h"

typedef void(^EditThemeBlock)(XZThemeListModel * model ,NSIndexPath * indexPath);
typedef void(^DeleteThemeBlock)(XZThemeListModel * model ,NSIndexPath * indexPath);
typedef void(^AgreeThemeBlock)(XZThemeListModel * model ,NSIndexPath * indexPath);
typedef void(^CommentThemeBlock)(XZThemeListModel * model ,NSIndexPath * indexPath);

@interface XZThemeListCell : UITableViewCell
@property (nonatomic,strong)XZThemeListModel * model;
@property (nonatomic,strong)NSIndexPath * indexPath;
@property (nonatomic,copy)EditThemeBlock editBlock;
@property (nonatomic,copy)DeleteThemeBlock deleteBlock;
@property (nonatomic,copy)AgreeThemeBlock agreeBlock;
@property (nonatomic,copy)CommentThemeBlock commentBlock;

-(void)editThemeWithBlock:(EditThemeBlock)block;
-(void)deleteThemeWithBlock:(DeleteThemeBlock)block;
-(void)agreeThemeWithBlock:(AgreeThemeBlock)block;
-(void)commentThemeWithBlock:(CommentThemeBlock)block;

-(void)hideEditBtn:(BOOL)isHide;
@end
