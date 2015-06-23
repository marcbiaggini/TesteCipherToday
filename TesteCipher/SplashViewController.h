//
//  ViewController.h
//  TesteCipher
//
//  Created by TVTiOS-01 on 22/06/15.
//  Copyright (c) 2015 TVTiOS-01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkConnectionMonitor.h"
#import "BusyIndicatorController.h"


@interface SplashViewController : UIViewController
@property (strong,nonatomic) NetworkConnectionMonitor *networkMonitor;
@property (strong,nonatomic)  NSMutableArray *dataList;
@property (strong, nonatomic) UIActivityIndicatorView *busyView ;


@end

