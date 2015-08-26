//
//  DeviceOrientation.m
//
//  Created by Le Ngoc Giang on 8/26/15.
//  Copyright (c) 2015 Le Ngoc Giang. All rights reserved.
//

#import "DeviceOrientation.h"
@import CoreMotion;

@interface DeviceOrientation()

@property (strong, nonatomic) CMMotionManager *motionManager;

@end

@implementation DeviceOrientation
{
    UIInterfaceOrientation orientationLast, orientationAfterProcess;

}

+ (instancetype)sharedInstance
{
    static DeviceOrientation *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[DeviceOrientation alloc]init];
    });
    return _sharedInstance;
}
- (void)initMotionManager
{
    self.motionManager = [[CMMotionManager alloc]init];
    self.motionManager.accelerometerUpdateInterval = 0.2;
    self.motionManager.gyroUpdateInterval = 0.2;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        [self outputAccelertionData:accelerometerData.acceleration];
    }];
}
- (void)create
{
    [self initMotionManager];
}

- (void)outputAccelertionData:(CMAcceleration)acceleration{
    UIInterfaceOrientation orientationNew;
    
    if (acceleration.x >= 0.75) {
        orientationNew = UIInterfaceOrientationLandscapeLeft;
    }
    else if (acceleration.x <= -0.75) {
        orientationNew = UIInterfaceOrientationLandscapeRight;
    }
    else if (acceleration.y <= -0.75) {
        orientationNew = UIInterfaceOrientationPortrait;
    }
    else if (acceleration.y >= 0.75) {
        orientationNew = UIInterfaceOrientationPortraitUpsideDown;
    }
    else {
        // Consider same as last time
        return;
    }
    
    if (orientationNew == orientationLast)
        return;
    
    orientationLast = orientationNew;
    
    self.currentOrientation = orientationLast;

    // Post notification when device changed orientation
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSMutableDictionary *userInfo = [NSMutableDictionary new];
        id orientation  = [NSNumber numberWithInteger:orientationLast];
        [userInfo setObject:orientation forKey:@"orientation"];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"kDeviveChangeOrientation" object:nil userInfo:userInfo];
    });
}



@end
