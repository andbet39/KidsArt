//
//  SketchManager.h
//  kidsArt
//
//  Created by Andrea Terzani on 10/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sketch.h"
@interface SketchManager : NSObject
{

    
    

}

@property(nonatomic,strong)Sketch * editedSketch;


+ (id)sharedSketchManager;

@end
