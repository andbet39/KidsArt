//
//  SegueWithNoAnimation.m
//  kidsArt
//
//  Created by Andrea Terzani on 08/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "SegueWithNoAnimation.h"

@implementation SegueWithNoAnimation
- (void)perform
{
    // add your own animation code here
    
    [[self sourceViewController] presentModalViewController:[self destinationViewController] animated:NO];
}




@end
