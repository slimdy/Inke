//
//  LF_LocationTool.m
//  LFInke
//
//  Created by slimdy on 2017/5/12.
//  Copyright © 2017年 slimdy. All rights reserved.
//

#import "LF_LocationTool.h"
#import <CoreLocation/CoreLocation.h>
@interface LF_LocationTool()<CLLocationManagerDelegate>
@property (nonatomic,strong)CLLocationManager *CLmanager;
@property (nonatomic,copy) locationBlock block;
@end
@implementation LF_LocationTool
static LF_LocationTool *_tool = nil;
+(instancetype)shareLocationTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[LF_LocationTool alloc]init];
    });
    return _tool;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.CLmanager = [[CLLocationManager alloc]init];
        self.CLmanager.desiredAccuracy = kCLLocationAccuracyBest;
        self.CLmanager.distanceFilter = 100;
        self.CLmanager.delegate = self;
        if([CLLocationManager locationServicesEnabled]){
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusNotDetermined) {
                [self.CLmanager requestWhenInUseAuthorization];
            }
        }else{
            NSLog(@"请开启定位");
        }
    }
    return self;
}
-(void)getGps:(locationBlock)successBlock{
    self.block = successBlock;
    NSLog(@"%@",self.CLmanager);
    [self.CLmanager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *newLocation = [locations firstObject];
    CLLocationCoordinate2D coor = newLocation.coordinate;
    NSString *lat = [NSString stringWithFormat:@"%f",coor.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f",coor.longitude];
    if (lat.length && lon.length) {
        self.block(lat,lon);
    }else{
        NSLog(@"定位失败");
        
    }
    [self.CLmanager stopUpdatingLocation];
}


@end
