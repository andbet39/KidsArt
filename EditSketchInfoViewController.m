//
//  EditSketchInfoViewController.m
//  kidsArt
//
//  Created by Andrea Terzani on 10/08/12.
//  Copyright (c) 2012 Andrea Terzani. All rights reserved.
//

#import "EditSketchInfoViewController.h"

@interface EditSketchInfoViewController ()

@end

@implementation EditSketchInfoViewController
@synthesize albumNameLabel;
@synthesize editSketch;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AlbumManager *am = [AlbumManager sharedAlbumManager];
    [albumNameLabel setText:am.selectedAlbum.titolo];
    
    
    
}

- (void)viewDidUnload
{
    [self setAlbumNameLabel:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	
    
    if ([segue.identifier isEqualToString:@"selectAlbum"])
    {
        SelectAlbumViewController * selectAlbumView=(SelectAlbumViewController*) [segue destinationViewController];
        [selectAlbumView setDelegate:self];
    }
}

- (IBAction)addToAlbumAction:(id)sender {
    
    [self performSegueWithIdentifier:@"selectAlbum" sender:self];
    
}

-(void)SelectAlbumViewController:(SelectAlbumViewController*)sender DidSelectAlbum:(Album*)album{

    [album addAlbum2sketchObject:editSketch];

    DataManager *dm = [DataManager  sharedDataManager];

    NSManagedObjectContext *context = [dm managedObjectContext];

    // Save the context.
    NSError *error = nil;
    if (![context save:&error]){
        NSLog(@"Error on save");
    }

    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
