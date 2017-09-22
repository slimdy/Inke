//
//  AppDelegate.m
//  LFInke
//
//  Created by slimdy on 2017/5/8.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "AppDelegate.h"
#import "LF_TabBarController.h"
#import "LF_AdvController.h"
#import "LF_SaveUserDefaultTool.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    

    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"591a7803717c192a55001b2c"];
    
    [self configUSharePlatforms];
    
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];

    
    LF_AdvController *advVC = [[LF_AdvController alloc]init];

        self.window.rootViewController = advVC;;


    
    [self.window makeKeyAndVisible];
    
    
    
    
    return YES;
    
}
-(void)configUSharePlatforms{
    /* 设置新浪的appKey和appSecret */
   BOOL result =  [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2128428478"  appSecret:@"b6d5cb7a938433eaae8cc4c274848868" redirectURL:@"https://www.baidu.com/"];
    NSLog(@"%d",result);
    
}
-(BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    NSLog(@"%@",url);
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
    return YES;
}






- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
