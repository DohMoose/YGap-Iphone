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
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 if (self = [super initWithStyle:style]) {
 }
 return self;
 }
 */
- (void)viewDidLoad {
    [super viewDidLoad];
	main_items_keys = [NSArray arrayWithObjects:@"LatestNews",@"LifeLink",@"Three States of Mind", @"Get Updates",nil];
	main_items_values = [NSArray arrayWithObjects:
				  @"Activity from around the world", 
				  @"Join our fundraising efforts",
				  @"Follow our boys across Australia",
				  @"Signup to our newsletter",
				  nil];
}

/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
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
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [main_items_keys count];
}

- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath
{
	return 100;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [main_items_keys objectAtIndex:indexPath.row];
	cell.textLabel.textColor = [UIColor colorWithRed: 0.557 green:0.776 blue:0.247 alpha:1.0];
	cell.detailTextLabel.text = [main_items_values objectAtIndex:indexPath.row];
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
		case 0:
			[self blog];
			break;
		case 1:
			[self life_link];
			break;
		case 2:
			[self current];
			break;
			
		default:
			[self blog];
			break;
	}
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
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

