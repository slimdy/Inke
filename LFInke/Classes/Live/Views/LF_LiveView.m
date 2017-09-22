//
//  LF_LiveView.m
//  LFInke
//
//  Created by slimdy on 2017/5/15.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_LiveView.h"
#import "LF_LaunchViewController.h"
@interface LF_LiveView()<LFLiveSessionDelegate>
@property (nonatomic,strong)UIButton *beautyButton;
@property (nonatomic,strong)UIButton *cameraButton;
@property (nonatomic,strong)UIButton *closeButton;
@property (nonatomic,strong)UIView *container;
@property (nonatomic,strong)LFLiveSession *session;
@property (nonatomic,strong)UILabel *stateLabel;
@end
@implementation LF_LiveView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.container];
        [self requestAccessForAudio];
        [self requestAccessForVideo];
        [self.container addSubview:self.beautyButton];
        [self.container addSubview:self.cameraButton];
        [self.container addSubview:self.closeButton];
        [self.container addSubview:self.stateLabel];
    }
    return self;
}
-(void)requestAccessForVideo{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    /*
     AVAuthorizationStatusNotDetermined = 0, //是否允许状态没有决定
     AVAuthorizationStatusRestricted,//用户明确拒绝，找不到设备
     AVAuthorizationStatusDenied,//用户拒绝
     AVAuthorizationStatusAuthorized//用户授权
     */
    @weakify(self);
    switch (status) {
        case AVAuthorizationStatusNotDetermined:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    @strongify(self);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.session setRunning:YES];
                    });
                }
            }];
            break;
        }
        case AVAuthorizationStatusDenied:
        case  AVAuthorizationStatusRestricted:{
            [MBProgressHUD showError:@"请给予录制视频的权限"];
            break;
        }
        case AVAuthorizationStatusAuthorized:
        {
           
            dispatch_async(dispatch_get_main_queue(), ^{
                 @strongify(self);
                [self.session setRunning:YES];
            });
            
            break;
        }
            
        default:
            break;
    }
}
-(void)requestAccessForAudio{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    /*
     AVAuthorizationStatusNotDetermined = 0, //是否允许状态没有决定
     AVAuthorizationStatusRestricted,//用户明确拒绝，找不到设备
     AVAuthorizationStatusDenied,//用户拒绝
     AVAuthorizationStatusAuthorized//用户授权
     */
    
    switch (status) {
        case AVAuthorizationStatusNotDetermined:{
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                if (granted) {
                    
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:{
            break;
        }
        case AVAuthorizationStatusRestricted:
        case AVAuthorizationStatusDenied:{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"请给予麦克风权限"];
            });
        }
        default:
            break;
    }
    
}
#pragma mark --- 控件懒加载
-(LFLiveSession *)session{
    if (_session == nil) {
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
        _session.delegate = self;
        _session.showDebugInfo = NO;
        _session.preView = self;
    }
    return _session;
}
-(UIButton *)beautyButton{
    if (!_beautyButton) {
        _beautyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_beautyButton setImage:[UIImage imageNamed:@"camra_beauty"] forState:UIControlStateNormal];
        [_beautyButton setImage:[UIImage imageNamed:@"camra_beauty_close"] forState:UIControlStateSelected];
        [_beautyButton sizeToFit];
        _beautyButton.exclusiveTouch = YES;
        @weakify(self);
        [_beautyButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self);
            self.session.beautyFace = !self.session.beautyFace;
            self.beautyButton.selected=!self.beautyButton.selected;
        }];
    }
    return _beautyButton;
}
-(UIButton *)cameraButton{
    if (!_cameraButton) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraButton setImage:[UIImage imageNamed:@"camra_preview"] forState:UIControlStateNormal];
        [_cameraButton sizeToFit];
        _cameraButton.exclusiveTouch = YES;
        @weakify(self);
        [_cameraButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self);
            AVCaptureDevicePosition devicePosion = [self.session captureDevicePosition];
            self.session.captureDevicePosition = (devicePosion == AVCaptureDevicePositionBack)?AVCaptureDevicePositionFront:AVCaptureDevicePositionBack;
        }];
    }
    return _cameraButton;
}
-(UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"close_preview"] forState:UIControlStateNormal];
        [_closeButton sizeToFit];
        _closeButton.exclusiveTouch = YES;
        @weakify(self);
        [_closeButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            @strongify(self);
            [self.topVC dismissViewControllerAnimated:YES completion:nil];
            [self stopLive];
            
        }];
    }
    return _closeButton;
}
-(UIView *)container{
    if (!_container) {
        _container = [[UIView alloc]initWithFrame:self.bounds];
        _container.backgroundColor = [UIColor clearColor];
    }
    return _container;
}
-(UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.text = @"未连接";
        [_stateLabel sizeToFit];
        _stateLabel.textColor = [UIColor whiteColor];
        _stateLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _stateLabel;
}
#pragma mark----LFLiveSessionDelegate
//连接状态发生改变时触发
-(void)liveSession:(LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    switch (state) {
        case LFLiveReady:
            self.stateLabel.text = @"未连接";
            break;
        case LFLivePending:
            self.stateLabel.text = @"连接中";
            break;
        case LFLiveStart:
            self.stateLabel.text = @"已连接";
            break;
        case LFLiveError:
            self.stateLabel.text = @"连接出错";
            break;
        case LFLiveStop:
            self.stateLabel.text = @"未连接";
            break;
        case LFLiveRefresh:
            self.stateLabel.text = @"正在刷新";
            break;
    }
    [self.stateLabel sizeToFit];
}
-(void)layoutSubviews{
    CGFloat margin = 30;
    CGFloat stateX = 20;
    CGFloat stateY = 30;
    self.stateLabel.origin = CGPointMake(stateX, stateY);
    
    CGFloat btnW = self.closeButton.width;
    self.closeButton.origin = CGPointMake(SCREEN_WIDTH-margin-btnW, margin);
    
    self.cameraButton.origin = CGPointMake(SCREEN_WIDTH-2*margin-btnW*2, margin);
    
    self.beautyButton.origin = CGPointMake(SCREEN_WIDTH-3*margin-btnW*3, margin);
    
}
#pragma mark --- 自定义开启关闭直播
-(void)startLive{
    LFLiveStreamInfo *stream = [[LFLiveStreamInfo alloc]init];
    stream.url = MyLiveRoom;
    [self.session startLive:stream];
    
    
}
-(void)stopLive{
    [self.session stopLive];
}
@end
