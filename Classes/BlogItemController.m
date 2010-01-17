//
//  BlogItemController.m
//  YGap
//
//  Created by Donald Buchanan on 11/01/10.
//  Copyright 2010 Don Buchanan Solutions Pty Ltd. All rights reserved.
//

#import "BlogItemController.h"


@implementation BlogItemController
@synthesize blogItemView;
@synthesize url;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	NSURL *url_request = [[NSURL alloc] initWithString: url]; 
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url_request]; 
	[blogItemView loadRequest: request]; 
	[request release]; 
	[url_request release];
}

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


- (void)dealloc {
    [super dealloc];
}


@end
