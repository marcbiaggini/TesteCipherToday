//
//  BusyIndicatorController.h
//  GranjaIN
//
//  Created by Admin on 2/23/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusyIndicatorController : UIView

+ (UIActivityIndicatorView *)getActivityIndicator:(UIView*)aView;
+ (void)startBusyIndicator:(UIActivityIndicatorView*)aView;
+ (void)stopBusyIndicator:(UIActivityIndicatorView*)aView;

@end
