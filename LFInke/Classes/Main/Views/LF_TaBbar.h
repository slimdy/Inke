//
//  LF_TaBbar.h
//  LFInke
//
//  Created by slimdy on 2017/5/8.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LF_TaBbar;

typedef NS_ENUM(NSInteger,LFItemType) {
    LFItemTypeLive = 0,//展示直播
    LFItemTypeMe = 1,//我的
    LFItemTypeLaunch = 2,//启动直播
};


@protocol LF_TabBarDelegate <NSObject>
-(void)tabbar:(LF_TaBbar *)tabBar DidClickedButton:(LFItemType)LFItemTypeEnum;
@end
@interface LF_TaBbar : UIView
@property (nonatomic,weak)id<LF_TabBarDelegate> delegate;
@property (nonatomic,strong)NSArray *imagesNameArr;
@end
