//
//  LF_AdvController.m
//  LFInke
//
//  Created by slimdy on 2017/5/14.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_AdvController.h"
#import "LF_GetHotLiveTool.h"
#import "LF_SaveUserDefaultTool.h"
#import "LF_AdvModel.h"
#import "LF_LoginController.h"
#import "AppDelegate.h"
#import "LF_ArchiveTool.h"
#import "LF_TabBarController.h"
@interface LF_AdvController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroudView;
@property (nonatomic,strong)SDWebImageManager *sdManager;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)NSInteger count;
@end

@implementation LF_AdvController
-(SDWebImageManager *)sdManager{
    if (!_sdManager) {
        _sdManager = [SDWebImageManager sharedManager];
    }
    return _sdManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.timeLabel.text = @"倒计时：5";
    
        [self ShowAdv];
        [self downloadAdv];
    
    
}
-(void)ShowAdv{
    NSString *imageCacheName = [LF_SaveUserDefaultTool getAdvImageName];

    UIImage *advImage = [self.sdManager.imageCache imageFromDiskCacheForKey:imageCacheName];
    if (advImage) {
        self.backgroudView.image = advImage;
        [self setupCD];
    }else{
       AppDelegate *delegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIWindow*keyWindow = delegate.window;
        if ([LF_ArchiveTool getAccount]) {
            keyWindow.rootViewController = [LF_TabBarController alloc];
        }else{
            keyWindow.rootViewController = [[LF_LoginController alloc]init];
        }
        
       
    }
}
-(void)downloadAdv{
    [LF_GetHotLiveTool getAdvertisWithSuccess:^(id result) {
        LF_AdvModel *adv = result;
        NSString *imageCacheName = [LF_SaveUserDefaultTool getAdvImageName];
        if (![adv.image isEqualToString:imageCacheName]) {
            [self.sdManager loadImageWithURL:[NSURL URLWithString:adv.image] options:SDWebImageAvoidAutoSetImage progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                [LF_SaveUserDefaultTool setAdvImageName:[imageURL absoluteString]];
            }];
        }
        
    } failure:^(id error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}
-(void)setupCD{
    self.count = 3;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    
}
-(void)countDown{
//    NSLog(@"%@",[NSThread currentThread]);
    --self.count;
    self.timeLabel.text = [NSString stringWithFormat:@"倒计时：%ld",(long)self.count];
    if (self.count == -1) {
        AppDelegate *delegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIWindow*keyWindow = delegate.window;
        if ([LF_ArchiveTool getAccount]) {
            keyWindow.rootViewController = [LF_TabBarController alloc];
        }else{
            keyWindow.rootViewController = [[LF_LoginController alloc]init];
        }
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)dealloc
{
    NSLog(@"清除");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
