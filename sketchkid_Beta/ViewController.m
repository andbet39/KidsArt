//
//  ViewController.m
//  sketchkid_Beta
//
//  Created by Andrea Terzani on 04/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize trashButton;
@synthesize frameButton;
@synthesize adjustButton;
@synthesize toolBar;
@synthesize penButton;
@synthesize shareButton;



-(void)creaToolBar{
    
    int toolbarheight=82;

    [toolBar setFrame:CGRectMake(0, self.view.frame.size.height-toolbarheight, 320, toolbarheight)];
    [toolBar setBackgroundImage:[UIImage imageNamed:@"toolbarBack.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    
    
    [penButton setBackgroundVerticalPositionAdjustment:15.0f forBarMetrics:UIBarMetricsDefault];
    [penButton setBackgroundImage:[UIImage imageNamed:@"pen_icon.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [shareButton setBackgroundImage:[UIImage imageNamed:@"pen_icon.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [shareButton setBackgroundVerticalPositionAdjustment:15.0f forBarMetrics:UIBarMetricsDefault];
    
    [trashButton setBackgroundImage:[UIImage imageNamed:@"pen_icon.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [trashButton setBackgroundVerticalPositionAdjustment:15.0f forBarMetrics:UIBarMetricsDefault];
    
    
    [frameButton setBackgroundImage:[UIImage imageNamed:@"pen_icon.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [frameButton setBackgroundVerticalPositionAdjustment:15.0f forBarMetrics:UIBarMetricsDefault];
    
    
    [adjustButton setBackgroundImage:[UIImage imageNamed:@"pen_icon.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [adjustButton setBackgroundVerticalPositionAdjustment:15.0f forBarMetrics:UIBarMetricsDefault];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self creaToolBar];


}

- (void)viewDidUnload
{
    [self setToolBar:nil];
    [self setPenButton:nil];
    [self setShareButton:nil];
    [self setTrashButton:nil];
    [self setFrameButton:nil];
    [self setAdjustButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
