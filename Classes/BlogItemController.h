//
//  BlogItemController.h
//  YGap
//
//  Created by Donald Buchanan on 11/01/10.
//  Copyright 2010 Don Buchanan Solutions Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BlogItemController : UIViewController {
	UIWebView *blogItemView;
	NSString *url;
}

@property (nonatomic, retain) IBOutlet UIWebView *blogItemView;
@property (nonatomic, retain) NSString *url;
@end
