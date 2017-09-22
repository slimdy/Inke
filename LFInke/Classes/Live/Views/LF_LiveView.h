//
//  LF_LiveView.h
//  LFInke
//
//  Created by slimdy on 2017/5/15.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LF_LaunchViewController;
@interface LF_LiveView : UIView
@property (nonatomic,strong) LF_LaunchViewController *topVC;
-(void)startLive;
-(void)stopLive;
@end
