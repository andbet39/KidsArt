//
//  newKidViewController.m
//  sketchkid_Beta
//
//  Created by Andrea Terzani on 06/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "newKidViewController.h"
#import "Kid.h"
#import "DataManager.h"


@interface newKidViewController ()

@end

@implementation newKidViewController
@synthesize nomeText;
@synthesize toolBar;
@synthesize titleLabel;

-(void)creaNavigationBar{
    
    
    [toolBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [titleLabel setText:NSLocalizedString(@"NUOVO_BAMBINO", nil)];
    
    [titleLabel setFont:[UIFont fontWithName:@"Snickles" size:32]];
    
    nomeText.placeholder = NSLocalizedString(@"NOME", nil);
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    [self creaNavigationBar];
}

- (void)viewDidUnload
{
    [self setNomeText:nil];
    [self setToolBar:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)saveButtonAction:(id)sender {
    DataManager *dm =[DataManager sharedDataManager];
    
    Kid *kid = (Kid *)[NSEntityDescription insertNewObjectForEntityForName:@"Kid" inManagedObjectContext:dm.managedObjectContext];
    
    [kid setNome:nomeText.text];
    [kid setPhotoPath:@"bambinoDefault"];
    
    [self.delegate NewKidViewController:self DidAddKid:kid];
}

- (IBAction)cancelButtonAction:(id)sender {
    
    [self.delegate NewKidViewControllerDidCancel:self];
}
@end
