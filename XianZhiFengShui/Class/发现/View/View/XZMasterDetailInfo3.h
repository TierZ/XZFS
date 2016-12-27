//
//  XZMasterDetailInfo3.h
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/25.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

///大师详情  （服务项目，关于大师，客户评价，大师文章）

#import <UIKit/UIKit.h>
#import "XZMasterDetailVC.h"


@interface XZMasterDetailInfo3 : UIView<UIScrollViewDelegate>
-(instancetype)initWithFrame:(CGRect)frame masterCode:(NSString*)masterCode detailVC:(XZMasterDetailVC*)detailVC;
-(void)setupOriginData:(NSDictionary*)dic;
@end
