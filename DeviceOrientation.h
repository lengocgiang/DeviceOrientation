//
//  DeviceOrientation.h
//
//  Created by Le Ngoc Giang on 8/26/15.
//  Copyright (c) 2015 Le Ngoc Giang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceOrientation : NSObject

@property (assign, nonatomic) UIInterfaceOrientation currentOrientation;

+ (instancetype)sharedInstance;

- (void)create;
@end
