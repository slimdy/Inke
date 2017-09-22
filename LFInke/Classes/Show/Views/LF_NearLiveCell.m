//
//  LF_NearLiveCell.m
//  LFInke
//
//  Created by slimdy on 2017/5/13.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_NearLiveCell.h"
#import "LF_HotLiveModel.h"
@interface LF_NearLiveCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end
@implementation LF_NearLiveCell
-(void)setLive:(LF_HotLiveModel *)live{
    _live = live;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:live.creator.portrait] placeholderImage:[UIImage imageNamed:@"default_room"]];
    self.distanceLabel.text = live.distance;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)startAnimation{
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:1 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    self.live.show = YES;
}
@end
