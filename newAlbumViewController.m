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
@synthesize titoloText;
@synthesize toolBar;


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
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
    [album setDataCreazione:[NSDate date]];
    [album setOrder:[NSDecimalNumber numberWithInt: [am getMaxOrder]+1]];
    
    
    [self.delegate newAlbumViewController:self DidAddAlbum:album];


}

- (IBAction)cancelButtonAction:(id)sender{
    
    [self.delegate newAlbumViewControllerDidCancel:self];
}
@end
