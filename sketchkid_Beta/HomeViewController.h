//
//  HomeViewController.h
//  sketchkid_Beta
//
//  Created by Andrea Terzani on 04/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Scale.h"


@interface HomeViewController : UIViewController
{

    UIScrollView *photoShowView;

    

}
- (IBAction)removeInfoButtonAction:(id)sender;
- (IBAction)infoButtonAction:(id)sender;
- (IBAction)kidButtonAction:(id)sender;
- (IBAction)cameraButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *removeInfoButton;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *kidsButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *albumButton;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIToolbar *albumToolbar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *infoButton;

@property (weak, nonatomic) IBOutlet UILabel *albumTitleLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addFavoriteButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@end
