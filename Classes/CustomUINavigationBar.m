//
//  CustomUINavigationBar.m
//  YGap
//
//  Created by Donald Buchanan on 2/02/10.
//  Copyright 2010 Don Buchanan Solutions Pty Ltd. All rights reserved.
//

#import "CustomUINavigationBar.h"


@implementation CustomUINavigationBar
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
	UIImage *image = [UIImage imageNamed:@"ui_nav_bg.png"];
	CGContextTranslateCTM(ctx, 0, image.size.height);
	CGContextScaleCTM(ctx, 1.0, -1.0);
	CGContextDrawTiledImage(ctx, CGRectMake(0, 0, 173, 52), image.CGImage);

}

#pragma mark -
#pragma mark UINavigationDelegate Methods

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
	NSString *title = [viewController title];
	UILabel *myTitleView = [[UILabel alloc] init];
	[myTitleView setFont:[UIFont boldSystemFontOfSize:18]];
	[myTitleView setTextColor:HEXCOLOR(0x80FF0000)];
	
	myTitleView.text = title;
	myTitleView.backgroundColor = [UIColor clearColor];
	[myTitleView sizeToFit];
	viewController.navigationItem.titleView = myTitleView;
	[myTitleView release];
	
	
	//viewController.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.33f green:0.99f blue:0.39 alpha:0.8];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
}
@end
