//
//  RootViewController.h
//  YGap
//
//  Created by Donald Buchanan on 9/01/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
	// navigation items
	NSDictionary *main_items;
	NSArray *main_items_keys;
	NSArray *main_items_values;
}


- (IBAction)blog;
- (IBAction)current;
- (IBAction)life_link;

@end
