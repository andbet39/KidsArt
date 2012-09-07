//
//  selectCopertinaViewController.m
//  kidsArt
//
//  Created by Andrea Terzani on 07/09/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "selectCopertinaViewController.h"

@interface selectCopertinaViewController ()

@end

@implementation selectCopertinaViewController
@synthesize titleLabel;
@synthesize toolBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bckInserimento.png"]]];
    [toolBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [titleLabel setText:NSLocalizedString(@"SFONDO_ALBUM", nil)];
    
    [titleLabel setFont:[UIFont fontWithName:@"Snickles" size:32]];
    
  

}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setToolBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
