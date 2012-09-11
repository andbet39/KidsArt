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
@synthesize imageFaccina;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"selectFaccina"])
    {
        selectFaccinaViewController * selectFaccinaView=(selectFaccinaViewController*) [segue destinationViewController];
        [selectFaccinaView setDelegate:self];
    }
    
    
}

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
    [self setImageFaccina:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)selectFaccinaButtonAction:(id)sender {
    
    [self performSegueWithIdentifier:@"selectFaccina" sender:self];
    
}

- (IBAction)saveButtonAction:(id)sender {
    DataManager *dm =[DataManager sharedDataManager];
    
    Kid *kid = (Kid *)[NSEntityDescription insertNewObjectForEntityForName:@"Kid" inManagedObjectContext:dm.managedObjectContext];
    
    [kid setNome:nomeText.text];
    if (imageFaccinaString) {
        [kid setPhotoPath:imageFaccinaString];

    }else{
        [kid setPhotoPath:@"bambinoDefault"];
    }
    
    
    [self.delegate NewKidViewController:self DidAddKid:kid];
}

- (IBAction)cancelButtonAction:(id)sender {
    
    [self.delegate NewKidViewControllerDidCancel:self];
}


#pragma mark selectCopertinaViewControllerDelegate

-(void)selectFaccinaDidCancel
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)selectFaccina:(selectFaccinaViewController *)sender didSelectFaccina:(NSString *)faccinaPath
{
    
    [self.imageFaccina setImage:[UIImage imageNamed:faccinaPath]];
    imageFaccinaString=faccinaPath;
    
    [self dismissModalViewControllerAnimated:YES];
    
}


@end
