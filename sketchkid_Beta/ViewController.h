//
//  ViewController.h
//  sketchkid_Beta
//
//  Created by Andrea Terzani on 04/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//
#import <Twitter/Twitter.h>
#import <UIKit/UIKit.h>
#import "Sketch.h"
#import "SketchManager.h"
#import "EditSketchInfoViewController.h"
#import "AdjustView.h"
#import "FrameSelectView.h"
#import "UIView+Animation.h"
#import "ShareView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface ViewController : UIViewController<AdjustViewDelegate,ShareViewDelegate>
{


    bool isAdjustVisible;
    bool isFrameVisible;
    bool isShareVisible;
    
    AdjustView * adjustView;
    FrameSelectView * frameView;
    ShareView * shareView;
    
    
    CIContext *context;
    CIFilter * controlFilter;
    

}

@property (strong, nonatomic) FBRequestConnection *requestConnection;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *penButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *trashButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *frameButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *adjustButton;

@property (weak, nonatomic) IBOutlet UINavigationBar *fintaNavigationBar;

@property (strong,nonatomic)Sketch * currentSketch;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

- (IBAction)editInfoButton:(id)sender;
- (IBAction)saveButtonAction:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)adjustButtonAction:(id)sender;
- (IBAction)frameButtonAction:(id)sender;
- (IBAction)sharebuttonAction:(id)sender;

@end
