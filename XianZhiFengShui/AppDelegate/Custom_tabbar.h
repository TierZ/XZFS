//
//  Custom_tabbar.h

//
//  Created by 左晓东 on 14-9-4.
//  Copyright (c) 2014年 pursuitdream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPSUtil.h"


@interface Custom_tabbar : UITabBarController{
    
    NSArray     *backgroud_image;
    NSArray     *select_image;
    NSArray     *titleArray;
    
    NSMutableArray  *tab_btn;
    
    UIView  *tabBarView;
    
    UILabel*       m_numUnreadLetterShow;
}

@property (nonatomic,strong) UIView * tabBarView;

//- (void)init_tab;
- (void)when_tabbar_is_unselected;
- (void)add_custom_tabbar_elements;
- (void)when_tabbar_is_selected:(int)tabID;
- (void)hideTabBar:(BOOL)hide;
//- (void)refreshUserCenterUnreadLetter;
+ (Custom_tabbar*)showTabBar;

@end
