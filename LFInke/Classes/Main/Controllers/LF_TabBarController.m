//
//  LF_TabBarController.m
//  LFInke
//
//  Created by slimdy on 2017/5/8.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_TabBarController.h"
#import "LF_TaBbar.h"
#import "LF_MeViewController.h"
#import "LF_ShowViewController.h"
#import "LF_BaseNavigationController.h"
#import "LF_LaunchViewController.h"
@interface LF_TabBarController ()<LF_TabBarDelegate>
@property (nonatomic,weak)LF_TaBbar *LFTabar;
@end

@implementation LF_TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBar removeFromSuperview];
    
    [self setupTabBar];
    [self setupChildControllers];
}
-(void)setupTabBar{
    LF_TaBbar *tabBar = [[LF_TaBbar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
    tabBar.delegate = self;
    tabBar.imagesNameArr = @[@"tab_live",@"tab_me"];
    self.LFTabar = tabBar;
    [self.view addSubview:tabBar];
}
-(void)setupChildControllers{
    LF_MeViewController *meVC = [[LF_MeViewController alloc]init];
    LF_ShowViewController *showVC = [[LF_ShowViewController alloc]init];
    LF_BaseNavigationController *meNav = [[LF_BaseNavigationController alloc]initWithRootViewController:meVC];
    LF_BaseNavigationController *showNav = [[LF_BaseNavigationController alloc]initWithRootViewController:showVC];
    [self addChildViewController:showNav];
    [self addChildViewController:meNav];
}
-(void)IsHideLFTabBar:(BOOL)flag{
    self.LFTabar.hidden = flag;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tabbar:(LF_TaBbar *)tabBar DidClickedButton:(LFItemType)LFItemTypeEnum{
    if (LFItemTypeEnum == LFItemTypeLaunch) {
        LF_LaunchViewController *launchVC = [[LF_LaunchViewController alloc]init];
        [self presentViewController:launchVC animated:YES completion:nil];
    }else{
       self.selectedIndex = LFItemTypeEnum;
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
