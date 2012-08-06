//
//  kidsViewController.h
//  sketchkid_Beta
//
//  Created by Andrea Terzani on 05/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Scale.h"
#import "newKidViewController.h"
#import "GMGridView.h"
#import "DataManager.h"

@interface kidsViewController : UIViewController   <GMGridViewDataSource, GMGridViewActionDelegate, NewKidViewControllerDelegate>
{

    GMGridView *_gmGridView;
    NSMutableArray * kidsArray;
    
    NSInteger _lastDeleteItemIndexAsked;


}
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)enableEditButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@end
