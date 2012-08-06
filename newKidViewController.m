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

-(void)creaNavigationBar{
    
    
    [toolBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    
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
    
    
    [self.delegate NewKidViewController:self DidAddKid:kid];
}
@end
