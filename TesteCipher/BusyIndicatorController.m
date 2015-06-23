//
//  BusyIndicatorController.m
// GranjaIN
//
//  Copyright (c) 2014 Integru. All rights reserved.
//


#import "BusyIndicatorController.h"

@implementation BusyIndicatorController

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}


+ (UIActivityIndicatorView *)getActivityIndicator:(UIView *)aView
{
    
    // Create the new busy indicator
    UIActivityIndicatorView *busyView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    // Change the type, size and add the black frame
    busyView.bounds = CGRectMake(0, 0, 100, 100);
    busyView.hidesWhenStopped = YES;
    busyView.alpha = 0.7f;
    busyView.backgroundColor = [UIColor blackColor];
    busyView.layer.cornerRadius = 10.0f;//50;
    
    // Center the display and add to the view
    busyView.center = aView.center;
    [aView addSubview:busyView];
    [aView bringSubviewToFront:busyView];

    
    // Return the busyview
    return busyView;
    
}


+ (void)startBusyIndicator:(UIActivityIndicatorView *)aView
{
    
    // Block the view and start the animation
    [aView startAnimating];
    // Start to ignore events
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
}


+ (void)stopBusyIndicator:(UIActivityIndicatorView *)aView
{
    
    // Unblock the view and stop the animation
    [aView stopAnimating];
    // Finish to ignore events
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    
}


@end