//
//  AppDelegate.h
//  TesteCipher
//
//  Created by TVTiOS-01 on 22/06/15.
//  Copyright (c) 2015 TVTiOS-01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkConnectionMonitor.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) NetworkConnectionMonitor *networkMonitor;


@end

