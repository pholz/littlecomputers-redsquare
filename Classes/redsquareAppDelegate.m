//
//  redsquareAppDelegate.m
//  redsquare
//
//  Created by Peter Holzkorn on 14.02.10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "redsquareAppDelegate.h"
#import "redsquareViewController.h"

@implementation redsquareAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
