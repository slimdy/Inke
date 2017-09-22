//
//  LF_LaunchViewController.m
//  LFInke
//
//  Created by slimdy on 2017/5/8.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_LaunchViewController.h"
#import "LF_liveViewController.h"
#import "LF_LiveView.h"
@interface LF_LaunchViewController ()
@property (nonatomic,strong)LF_liveViewController *liveVC;
@end

@implementation LF_LaunchViewController
- (IBAction)startLiveBtnClick:(id)sender {
    self.liveVC = [[LF_liveViewController alloc]init];
    [self addChildViewController:self.liveVC];
    [self.view addSubview:self.liveVC.view];
    self.liveVC.liveView.topVC = self;
    [self.liveVC.liveView startLive];
}
- (IBAction)closeBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
