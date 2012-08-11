//
//  EditSketchInfoViewController.h
//  kidsArt
//
//  Created by Andrea Terzani on 10/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SketchManager.h"
#import "Sketch.h"
#import "SelectAlbumViewController.h"

@interface EditSketchInfoViewController : UIViewController <SelectAlbumViewControllerDelegate>
{

    Sketch * editSketch;
    
}

@property (nonatomic,strong)  Sketch * editSketch;

@property (weak, nonatomic) IBOutlet UILabel *albumNameLabel;

- (IBAction)addToAlbumAction:(id)sender;
@end
