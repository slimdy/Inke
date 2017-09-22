//
//  LF_BaseNavigationController.m
//  LFInke
//
//  Created by slimdy on 2017/5/8.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_BaseNavigationController.h"
#import "LF_TabBarController.h"
#import "LF_PlayerController.h"
@interface LF_BaseNavigationController ()

@end

@implementation LF_BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = RGB(36, 215, 200);
    self.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    if ([viewController isKindOfClass:[LF_PlayerController class]]) {
        UIWindow *window = KEYWINDOW;
        LF_TabBarController* tabbarVC =(LF_TabBarController *)window.rootViewController;
        [tabbarVC IsHideLFTabBar:YES];
    }
    
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
