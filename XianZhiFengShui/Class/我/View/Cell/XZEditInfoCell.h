//
//  XZEditInfoCell.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2017/2/8.
//  Copyright © 2017年 XianZhiFengShui. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditInfoBlock)(NSString * editInfo);

@interface XZEditInfoCell : UITableViewCell
@property (nonatomic,strong)UITextField * editTf;
@property (nonatomic,copy)EditInfoBlock block;
-(void)editInfoWithBlock:(EditInfoBlock)block;
@end
