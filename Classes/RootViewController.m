//
//  RootViewController.m
//  YGap
//
//  Created by Donald Buchanan on 9/01/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import "BlogController.h"
#import "CurrentProjectController.h"
#import "LifeLink.h"
#import "RootViewController.h"
#import "AsyncImageView.h"

@implementation RootViewController

- (IBAction)blog {
	BlogController *blogController = [[BlogController alloc] initWithNibName:@"BlogController" bundle:nil];
	blogController.title = @"Blog";
	[self.navigationController pushViewController:blogController animated:YES];
	[blogController release];
}
- (IBAction)current {
	CurrentProjectController *currentProjectController = [[CurrentProjectController alloc] initWithNibName:@"CurrentProjectController" bundle:nil];
	currentProjectController.title = @"Current Project";
	[self.navigationController pushViewController:currentProjectController animated:YES];
	[currentProjectController release];
}

- (IBAction)life_link {
	LifeLink *life_linkController = [[LifeLink alloc] initWithNibName:@"LifeLink" bundle:nil];
	life_linkController.title = @"LifeLink";
	[self.navigationController pushViewController:life_linkController animated:YES];
	[life_linkController release];
}
/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/


- (void)viewWillAppear:(BOOL)animated {
	self.title = @"YGAP";
    [super viewWillAppear:animated];
}


/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}


@end

