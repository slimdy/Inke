//
//  LF_LocationTool.h
//  LFInke
//
//  Created by slimdy on 2017/5/12.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^locationBlock)(NSString *lat,NSString*lon);
@interface LF_LocationTool : NSObject
+(instancetype)shareLocationTool;
-(void)getGps:(locationBlock)successBlock;
@end
