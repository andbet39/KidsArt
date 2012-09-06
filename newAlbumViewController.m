//
//  newAlbumViewController.m
//  kidsArt
//
//  Created by Andrea Terzani on 10/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "newAlbumViewController.h"

@interface newAlbumViewController ()

@end

@implementation newAlbumViewController
@synthesize saveButton;
@synthesize titleLable;
@synthesize titoloText;
@synthesize noteText;
@synthesize toolBar;



-(void) configuraView
{

    [toolBar setBackgroundImage:[UIImage imageNamed:@"navigationBar.png"] forBarMetrics:UIBarMetricsDefault];

    [titleLable setText:NSLocalizedString(@"NUOVO_ALBUM", nil)];

    [titleLable setFont:[UIFont fontWithName:@"Snickles" size:32]];



}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configuraView];

}

- (void)viewDidUnload
{
    [self setSaveButton:nil];
    [self setTitleLable:nil];
    [self setNoteText:nil];
    [super viewDidUnload];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}


- (IBAction)saveButtonAction:(id)sender{

    DataManager *dm =[DataManager sharedDataManager];
    AlbumManager *am = [AlbumManager sharedAlbumManager];
    
    
    Album *album = (Album *)[NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:dm.managedObjectContext];
    
    [album setTitolo:titoloText.text];
    [album setNote:noteText.text];
    [album setDataCreazione:[NSDate date]];
    [album setOrder:[NSDecimalNumber numberWithInt: [am getMaxOrder]+1]];
    
    
    [self.delegate newAlbumViewController:self DidAddAlbum:album];


}

- (IBAction)cancelButtonAction:(id)sender{
    
    [self.delegate newAlbumViewControllerDidCancel:self];
}
@end
