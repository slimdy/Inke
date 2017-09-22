//
//  LF_UserInfoView.m
//  LFInke
//
//  Created by slimdy on 2017/5/16.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_UserInfoView.h"
#import "LF_ArchiveTool.h"
#import "LF_AccountModel.h"
@interface LF_UserInfoView()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@end

@implementation LF_UserInfoView

+(instancetype)loadUserInfoView{
    return [[[NSBundle mainBundle] loadNibNamed:@"LF_UserInfoView" owner:self options:nil] lastObject];
}
-(void)awakeFromNib{
    [super awakeFromNib];
    LF_AccountModel *account =  [LF_ArchiveTool getAccount];
    if (!account) {
        return;
    }
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:account.iconUrl] placeholderImage:[UIImage imageNamed:@"room_default"]];
    [self.nameView setText:account.name];
    
}
@end
