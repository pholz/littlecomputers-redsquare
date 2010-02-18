//
//  redsquareAppDelegate.h
//  redsquare
//
//  Created by Peter Holzkorn on 14.02.10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class redsquareViewController;

@interface redsquareAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    redsquareViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet redsquareViewController *viewController;

@end

