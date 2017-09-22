//
//  LF_ShowTopView.h
//  LFInke
//
//  Created by slimdy on 2017/5/9.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LF_ShowTopView;
@protocol LF_ShowTopViewDelegate<NSObject>
@optional
- (void)showTopView:(LF_ShowTopView *)topView didClickButton:(UIButton *)btn;
@end
@interface LF_ShowTopView : UIView
@property (nonatomic,strong)NSArray *titleNames;
@property (nonatomic,weak)id<LF_ShowTopViewDelegate> delegate;
-(void)scrolling:(NSInteger )index;
@end
