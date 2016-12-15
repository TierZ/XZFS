//
//  XZNavigationController.m
//  XianZhiFengShui
//
//  Created by 李清娟 on 2016/10/8.
//  Copyright © 2016年 XianZhiFengShui. All rights reserved.
//

#import "XZNavigationController.h"

@interface XZNavigationController ()

@end

@implementation XZNavigationController

- (void)viewDidLoad

{
    [super viewDidLoad];
    __weak XZNavigationController *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        
        self.delegate = weakSelf;
    }
    
    
}


// Hijack the push method to disable the gesture



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated

{
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]&&animated==YES)
        
        self.interactivePopGestureRecognizer.enabled = NO;
    
    if (self.childViewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }

    
    [super pushViewController:viewController animated:animated];
    
}



- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated

{
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]&&animated==YES)
        
        self.interactivePopGestureRecognizer.enabled = NO;
    
    
    
    return  [super popToRootViewControllerAnimated:animated];
    
}



- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated

{
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        
        self.interactivePopGestureRecognizer.enabled = NO;
    
    return [super popToViewController:viewController animated:animated];
    
}

#pragma mark UINavigationControllerDelegate



- (void)navigationController:(UINavigationController *)navigationController

       didShowViewController:(UIViewController *)viewController

                    animated:(BOOL)animate

{
    
    // Enable the gesture again once the new controller is shown
    
    
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        
        self.interactivePopGestureRecognizer.enabled = YES;
        
    }
    
}





-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer

{
    
    if (gestureRecognizer==self.interactivePopGestureRecognizer) {
        
        if (self.viewControllers.count<2||self.visibleViewController==[self.viewControllers objectAtIndex:0]) {
            
            return NO;
            
        }
        
    }
    
    return YES;
    
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
