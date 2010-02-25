//
//  BlogController.m
//  YGap
//
//  Created by Donald Buchanan on 17/01/10.
//  Copyright 2010 Don Buchanan Solutions Pty Ltd. All rights reserved.
//

#import "BlogController.h"
#import "BlogItemController.h"
#import "AsyncImageView.h"

@implementation BlogController
@synthesize nibLoadedCell;



// grabRSSFeed function that takes a string (blogAddress) as a parameter and
// fills the global blogEntries with the entries
- (void) grabRSSFeed:(NSString *)blogAddress {

	// Initialize the blogEntries MutableArray that we declared in the header
	blogEntries = [[NSMutableArray alloc] init];	

	// Convert the supplied URL string into a usable URL object
	NSURL *url = [NSURL URLWithString: blogAddress];

	// Create a new rssParser object based on the TouchXML "CXMLDocument" class, this is the
	// object that actually grabs and processes the RSS data
	CXMLDocument *rssParser = [[[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:nil] autorelease];

	// Create a new Array object to be used with the looping of the results from the rssParser
	NSArray *resultNodes = NULL;

	// Set the resultNodes Array to contain an object for every instance of an  node in our RSS feed
	resultNodes = [rssParser nodesForXPath:@"//item" error:nil];

	// Loop through the resultNodes to access each items actual data
	for (CXMLElement *resultElement in resultNodes) {
		
		// Create a temporary MutableDictionary to store the items fields in, which will eventually end up in blogEntries
		NSMutableDictionary *blogItem = [[NSMutableDictionary alloc] init];
		
		// Create a counter variable as type "int"
		int counter;
		
		// Loop through the children of the current  node
		for(counter = 0; counter < [resultElement childCount]; counter++) {
			CXMLElement *childNode = (CXMLElement *)[resultElement childAtIndex:counter];
			
			if ([[resultElement childAtIndex:counter] stringValue]	 != nil){
				// Add each field to the blogItem Dictionary with the node name as key and node value as the value
				[blogItem setObject:[childNode stringValue] forKey:[childNode name]];
			}
			else {
				if ([[childNode name] compare:@"thumbnail"] == NSOrderedSame){
					[blogItem setObject:[[childNode attributeForName: @"url"] stringValue] forKey:[childNode name]];
				}
			}
			
		}
		
		// Add the blogItem to the global blogEntries Array so that the view can access it.
		[blogEntries addObject:[blogItem copy]];
	}
}

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
- (void)viewDidAppear:(BOOL)animated {	
    [super viewDidAppear:animated];
    // Check if blogEntries has already been filled, if not
    // then send the request
    if([blogEntries count] == 0) {
        // Create the feed string, in this case I have used dBlog
        NSString *blogAddress = @"http://nickersinatwist.blogspot.com/feeds/posts/default?alt=rss";
		
        // Call the grabRSSFeed function with the above
        // string as a parameter
        [self grabRSSFeed:blogAddress];
		
        // Call the reloadData function on the blogTable, this
        // will cause it to refresh itself with our new data
        [self.tableView reloadData];
    }
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
     return [blogEntries count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [[NSBundle mainBundle] loadNibNamed: @"BlogTableCell" owner:self options:NULL];
	UITableViewCell *cell = nibLoadedCell;
    
	// Configure the cell.
	int blogEntryIndex = [indexPath indexAtPosition: [indexPath length] -1];
	UILabel *titleLabel = (UILabel *)[cell viewWithTag: 1];
	titleLabel.text = [[blogEntries objectAtIndex: blogEntryIndex] objectForKey: @"title"];
	CGRect frame;
	frame.size.width=30; frame.size.height=40;
	frame.origin.x=0; frame.origin.y=0;
	AsyncImageView *thumbnail = (AsyncImageView *)[cell viewWithTag:2];
	
	//thumbnail = [[[AsyncImageView alloc] initWithFrame:frame] autorelease];
	NSString *thumbnail_url = [[blogEntries objectAtIndex: blogEntryIndex] objectForKey: @"thumbnail"];
	if (thumbnail_url != nil){
		NSURL *url = [NSURL URLWithString: thumbnail_url];
		[thumbnail loadImageFromURL: url];
		[cell addSubview:thumbnail];
	}
	
	return cell;
	
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	int blogEntryIndex = [indexPath indexAtPosition: [indexPath length] -1];
	BlogItemController *blogItemController = [[BlogItemController alloc] initWithNibName:@"BlogItemController" bundle:nil];
	blogItemController.url = [[blogEntries objectAtIndex: blogEntryIndex] objectForKey:@"link"];
	[self.navigationController pushViewController:blogItemController animated:YES];
	[blogItemController release];
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

