//
//  SketchManager.m
//  kidsArt
//
//  Created by Andrea Terzani on 10/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "SketchManager.h"
static SketchManager *sharedSketchManager = nil;

@implementation SketchManager
@synthesize editedSketch;


#pragma mark Singleton Methods
+ (id)sharedSketchManager {
    @synchronized(self) {
        if (sharedSketchManager == nil)
            sharedSketchManager = [[self alloc] init];
    }
    return sharedSketchManager;
}



@end
