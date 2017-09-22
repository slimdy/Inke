//
//  LF_NearLiveCell.h
//  LFInke
//
//  Created by slimdy on 2017/5/13.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LF_HotLiveModel;
@interface LF_NearLiveCell : UICollectionViewCell
@property (nonatomic,strong)LF_HotLiveModel *live;
-(void)startAnimation;
@end
