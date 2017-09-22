//
//  LF_LiveCell.m
//  LFInke
//
//  Created by slimdy on 2017/5/10.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_LiveCell.h"
#import "LF_CreatorModel.h"
@interface LF_LiveCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *locationView;
@property (weak, nonatomic) IBOutlet UILabel *onlineUserView;
@property (weak, nonatomic) IBOutlet UIImageView *liveView;


@end
@implementation LF_LiveCell
-(void)setLive:(LF_HotLiveModel *)live{
    _live = live;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:live.creator.portrait] placeholderImage:[UIImage imageNamed:@"default_room"]];
    [self.liveView sd_setImageWithURL:[NSURL URLWithString:live.creator.portrait] placeholderImage:[UIImage imageNamed:@"default_room"]];
    self.nameView.text = live.creator.nick;
    self.locationView.text = live.city;
    self.onlineUserView.text = [@(live.onlineUsers) stringValue];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
