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
@synthesize addBambinoButton;
@synthesize editSketch;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AlbumManager *am = [AlbumManager sharedAlbumManager];
    [albumNameLabel setText:am.selectedAlbum.titolo];
    
    
    NSString * nomeBimbo = editSketch.kid.nome;
    
    if([nomeBimbo isEqualToString:@""])
    {
        nomeBimbo=@"Di chi è?";
    }else{
    
        
    }
    
    [addBambinoButton setTitle:nomeBimbo forState:UIControlStateNormal];
    
    
}

- (void)viewDidUnload
{
    [self setAlbumNameLabel:nil];
    [self setAddBambinoButton:nil];
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
    
    if ([segue.identifier isEqualToString:@"selectKid"])
    {
        SelectKidViewController * selectKidView=(SelectKidViewController*) [segue destinationViewController];
        [selectKidView setDelegate:self];
    }
}

- (IBAction)addToAlbumAction:(id)sender {
    
    [self performSegueWithIdentifier:@"selectAlbum" sender:self];
    
}

- (IBAction)selectKidButtonAction:(id)sender {
    
    [self performSegueWithIdentifier:@"selectKid" sender:self];
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

-(void)SelectKidViewControllerr:(SelectKidViewController*)sender DidSelectKid:(Kid*)kid{

    [editSketch setKid:kid];

    DataManager *dm = [DataManager  sharedDataManager];
    
    NSManagedObjectContext *context = [dm managedObjectContext];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]){
        NSLog(@"Error on save");
    }
    
    [addBambinoButton setTitle:kid.nome forState:UIControlStateNormal];

    [self.navigationController popViewControllerAnimated:YES];
}
@end
