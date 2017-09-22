//
//  LF_AccountModel.h
//  LFInke
//
//  Created by slimdy on 2017/5/16.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LF_AccountModel : NSObject<NSCoding>
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *iconUrl;
@property (nonatomic,strong)NSString *gender;
@end
