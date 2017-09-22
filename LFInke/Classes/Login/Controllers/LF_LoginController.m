//
//  LF_LoginController.m
//  LFInke
//
//  Created by slimdy on 2017/5/16.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_LoginController.h"
#import "LF_AccountModel.h"
#import "LF_ArchiveTool.h"
#import "LF_TabBarController.h"
@interface LF_LoginController ()

@end

@implementation LF_LoginController
- (IBAction)SinaLogin:(id)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"%@",@"登陆失败");
            NSLog(@"%@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            LF_AccountModel *account = [[LF_AccountModel alloc]init];
            account.name = resp.name;
            account.gender = resp.unionGender;
            account.iconUrl = resp.iconurl;
            [LF_ArchiveTool saveAccountModel:account];
            self.view.window.rootViewController = [[LF_TabBarController alloc]init];
//            // 授权信息
//            NSLog(@"Sina uid: %@", resp.uid);
//            NSLog(@"Sina accessToken: %@", resp.accessToken);
//            NSLog(@"Sina refreshToken: %@", resp.refreshToken);
//            NSLog(@"Sina expiration: %@", resp.expiration);
//            
//            // 用户信息
//            NSLog(@"Sina name: %@", resp.name);
//            NSLog(@"Sina iconurl: %@", resp.iconurl);
//            NSLog(@"Sina gender: %@", resp.unionGender);
//            
//            // 第三方平台SDK源数据
//            NSLog(@"Sina originalResponse: %@", resp.originalResponse);
            
        }
    }];
    
   

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
