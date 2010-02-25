//
//  YGapAppDelegate.h
//  YGap
//
//  Created by Donald Buchanan on 9/01/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//


#import "URLCacheConnection.h"

@interface YGapAppDelegate : NSObject <UIApplicationDelegate, UIAlertViewDelegate> {
	NSString *dataPath;
	NSMutableArray *urlArray;
	NSError *error;
	
	
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, copy) NSString *dataPath;

@property (nonatomic, retain) NSMutableArray *urlArray;


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

