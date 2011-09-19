//
//  PebbleAppDelegate.h
//  Pebble
//
//  Created by techion on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PebbleViewController.h"

@interface PebbleAppDelegate : UIResponder <UIApplicationDelegate>
{
    PebbleViewController *viewController;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet PebbleViewController *viewController;

@end
