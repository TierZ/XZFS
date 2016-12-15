//
//  Custom_tabbar.m

//
//  Created by 左晓东 on 14-9-4.
//  Copyright (c) 2014年 pursuitdream. All rights reserved.
//

#import "Custom_tabbar.h"
#import "XZHomePageVC.h"
#import "XZFindVC.h"
#import "XZMallVC.h"
#import "XZAboutMeVC.h"
#import "XZNavigationController.h"

@interface Custom_tabbar ()
@property (nonatomic,strong)UIImageView * iv;
@end

@implementation Custom_tabbar
@synthesize tabBarView;

static Custom_tabbar *s_tabbar = NULL;


- (void)showLoading{

    
    XZHomePageVC* first  = [[XZHomePageVC alloc] init];
    XZNavigationController* navigationController_First = [[XZNavigationController alloc] initWithRootViewController:first];
    
    XZFindVC* second = [[XZFindVC alloc] init];
    XZNavigationController* navigationController_Second = [[XZNavigationController alloc] initWithRootViewController:second];
    
    XZMallVC* third = [[XZMallVC alloc] init];
    //third.isHideBottom = NO;
    XZNavigationController* navigationController_Third = [[XZNavigationController alloc] initWithRootViewController:third];
    
    XZAboutMeVC* fourth = [[XZAboutMeVC alloc] init];
    XZNavigationController* navigationController_Fourth = [[XZNavigationController alloc] initWithRootViewController:fourth];
    
    // UserCenterViewController *fifth = [[UserCenterViewController alloc] init];
 

//    
    if(XZFS_IS_IOS7){
        first.navigationController.interactivePopGestureRecognizer.enabled = YES;//返回手势
        second.navigationController.interactivePopGestureRecognizer.enabled = YES ;
        third.navigationController.interactivePopGestureRecognizer.enabled = YES ;
        fourth.navigationController.interactivePopGestureRecognizer.enabled = YES ;
    }
    
    first.hidesBottomBarWhenPushed = NO;
    navigationController_First.navigationBar.hidden = YES;
    navigationController_Second.navigationBar.hidden = YES;
    navigationController_Third.navigationBar.hidden = YES;
    navigationController_Fourth.navigationBar.hidden = YES;

    self.viewControllers =@[navigationController_First,navigationController_Second,navigationController_Third,navigationController_Fourth];
   
    navigationController_First.tabBarItem.title = @"首页";
//    navigationController_Fifth.tabBarItem.
    navigationController_First.tabBarItem.image = [XZFS_IMAGE_NAMED(@"shouye")imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationController_First.tabBarItem.selectedImage = [XZFS_IMAGE_NAMED(@"shouye_select")imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationController_First.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    navigationController_Second.tabBarItem.title = @"发现";
    navigationController_Second.tabBarItem.image = [XZFS_IMAGE_NAMED(@"faxian")imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationController_Second.tabBarItem.selectedImage = [XZFS_IMAGE_NAMED(@"faxian_select") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    navigationController_Third.tabBarItem.title = @"商城";
    navigationController_Third.tabBarItem.image = [XZFS_IMAGE_NAMED(@"shangcheng")imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationController_Third.tabBarItem.selectedImage = [XZFS_IMAGE_NAMED(@"shangcheng_select")imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    navigationController_Fourth.tabBarItem.title = @"我的";
    navigationController_Fourth.tabBarItem.image = [XZFS_IMAGE_NAMED(@"wo")imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationController_Fourth.tabBarItem.selectedImage = [XZFS_IMAGE_NAMED(@"wo_select")imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
   [[UITabBarItem appearance]setTitleTextAttributes:@{ NSForegroundColorAttributeName:XZFS_HEX_RGB(@"#959595")} forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:@{ NSForegroundColorAttributeName:XZFS_HEX_RGB(@"#e0403f")} forState:UIControlStateSelected];
    //    [tabbarItem setTitleTextAttributes:textArrays forState:UIControlStateHighlighted];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    
//    [self database]; // add by lf 先创建它才能使用db

    [self showLoading];
    
    
}

- (void)when_tabbar_is_unselected
{
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}
//- (void)dataBase {
//
//    FMDBManager *dbManager = [FMDBManager sharedFMDBManager];
//    [dbManager createDatabase];
//}

- (void)add_custom_tabbar_elements
{
    int tab_num = (int)[self.viewControllers count];
    tabBarView.userInteractionEnabled = YES;
	[self.view addSubview:tabBarView];
	
	tab_btn = [[NSMutableArray alloc] initWithCapacity:0];
    float width = SCREENWIDTH/tab_num;
	for(int i = 0; i< tab_num; i++)
	{
		UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn setFrame:CGRectMake(i*width, 0, width, 50)];
        [btn setExclusiveTouch:YES];
		NSString *back_image = [backgroud_image objectAtIndex:i];
		NSString *selected_image = [select_image objectAtIndex:i];


        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:XZFS_HEX_RGB(@"#313131") forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(33, -2, 2, 0)];
		[btn.titleLabel setFont:[UIFont systemFontOfSize:12]];

		if(i == 0)
		{
			[btn setSelected:YES];
		}
		[btn setTag:i];
		[tab_btn addObject:btn];
		[tabBarView addSubview:btn];
		[btn addTarget:self action:@selector(button_clicked_tag:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView * iv = [[UIImageView alloc]initWithFrame:CGRectMake((width-20)/2-2, 10, 20, 20)];
        iv.backgroundColor = [UIColor clearColor];
        [btn addSubview:iv];
        if (btn.selected) {
            iv.image = [UIImage imageNamed:selected_image];
        }else{
            iv.image = [UIImage imageNamed:back_image];
        }
	}
}

- (void)button_clicked_tag:(id)sender
{
	int tagNum = (int)[(UIButton*)sender tag];
	[self when_tabbar_is_selected:tagNum];
}

- (void)when_tabbar_is_selected:(int)tabID
{
    self.tabBarController.selectedIndex = tabID;
	self.selectedIndex = tabID;
}

- (void)hideTabBar:(BOOL) hidden
{
	if(hidden)
	{
		self.tabBarView.hidden = YES;
	}
	else
	{
		self.tabBarView.hidden = NO;
	}
}

+ (Custom_tabbar*)showTabBar
{
    @synchronized(self)
    {
		if (s_tabbar == nil)
		{
			s_tabbar = [[self alloc] init];  //assignment not done here
		}
	}
	return s_tabbar;
}

+ (id)allocWithZone:(NSZone *)zone
{
	@synchronized(self)
	{
		if (s_tabbar == nil)
		{
			s_tabbar = [super allocWithZone:zone];
			return s_tabbar;  //assignment and return on first allocation
		}
	}	
	return nil;  //on subsequent allocation attempts return nil
}
- (void)dealloc {
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
