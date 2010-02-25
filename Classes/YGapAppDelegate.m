//
//  YGapAppDelegate.m
//  YGap
//
//  Created by Donald Buchanan on 9/01/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "YGapAppDelegate.h"
#import "RootViewController.h"
#import "URLCacheAlert.h"
/* cache update interval in seconds */
const double URLCacheInterval = 86400.0;

@interface NSObject (PrivateMethods)

- (void) initCache;
- (void) clearCache;

@end

@implementation YGapAppDelegate

@synthesize urlArray;
@synthesize dataPath;
@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
   	/* By default, the Cocoa URL loading system uses a small shared memory cache. 
	 We don't need this cache, so we set it to zero when the application launches. */
	
    /* turn off the NSURLCache shared cache */
    
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 
                                                            diskCapacity:0 
                                                                diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    [sharedCache release];
    
    /* prepare to use our own on-disk cache */
	[self initCache];
	
    /* create and load the URL array using the strings stored in URLCache.plist */
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"URLCache" ofType:@"plist"];
    if (path) {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
        self.urlArray = [[NSMutableArray alloc] init];
        for (NSString *element in array) {
            [self.urlArray addObject:[NSURL URLWithString:element]];
        }
        [array release];
    }
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}

- (void) initCache
{
	/* create path to cache directory inside the application's Documents directory */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.dataPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"URLCache"];
	
	/* check for existence of cache directory */
	if ([[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
		return;
	}
	
	/* create a new cache directory */
	if (![[NSFileManager defaultManager] createDirectoryAtPath:dataPath 
								   withIntermediateDirectories:NO
													attributes:nil 
														 error:&error]) {
		URLCacheAlertWithError(error);
		return;
	}
}


/* removes every file in the cache directory */

- (void) clearCache
{
	/* remove the cache directory and its contents */
	if (![[NSFileManager defaultManager] removeItemAtPath:dataPath error:&error]) {
		URLCacheAlertWithError(error);
		return;
	}
	
	/* create a new cache directory */
	if (![[NSFileManager defaultManager] createDirectoryAtPath:dataPath 
								   withIntermediateDirectories:NO
													attributes:nil 
														 error:&error]) {
		URLCacheAlertWithError(error);
		return;
	}
	
}	



/*
 ------------------------------------------------------------------------
 UIAlertViewDelegate protocol method
 ------------------------------------------------------------------------
 */

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0) {
		/* the user clicked the Cancel button */
        return;
    }
	
	[self clearCache];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[dataPath release];
	[urlArray release];
	
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

