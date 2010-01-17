//
//  RootViewController.h
//  YGap
//
//  Created by Donald Buchanan on 9/01/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "TouchXML.h"

@class TourController;

@interface RootViewController : UITableViewController {
	// This is the outlet for the blog view, it will allow the data from the controller to be used in a view
// IBOutlet UITableView *blogTable;
	
    // blogEntries is used to store the data retrieved from the RSS feed before being added to the view
    NSMutableArray *blogEntries;
	
    // loadSwirlie will display a loading overlay while the data is downloaded from the RSS feed.
    UIActivityIndicatorView *loadSwirlie;
	
	UITableViewCell *nibLoadedCell;
	
	TourController *tourController;
}

@property (nonatomic, retain) IBOutlet UITableViewCell *nibLoadedCell;
@property (nonatomic, retain) IBOutlet TourController *tourController;
-(IBAction) handleTourTapped;

@end
