//
//  YGapAppDelegate.h
//  YGap
//
//  Created by Donald Buchanan on 9/01/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

@interface YGapAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

