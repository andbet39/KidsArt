//
//  ViewController.h
//  sketchkid_Beta
//
//  Created by Andrea Terzani on 04/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//
#import <Twitter/Twitter.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Sketch.h"
#import "SketchManager.h"
#import "EditSketchInfoViewController.h"
#import "AdjustView.h"
#import "FrameSelectView.h"
#import "UIView+Animation.h"
#import "ShareView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "ATScrollView.h"
#import "AppDelegate.h"
#import "ATPhotoScrollView.h"

@interface ViewController : UIViewController<AdjustViewDelegate,ShareViewDelegate,ATPhotoScrollViewDelegate,FrameSelectViewDelegate,MFMailComposeViewControllerDelegate>
{


    bool isAdjustVisible;
    bool isFrameVisible;
    bool isShareVisible;
    bool isInterfaceVisible;
    
    
    AdjustView * adjustView;
    FrameSelectView * frameView;
    ShareView * shareView;
    
    Album * currentAlbum;
    NSMutableArray * sketchArray;
    
    
    CIContext *context;
    CIFilter * controlFilter;
    
 
}

@property (strong, nonatomic) FBRequestConnection *requestConnection;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet ATPhotoScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *toolBar;
@property (weak, nonatomic) IBOutlet UIButton *penButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *trashButton;
@property (weak, nonatomic) IBOutlet UIButton *frameButton;
@property (weak, nonatomic) IBOutlet UIButton *adjustButton;

@property (weak, nonatomic) IBOutlet UINavigationBar *fintaNavigationBar;

@property (strong,nonatomic)Sketch * currentSketch;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *frameImageView;


- (IBAction)editInfoButton:(id)sender;
- (IBAction)saveButtonAction:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)adjustButtonAction:(id)sender;
- (IBAction)frameButtonAction:(id)sender;
- (IBAction)sharebuttonAction:(id)sender;
- (IBAction)deleteButtonAction:(id)sender;

@end
