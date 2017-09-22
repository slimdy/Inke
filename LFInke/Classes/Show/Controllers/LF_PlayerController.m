//
//  LF_PlayerController.m
//  LFInke
//
//  Created by slimdy on 2017/5/11.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_PlayerController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "LF_HotLiveModel.h"
#import "LF_TabBarController.h"
#import "LF_LiveChatViewController.h"
@interface LF_PlayerController ()
@property (nonatomic,strong)id<IJKMediaPlayback> player;
@property (nonatomic,weak)UIImageView *imageView;
@property (nonatomic,strong)UIButton *closeBtn;
@property (nonatomic,strong) LF_LiveChatViewController*chatVC;
@end

@implementation LF_PlayerController
-(LF_LiveChatViewController *)chatVC{
    if (!_chatVC) {
        _chatVC = [[LF_LiveChatViewController alloc]init];
        _chatVC.live = _live;
    }
    return _chatVC;
}
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        btn.frame = CGRectMake(SCREEN_WIDTH-btn.width-10, SCREEN_HEIGHT-btn.height-10, btn.width, btn.height);
        
        _closeBtn = btn;
    }
    return _closeBtn;
}
-(void)closeBtnClick:(UIButton *)button{
    UIWindow *window = KEYWINDOW;
    
    [self.navigationController popViewControllerAnimated:YES];
    LF_TabBarController *tabBarVC =(LF_TabBarController *)window.rootViewController;
    [tabBarVC IsHideLFTabBar:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupPlayer];
    [self setupUI];
    [self setupChatVC];
}
-(void)setupPlayer{
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    IJKFFMoviePlayerController * player = [[IJKFFMoviePlayerController alloc]initWithContentURLString:self.live.streamAddr withOptions:options];
    NSLog(@"----------%@-----------",self.live.streamAddr);
    player.view.frame = self.view.bounds;
    player.shouldAutoplay = YES;
    [self.view addSubview:player.view];
    self.player = player;
}
-(void)setupUI{
    self.view.backgroundColor = [UIColor blackColor];
    //毛玻璃效果
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.imageView = imageView;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.live.creator.portrait] placeholderImage:[UIImage imageNamed:@"default_room"]];
    [self.view addSubview:self.imageView]; //将图片添加到页面上面
    //正式添加毛玻璃
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];//毛玻璃样式
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blur];//毛玻璃视图
    visualEffectView.frame = self.imageView.bounds;
    [self.imageView addSubview:visualEffectView];
    
    
}
-(void)setupChatVC{
    [self addChildViewController:self.chatVC];
    [self.view addSubview:self.chatVC.view];
    [self.chatVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self installNotificationObservers];
    [self.player prepareToPlay];
    UIWindow *window = KEYWINDOW;
    [window  addSubview:self.closeBtn];
    
}
-(void)installNotificationObservers{
//    IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification  当重放准备状态是否改变时发出通知
//    IJKMPMoviePlayerPlaybackDidFinishNotification  当影片播放完成时发出通知
//    IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey 当用户停止是发出通知
//    IJKMPMoviePlayerLoadStateDidChangeNotification  当网络加载状态发生改变时发出通知
    //监听网络环境，监听缓冲方法
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    //监听是否准备播放通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(meidaIsPreparedChange:)
                                         name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:self.player];
    //监听影片播放完毕
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsDidFinishChange:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:self.player];
    //监听用户操作
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsDidFinishByUserChange:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey
                                               object:self.player];
}
-(void)loadStateDidChange:(NSNotification *)noti{
    IJKMPMovieLoadState state = _player.loadState;
//    IJKMPMovieLoadStateUnknown        = 0, 未知状态
//    IJKMPMovieLoadStatePlayable       = 1 << 0,缓冲结束可播放状态
//    IJKMPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES 缓冲结束可以自动播放
//    IJKMPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started //缓速停止
    if ((state & IJKMPMovieLoadStatePlaythroughOK)!= 0) {
        NSLog(@"缓冲结束自动播放---%lu",(unsigned long)state);
        [self.imageView setHidden:YES];
        [self.imageView removeFromSuperview];
    }else if((state & IJKMPMovieLoadStateStalled) !=0){
        NSLog(@"暂停播放---%lu",(unsigned long)state);
    }else{
        NSLog(@"网络状态未知---%lu",state);
    }
}
-(void)meidaIsPreparedChange:(NSNotification *)noti{
    NSLog(@"是否准备？%@",noti);
}
-(void)mediaIsDidFinishChange:(NSNotification *)noti{
    NSInteger reason = [[[noti userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"播放完成");
            break;
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"用户主动退出");
            break;
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"播放错误退出");
            break;
        default:
            break;
    }
}
-(void)mediaIsDidFinishByUserChange:(NSNotification *)noti{
    switch (self.player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            
            
            
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.player shutdown];
    [self removeNotificationObservers];
    [self.closeBtn removeFromSuperview];
    
}
-(void)removeNotificationObservers{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.player];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:self.player];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.player];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey object:self.player];
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
