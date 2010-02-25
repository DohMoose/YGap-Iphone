//
//  CustomUINavigationBar.h
//  YGap
//
//  Created by Donald Buchanan on 2/02/10.
//  Copyright 2010 Don Buchanan Solutions Pty Ltd. All rights reserved.
//
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>24)&0xFF)/255.0 \
green:((c>>16)&0xFF)/255.0 \
blue:((c>>8)&0xFF)/255.0 \
alpha:1.0]
#import <Foundation/Foundation.h>


@interface CustomUINavigationBar : UINavigationBar<UINavigationControllerDelegate> {

}

@end
