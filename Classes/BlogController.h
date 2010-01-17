//
//  BlogController.h
//  YGap
//
//  Created by Donald Buchanan on 17/01/10.
//  Copyright 2010 Don Buchanan Solutions Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchXML.h"

@interface BlogController : UITableViewController {
	// blogEntries is used to store the data retrieved from the RSS feed before being added to the view
    NSMutableArray *blogEntries;
	
    // loadSwirlie will display a loading overlay while the data is downloaded from the RSS feed.
    UIActivityIndicatorView *loadSwirlie;
	
	UITableViewCell *nibLoadedCell;

}
@property (nonatomic, retain) IBOutlet UITableViewCell *nibLoadedCell;

@end
